
select * 
from covidDeaths
where continent is not null
order by 3,4


--select * 
--from covidReproduction
--where continent is not null
--order by 3,4

--- select Data that we are going to be using
select location, date, total_cases, new_cases, total_deaths, population
from covidDeaths
where continent is not null
order by 1,2

-- looking at total cases vs total deaths
-- shows likelihood of dying if you contract covid in your country
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from covidDeaths
where location like '%states%' and continent is not null
order by 1,2

-- looking at the total cases vs Population
-- shows what percentage of the population got covid
select location, date, population, total_cases, (total_cases/population)*100 as InfectedPercentage
from covidDeaths
--where location like '%states%' and continent is not null
order by 1,2

-- looking at  countries with highest infection rate compared to Population.
select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as InfectedPercentage
from covidDeaths
--where location like '%states%' and continent is not null
group by location, population
order by InfectedPercentage desc

-- showing countries with highest death count per population
select location, MAX(cast(total_deaths as int)) as TotalDeathCount
from covidDeaths
--where location like '%states%' and continent is not null
where continent is not null
group by location
order by TotalDeathCount desc

--LET'S BREAK THINGS DOWN BY CONTINENT
select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from covidDeaths
--where location like '%states%' and continent is not null
where continent is not null
group by continent
order by TotalDeathCount desc

-- continents with the highest death count per population
select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from covidDeaths
--where location like '%states%' and continent is not null
where continent is not null
group by continent
order by TotalDeathCount desc  

--Global Numbers
select SUM(new_cases) as total_cases,
SUM(cast(new_deaths as int)) as total_deaths,
SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
from covidDeaths
--where location '%states%' and continent is not null
where continent is not null
--Group by date
order by 1,2

-- looking at total population
Select dea.continent,dea.location,dea.date,dea.population
from covidDeaths dea
join covidReproduction rep
	on dea.location = rep.location
	and dea.date = rep.date
where dea.continent is not null
order by 2,3


