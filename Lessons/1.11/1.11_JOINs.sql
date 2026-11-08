SELECT
    jpf.*,
    cd.*
FROM
    job_postings_fact AS jpf 
LEFT JOIN company_dim AS cd 
    ON jpf.company_id = cd.company_id
LIMIT 10;

SELECT
    jpf.*,
    cd.*
FROM
    job_postings_fact AS jpf 
RIGHT JOIN company_dim AS cd 
    ON jpf.company_id = cd.company_id;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM job_postings_fact AS jpf
FULL JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
FULL JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;