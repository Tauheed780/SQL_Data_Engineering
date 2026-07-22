/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,   
    COUNT (jpf.*) AS demand_count,
    ROUND(LN(COUNT (jpf.*)), 1) AS log_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT (jpf.*)))/1000000, 2) AS optimal_score
FROM job_postingS_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_country = 'India' 
    AND jpf.salary_year_avg IS NOT NULL 
GROUP BY 
    sd.skills
HAVING 
    COUNT (jpf.*) > 100
ORDER BY
    optimal_score DESC
LIMIT 10;

/*
┌─────────┬───────────────┬──────────────┬──────────────────┬───────────────┐
│ skills  │ median_salary │ demand_count │ log_demand_count │ optimal_score │
│ varchar │    double     │    int64     │      double      │    double     │
├─────────┼───────────────┼──────────────┼──────────────────┼───────────────┤
│ python  │      145025.0 │          242 │              5.5 │           0.8 │
│ spark   │      131580.0 │          133 │              4.9 │          0.64 │
│ sql     │      110000.0 │          236 │              5.5 │           0.6 │
│ azure   │      110000.0 │          137 │              4.9 │          0.54 │
│ aws     │       96773.0 │          142 │              5.0 │          0.48 │
└─────────┴───────────────┴──────────────┴──────────────────┴───────────────┘
  5 rows                            5 columns
*/  