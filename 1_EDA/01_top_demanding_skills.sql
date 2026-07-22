/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on job postings in India
- Why? Retrieves the top 10 skills with the highest demand in the indian job market,
    providing insights into the most valuable skills for data engineers.
    */

SELECT 
    sd.skills,
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
ORDER BY
    demand_count DESC
LIMIT 10;


/*
Key takeaways:
- SQL and Python remain the foundational skills for data engineers
- Cloud platforms (AWS, Azure) are critical for modern data engineering
- Big data tools like Spark continue to be highly valued
- Data pipeline tools (Airflow, Snowflake, Databricks) show growing demand
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29766 │
│ python     │        27049 │
│ aws        │        17026 │
│ azure      │        16189 │
│ spark      │        15744 │
│ databricks │         9186 │
│ hadoop     │         8563 │
│ java       │         8552 │
│ snowflake  │         8534 │
│ pyspark    │         8331 │
└────────────┴──────────────┘
  10 rows         2 columns
*/