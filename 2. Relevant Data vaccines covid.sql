CREATE OR REPLACE VIEW coviddeaths1.covid.vaccines_analysis AS(
WITH relevant_vaccines AS(
   SELECT date,
   continent,
   location, 
   people_vaccinated,
   people_fully_vaccinated,
   gdp_per_capita,  
   ROW_NUMBER() OVER (PARTITION BY location ORDER BY date DESC) AS latest_record
   FROM coviddeaths1.covid.vaccinations
   WHERE date BETWEEN '2020-01-01' AND '2025-12-31'
   AND continent IS NOT NULL
   AND gdp_per_capita IS NOT NULL)
--------------------------------------------
SELECT continent, 
         location AS country,
         CAST(people_vaccinated AS NUMERIC) AS people_vaccinated,
         CAST(people_fully_vaccinated AS NUMERIC) AS people_fully_vaccinated,
         gdp_per_capita,         
  FROM  relevant_vaccines
  WHERE latest_record = 1
  AND people_vaccinated IS NOT NULL
  AND people_fully_vaccinated IS NOT NULL
  AND gdp_per_capita IS NOT NULL)
  --------------------------------------------
  SELECT * 
  FROM coviddeaths1.covid.vaccines_analysis
