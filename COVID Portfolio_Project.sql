SELECT Location,date,total_cases, new_cases, total_deaths, population FROM Portfolio_Project..CovidDeaths 
order by 1,2

-- Total Cases VS Total Deaths ( Shows liklihood of dying by covid in your country )

SELECT Location,date,total_cases,total_deaths, (total_deaths / total_cases)*100 AS Death_Percentage FROM Portfolio_Project..CovidDeaths
WHERE Location LIKE '%India%'
order by 1,2

-- Total Cases VS Population ( Shows what Percentage of population got Covid )

SELECT Location,date,Population,total_cases, (total_cases/Population)*100 AS Percent_Population_Infected FROM Portfolio_Project..CovidDeaths
WHERE Location LIKE '%India%'
order by 1,2

-- Looking at Countries with Highest Infection Rate Compared to Population

SELECT Location,Population,MAX(total_cases) As Highest_Infection_Count, Max((total_cases/Population))*100 AS Percent_Population_Infected FROM Portfolio_Project..CovidDeaths
GROUP BY Location,Population
order by Percent_Population_Infected desc

-- Showing Countries with the Highest Death Count per Population

SELECT Location,MAX(cast(total_deaths as int)) As TotalDeathCount  FROM Portfolio_Project..CovidDeaths
WHERE continent is not null
GROUP BY Location
order by TotalDeathCount desc

-- Showing Continents With the Highest Death Counts per Population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Portfolio_Project..CovidDeaths
Where continent is not null
Group by continent
ORDER BY TotalDeathCount desc

SELECT * FROM Portfolio_Project..CovidVaccination

SELECT * FROM Portfolio_Project..CovidDeaths dea
JOIN Portfolio_Project..CovidVaccination vac
ON dea.location = vac.location and dea.date = vac.date


-- Looking at Total Population VS Vaccination

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations FROM Portfolio_Project..CovidDeaths dea
JOIN Portfolio_Project..CovidVaccination vac
ON dea.location = vac.location and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3







