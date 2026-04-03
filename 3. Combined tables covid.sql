CREATE OR REPLACE VIEW coviddeaths1.covid.deaths_vaccines AS(
  SELECT d.continent,
d.country,
d.total_cases,
d.total_deaths,
v.people_vaccinated,
v.people_fully_vaccinated AS fully_vaccinated,
d.fatality_rate,
d.death_percent_pop,
d.percentage_infected,
d.population,
d.gdp_per_capita
FROM coviddeaths1.covid.deaths_analysis as d
LEFT JOIN coviddeaths1.covid.vaccines_analysis as v
ON d.country = v.country
WHERE v.people_vaccinated IS NOT NULL
AND d.gdp_per_capita IS NOT NULL
ORDER BY total_deaths DESC
)
--------------------------------------------
SELECT *
from coviddeaths1.covid.deaths_vaccines
