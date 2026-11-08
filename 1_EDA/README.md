# 🔍 Exploratory Data Analysis w/ SQL: Data Engineering Job Market

![EDA Project Overview](../Images\1_1_Project1_EDA.png)

An independent SQL portfolio project analyzing the data engineering job market using real-world job posting data. It demonstrates my ability to **write production-quality analytical SQL, design multi-table relational queries, and turn raw data into actionable market insights**.

---

## 🧾 Executive Summary

- ✅ **Project Scope:** Engineered **3 independent analytical SQL files** exploring skill category compensation, remote work pay gaps, and senior-level technical requirements.
- ✅ **Data Modeling:** Used **multi-table inner joins** across fact, dimension, and bridge tables within a star schema architecture.
- ✅ **Analytics:** Applied **aggregations, multi-column grouping, and sample-size filtering (`HAVING`)** to isolate true market signals from statistical noise.
- ✅ **Outcomes:** Delivered **actionable insights** proving that domain specialization and remote infrastructure skills command top-tier compensation.

If you only have a minute, review these core project scripts:

1. [`01_skill_categories_pay.sql`](./01_skill_categories_pay.sql) – Skill category volume vs. compensation analysis
2. [`02_remote_vs_onsite_salaries.sql`](./02_remote_vs_onsite_salaries.sql) – Side-by-side remote vs. on-site salary gap analysis
3. [`03_senior_role_tech_stack.sql`](./03_senior_role_tech_stack.sql) – Senior-level technical stack requirements with outlier filtering

---

## 🧩 Problem & Context

Data engineers and market analysts need to answer strategic career and architectural questions like:

- 🎯 **Domain Value:** *Do specialized skill categories (like cloud infrastructure or libraries) command higher compensation than general programming?*
- 💰 **Remote Flexibility:** *Does working remotely introduce a salary penalty, or do remote engineers earn competitive rates?*
- ⚖️ **Senior Requirements:** *What specific database architectures and distributed systems do companies require for senior-level roles?*

This project analyzes a **data warehouse** built using a star schema design. The warehouse structure consists of:

![Data Warehouse Schema](../Images\1_2_Data_Warehouse.png)

- **Fact Table:** `job_postings_fact` - Central table containing job posting details (job titles, locations, salaries, dates, remote status)
- **Dimension Tables:** 
  - `company_dim` - Company information linked to job postings
  - `skills_dim` - Skills catalog with skill names and categories (`type`)
- **Bridge Table:** `skills_job_dim` - Resolves the many-to-many relationship between job postings and skills

---

## 🧰 Tech Stack

- 🐤 **Query Engine:** DuckDB (Fast local analytical OLAP engine)
- 🧮 **Language:** ANSI SQL (Aggregations, Multi-column Grouping, Pattern Filtering)
- 📊 **Data Model:** Star schema with fact, dimension, and bridge tables
- 🛠️ **Development:** VS Code for script editing + DuckDB extension execution
- 📦 **Version Control:** Git/GitHub for versioned analytical scripts

---

## 📂 Repository Structure

```text
1_EDA/
├── 01_skill_categories_pay.sql        # Skill category & compensation analysis
├── 02_remote_vs_onsite_salaries.sql   # Remote vs. on-site pay gap analysis
├── 03_senior_role_tech_stack.sql      # Senior-level tech stack & sample-filtered analysis
└── README.md                          # You are here
```
---

## 🏗 Analysis Overview

### Query Structure

1. **[Skill Categories & Pay](./01_skill_categories_pay.sql)** – Evaluates total job demand against median salaries grouped by broader skill category types (`sd.type`).
2. **[Remote vs. On-Site Salaries](./02_remote_vs_onsite_salaries.sql)** – Compares median pay side-by-side for identical skills across remote (`TRUE`) and on-site (`FALSE`) roles using multi-column grouping.
3. **[Senior Role Tech Stack](./03_senior_role_tech_stack.sql)** – Analyzes the highest-paying technologies for Senior Data Engineers while applying a sample size threshold (`HAVING COUNT >= 20`) to filter out statistical noise.

### Key Insights

- 🌐 **Category Dynamics:** Core `programming` and `cloud` platforms drive the highest raw market demand (800k+ and 530k+ postings), but specialized `libraries` command the highest median pay ($140,000).
- 🏠 **Remote Pay Premium:** Remote flexibility does not come with a pay cut; languages like `Golang` yield a **$39,000 remote premium** ($184k remote vs. $145k on-site).
- ⚡ **Senior Stack Valuation:** Senior roles prioritize specialized NoSQL database architectures (`Mongo`, `Cassandra`, `Neo4j` all leading over $170k) and real-time streaming tools (`Kafka`).

---

## 💻 SQL Skills Demonstrated

### Query Design & Optimization

- **Complex Multi-Table Joins:** Executed 3-table `INNER JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim` to navigate many-to-many schema relationships.
- **Statistical Aggregation:** Leveraged non-skewed metric calculations including `MEDIAN()`, `COUNT()`, and `ROUND()`.
- **Targeted Filtering:** Applied multi-condition boolean logic in `WHERE` clauses (`job_title_short`, `salary_year_avg IS NOT NULL`, `job_work_from_home`).
- **Sorting & Result Sets:** Structured clean top-N analytical outputs using `ORDER BY DESC` and `LIMIT`.

### Data Analysis Techniques

- **Multi-Column Grouping:** Grouped across single (`sd.type`) and multiple dimensions (`sd.skills`, `jpf.job_work_from_home`) to analyze cross-sectional pay gaps.
- **Outlier Sanitation & Thresholding:** Implemented `HAVING COUNT(jpf.job_id) >= 20` to eliminate single-posting median distortions.
- **Data Hygiene:** Standardized data quality by handling null salary records and standardizing column aliasing across all analytical scripts.