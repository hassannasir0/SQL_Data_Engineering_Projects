/*
Question: What is the median salary gap between remote and on-site roles for Data Engineering skills?
- Join job postings with skills and bridge tables
- Group by skill name and work-from-home status simultaneously
- Filter for Data Engineer roles with valid salary records
- Exclude low-sample skills (HAVING demand_count >= 30)
- Why? Identifies whether specific skills command higher compensation in remote setups 
    versus on-site roles.
*/

SELECT 
    sd.skills,
    jpf.job_work_from_home AS remote_flag,
    COUNT(jpf.job_id) AS demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary
FROM
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
GROUP BY
    sd.skills,
    remote_flag
HAVING
    demand_count >= 30
ORDER BY
    median_salary DESC
LIMIT
    20;

/*
Here's the breakdown of Remote vs. On-Site salary patterns for Data Engineers:

1. Significant Remote Premiums:
   - Golang shows a massive $39,000 gap ($184,000 remote vs. $145,000 on-site).
   - TypeScript commands $151,000 remote compared to $147,500 on-site.

2. Remote Infrastructure & Cloud Dominance:
   - Modern cloud deployment and orchestration tools (Terraform at $184k, Kubernetes at $150.5k, Airflow at $150k) fill the top remote compensation tiers.

3. High-Paying On-Site Systems:
   - On-site compensation is led by specialized operational databases (Mongo at $207k) and legacy DevOps tooling (Ansible, Puppet, Groovy).

Key Takeaways:
- Remote flexibility does not mean lower pay; specialized infrastructure languages (Golang, Terraform) offer substantial remote pay advantages.
- High-demand data pipeline and cloud skills retain premium baseline salaries across both remote and on-site deployment models.

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