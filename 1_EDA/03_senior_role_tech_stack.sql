/*
Question: What technical stack do companies require and reward for Senior Data Engineers?
- Join job postings to skills dimension tables via the bridge table
- Filter specifically for 'Senior Data Engineer' roles with non-null salaries
- Apply HAVING COUNT(jpf.job_id) >= 20 to eliminate low-sample statistical noise
- Group by skill name and order by median salary descending
- Why? Identifies the core technologies that command senior-level compensation packages while maintaining statistically reliable sample sizes
*/

SELECT
    sd.skills,
    COUNT(jpf.job_id) AS demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary
FROM 
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE   
    jpf.job_title_short = 'Senior Data Engineer'
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY    
    sd.skills
HAVING 
    COUNT(jpf.job_id) >=20
ORDER BY
    median_salary DESC
LIMIT 
    20;

/*
Here's the breakdown of the Senior Data Engineer tech stack:

1. Specialized & NoSQL Database Premium:
   - Non-relational databases lead compensation: Mongo ($173,500), Cassandra ($173,465), and Neo4j ($171,500) occupy the top salary spots.

2. Distributed Systems & High-Throughput Processing:
   - Event-streaming tools and functional languages show strong demand and premium pay (Kafka with 950 postings at $160,000; Scala with 817 postings at $160,000).

3. Enterprise Cloud Data Warehousing:
   - Snowflake commands massive market volume (1,126 postings) at a solid $155,000 median salary, alongside BigQuery ($162,225).

Key Takeaways:
- Senior compensation shifts away from general data handling toward specialized data architecture, real-time streaming (Kafka), and non-relational database management (Mongo/Cassandra).
- Filtering low-sample outliers with HAVING is essential for extracting reliable market signals from raw job posting data.
┌───────────────┬──────────────┬───────────────┐
│    skills     │ demand_count │ median_salary │
│    varchar    │    int64     │    double     │
├───────────────┼──────────────┼───────────────┤
│ mongo         │          224 │      173500.0 │
│ cassandra     │          315 │      173465.0 │
│ neo4j         │           23 │      171500.0 │
│ shell         │          390 │      170672.0 │
│ mysql         │          429 │      170000.0 │
│ redis         │           61 │      165186.0 │
│ hadoop        │          776 │      162500.0 │
│ bigquery      │          373 │      162225.0 │
│ kafka         │          950 │      160000.0 │
│ scala         │          817 │      160000.0 │
│ c             │           81 │      159500.0 │
│ redshift      │          762 │      158750.0 │
│ word          │           66 │      156250.0 │
│ nosql         │          707 │      155000.0 │
│ java          │         1027 │      155000.0 │
│ snowflake     │         1126 │      155000.0 │
│ golang        │           49 │      155000.0 │
│ dynamodb      │          122 │      150500.0 │
│ elasticsearch │           68 │      150000.0 │
│ ruby          │           42 │      150000.0 │
└───────────────┴──────────────┴───────────────┘
*/