CREATE OR REPLACE VIEW coviddeaths1.covid.deaths_analysis AS(
WITH relevant_deaths AS(
   SELECT date,
   continent,
   location, 
   ROW_NUMBER() OVER (PARTITION BY location ORDER BY date DESC) AS latest_record,   
         total_cases, 
         total_deaths,
         ROUND (total_deaths / total_cases * 100 ,2) AS fatality_rate,
         ROUND (total_deaths / population * 100 ,2) AS death_percent_pop,
         ROUND (total_cases / population * 100 ,2) AS percentage_infected,
         population,
         gdp_per_capita       
FROM coviddeaths1.covid.deaths
WHERE date BETWEEN '2020-01-01' AND '2025-12-31'
AND continent IS NOT NULL
AND gdp_per_capita IS NOT NULL)
--------------------------------------------
  SELECT continent, 
         location AS country,
         total_cases,
         total_deaths,
         fatality_rate,
         death_percent_pop,
         percentage_infected,
         population,
         gdp_per_capita     
  FROM relevant_deaths
  WHERE latest_record = 1
  AND fatality_rate IS NOT NULL
  AND gdp_per_capita IS NOT NULL
  ORDER BY total_deaths DESC)
--------------------------------------------
SELECT * 
FROM coviddeaths1.covid.deaths_analysis
