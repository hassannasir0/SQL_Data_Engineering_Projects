-- Count Rows - Aggregation Only
SELECT 
    COUNT(*)
FROM
    job_postings_fact;

-- Count Rows - Window Function

SELECT
    job_id,
    COUNT(*) OVER ()
FROM
    job_postings_fact;

-- PARTITION BY - Find hourly salary
SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    company_id,
    AVG(salary_hour_avg) OVER (
        PARTITION BY job_title_short, company_id
    )
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL;

-- ORDER BY - Ranking hourly salary

SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() OVER (
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL
ORDER BY
    salary_hour_avg DESC
LIMIT 10;

-- PARTITION BY & ORDER BY - Running Average Hourly Salary


SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() OVER (
        PARTITION BY job_title_short
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL
ORDER BY
    salary_hour_avg DESC,
    job_title_short
LIMIT 10;
