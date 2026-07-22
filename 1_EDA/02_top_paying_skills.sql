/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,   
    COUNT (jpf.job_id) AS demand_count
FROM job_postingS_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer'
    AND jpf.job_country = 'India'   
GROUP BY 
    sd.skills
HAVING 
    COUNT (jpf.job_id) > 100
ORDER BY
    median_salary DESC
LIMIT 25;

/*

┌───────────────┬───────────────┬──────────────┐
│    skills     │ median_salary │ demand_count │
│    varchar    │    double     │    int64     │
├───────────────┼───────────────┼──────────────┤
│ perl          │      151750.0 │          301 │
│ javascript    │      147500.0 │          991 │
│ redis         │      147500.0 │          470 │
│ jupyter       │      147500.0 │          366 │
│ go            │      147500.0 │         1439 │
│ mysql         │      147500.0 │         2626 │
│ pandas        │      147500.0 │         1637 │
│ sheets        │      147500.0 │          112 │
│ bash          │      147500.0 │          649 │
│ docker        │      147500.0 │         2980 │
│ git           │      147500.0 │         4537 │
│ kubernetes    │      147500.0 │         3143 │
│ bitbucket     │      147500.0 │          625 │
│ neo4j         │      147500.0 │          356 │
│ unix          │      147500.0 │         1761 │
│ numpy         │      147500.0 │          894 │
│ splunk        │      147500.0 │          302 │
│ mongo         │      147500.0 │          334 │
│ looker        │      147500.0 │          980 │
│ node.js       │      147500.0 │          197 │
│ no-sql        │      147500.0 │          384 │
│ jenkins       │      147500.0 │         2914 │
│ php           │      147500.0 │          110 │
│ microstrategy │      147500.0 │          236 │
│ airflow       │      147500.0 │         7529 │
└───────────────┴───────────────┴──────────────┘
  25 rows                            3 columns

*/