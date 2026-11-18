SELECT 
    job_posted_date,
    job_posted_date::DATE AS date,
    job_posted_date::TIME AS time,
    job_posted_date::TIMESTAMP AS timestamp,
    job_posted_date::TIMESTAMPTZ AS timestampz 
FROM job_postings_fact
LIMIT 10;

SELECT
    EXTRACT(YEAR FROM job_posted_date) AS job_posted_year,
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
GROUP BY
    EXTRACT(YEAR FROM job_posted_date),
    EXTRACT(MONTH FROM job_posted_date)
ORDER BY
    job_count DESC;


SELECT
    job_posted_date,
    DATE_TRUNC('year', job_posted_date) AS truncated_year,
    DATE_TRUNC('quarter', job_posted_date) AS truncated_quarter,
    DATE_TRUNC('month', job_posted_date) AS truncated_month,
    DATE_TRUNC('week', job_posted_date) AS truncated_week,
    DATE_TRUNC('day', job_posted_date) AS truncated_day,
    DATE_TRUNC('hour', job_posted_date) AS truncated_hour
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 10;

SELECT
    DATE_TRUNC('month', job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Engineer' AND
    EXTRACT(YEAR FROM job_posted_date) = 2025
GROUP BY
    DATE_TRUNC('month', job_posted_date)
ORDER BY
    job_posted_month;

SELECT  
    job_title_short,
    job_location,
    job_posted_date AT TIME ZONE 'GMT' AT TIME ZONE 'EST'
FROM
    job_postings_fact
WHERE
    job_location LIKE 'New York, NY';

SELECT  
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'GMT') AS job_posted_hour,
    COUNT(job_id)
FROM
    job_postings_fact
WHERE
    job_location LIKE 'Pakistan'
GROUP BY
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'GMT')
ORDER BY
    job_posted_hour;

SELECT
    job_location,
    COUNT(job_id) AS job_count,
    EXTRACT(YEAR FROM job_posted_date) AS job_posted_year
FROM job_postings_fact
WHERE job_location LIKE '%Pakistan%' AND job_title_short = 'Data Engineer'
GROUP BY job_location, job_posted_year
ORDER BY job_count DESC;