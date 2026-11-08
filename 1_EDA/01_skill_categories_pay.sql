/*
Question: What is the demand and median salary by skill category for Data Engineers?
- Join job postings to skills dimension tables via the bridge table
- Group by skill type (e.g., programming, cloud, database, tools)
- Calculate total demand count and median yearly salary for each category
- Focus on Data Engineer job postings
- Why? Determines which technological domains (cloud vs. programming vs. databases) 
    command the highest overall market value and compensation
*/

SELECT
    sd.type,
    COUNT(jpf.*) AS demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
GROUP BY
    sd.type
ORDER BY
    median_salary DESC;

/*
Here's the breakdown of skill categories for Data Engineers:

- Volume Kings (programming & cloud): Programming skills have massive raw demand (800k+ mentions) with a high median salary (~$131.5k), while Cloud platforms sit
  right behind with over 530k mentions and a very strong ~$131.6k median.

- The Niche Premium (libraries): Even though libraries have lower total demand compared to core programming, they command the highest median salary on the list 
  at $140,000. That is a classic data insight: specialization pays

- Volume vs. Pay Balance: Core programming and cloud infrastructure form the massive foundation of job requirements, but specialized library and tooling stacks push up 
  into top-tier compensation brackets.

Key takeaways:
- Categorizing skills helps look beyond individual tool names to see structural trends
- Cloud and infrastructure tools often correlate with higher median pay packages
- Traditional programming and database skills drive the highest overall volume of job openings

┌──────────────┬─────────────┬──────────────┬───────────────┐
│    skills    │ remote_flag │ demand_count │ median_salary │
│   varchar    │   boolean   │    int64     │    double     │
├──────────────┼─────────────┼──────────────┼───────────────┤
│ mongo        │ false       │          229 │      207000.0 │
│ terraform    │ true        │          193 │      184000.0 │
│ golang       │ true        │           39 │      184000.0 │
│ spring       │ true        │           33 │      175500.0 │
│ groovy       │ false       │           77 │      157500.0 │
│ puppet       │ false       │           88 │      157500.0 │
│ ansible      │ false       │          180 │      152750.0 │
│ typescript   │ true        │           39 │      151000.0 │
│ kubernetes   │ true        │          147 │      150500.0 │
│ ruby         │ true        │           48 │      150000.0 │
│ airflow      │ true        │          386 │      150000.0 │
│ pytorch      │ false       │          120 │      147663.0 │
│ kafka        │ false       │         1699 │      147500.0 │
│ cassandra    │ false       │          484 │      147500.0 │
│ typescript   │ false       │           55 │      147500.0 │
│ redis        │ false       │           83 │      147500.0 │
│ scikit-learn │ false       │          100 │      146250.0 │
│ aurora       │ false       │          117 │      145257.0 │
│ rust         │ false       │           33 │      145250.0 │
│ golang       │ false       │           56 │      145000.0 │
└──────────────┴─────────────┴──────────────┴───────────────┘
*/