/* 

QUESTION: 

What are the most in-demand skills for Data Engineers?

- Identify the top 10 in-demand skills for Data Engineers.
- Focus on remote job postings.

WHY?:
Retrieves the top 10 most in-demand skills with the highest demand 
in the remote job market, providing insight into the most valuable 
skills for Data Engineers seeking remote work opportunities.

*/

-------------------------------------------------------------------
-- The following SQL query addresses the afore mentioned questions.
-------------------------------------------------------------------

SELECT
    sd.skills,
    COUNT(jpf.*) AS demand_count

FROM 
    job_postings_fact AS jpf

INNER JOIN 
    skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id

INNER JOIN 
skills_dim AS sd
    ON sjd.skill_id = sd.skill_id

WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE

GROUP BY 
    sd.skills

ORDER BY 
    demand_count DESC

LIMIT 10;

-------------------------------------------------------------------

/*

RESULTS:

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
  10 rows         2 columns

-------------------------------------------------------------------

VISUAL CHART:

       TOP 10 MOST IN-DEMAND DATA ENGINEERING SKILLS
                  Remote Job Postings

Demand
29K ┤
    │
    │  ████████████████████████████████████████████  SQL       29,221
28K ┤  ███████████████████████████████████████████   Python    28,776
    │
    │
25K ┤
    │
    │
20K ┤
    │
    │  ███████████████████████████                    AWS       17,823
    │
15K ┤  ██████████████████████                         Azure     14,143
    │  ████████████████████                           Spark     12,799
    │
10K ┤  ███████████████                                Airflow    9,996
    │  █████████████                                  Snowflake  8,639
    │  ████████████                                   Databricks 8,183
 7K ┤  ███████████                                    Java       7,267
    │  ██████████                                     GCP        6,446
    │
 0K └──────────────────────────────────────────────────────────────

-------------------------------------------------------------------

KEY INSIGHTS:

SQL and Python clearly dominate the remote Data Engineering market, appearing in roughly
29K job postings each. Cloud skills are also highly valuable, with AWS and Azure ranking 
3rd and 4th.

The results suggest a typical remote Data Engineer skill stack combines:
SQL + Python → Cloud (AWS/Azure/GCP) → Data Processing (Spark) → 
Pipeline Orchestration (Airflow) → Data Platforms (Snowflake/Databricks).

For a recruiter, this indicates that candidates possessing strong SQL/Python fundamentals
plus cloud and modern data-platform experience align particularly well with current remote 
Data Engineering requirements.

-------------------------------------------------------------------

VISUAL CHART:

CORE FOUNDATION
SQL ──────────────── 29,221
Python ───────────── 28,776
        ↓
CLOUD
AWS ──────────────── 17,823
Azure ────────────── 14,143
GCP ───────────────── 6,446
        ↓
DATA PROCESSING
Spark ─────────────── 12,799
        ↓
PIPELINE ORCHESTRATION
Airflow ────────────── 9,996
        ↓
DATA PLATFORMS
Snowflake ──────────── 8,639
Databricks ─────────── 8,183

-------------------------------------------------------------------
*/