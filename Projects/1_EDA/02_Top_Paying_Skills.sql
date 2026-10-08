/* 

QUESTION: 

What are the highest-paying skills for Data Engineers?

- Calculate the median salary for each skill required in
  Data Engineer positions.
- Focus on remote job positions with specified salaries.
-Include skill frequency to identify both salary and demand.

WHY?:
Helps Identify which skills commands the highest compensation while
also showing how common those skills are, providing a comprehensive view
for skill development priorities.

NOTE: The median salary is used instead of the average to mitigate 
the impact of outliers and provide a more accurate representation 
of typical compensation for each skill.

*/

-------------------------------------------------------------------
-- The following SQL query addresses the afore mentioned questions.
-------------------------------------------------------------------

SELECT
    sd.skills,
    ROUND (MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
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

HAVING 
    COUNT(jpf.*) > 100

ORDER BY 
    median_salary DESC

LIMIT 25;

-------------------------------------------------------------------

/*

RESULTS:

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ golang     │      184000.0 │          912 │
│ terraform  │      184000.0 │         3248 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154224.0 │          129 │
│ atlassian  │      151500.0 │          249 │
│ c          │      151500.0 │          444 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ ruby       │      150000.0 │          736 │
│ node       │      150000.0 │          179 │
│ airflow    │      150000.0 │         9996 │
│ css        │      150000.0 │          262 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ ansible    │      148798.0 │          475 │
│ jupyter    │      147500.0 │          400 │
└────────────┴───────────────┴──────────────┘
  25 rows                         3 columns

---------------------------------------------------------------------

VISUAL CHART:

TOP 10 HIGHEST-PAYING SKILLS FOR DATA ENGINEERS
Remote positions with specified salaries

Median Salary (USD)

Rust        ██████████████████████████████████████████  $210,000  | Demand:   232
Golang      █████████████████████████████████████████  $184,000  | Demand:   912
Terraform   █████████████████████████████████████████  $184,000  | Demand: 3,248
Spring      ████████████████████████████████████████   $175,500  | Demand:   364
Neo4j       █████████████████████████████████████████  $170,000  | Demand:   277
GDPR        █████████████████████████████████████████  $169,616  | Demand:   582
Zoom        █████████████████████████████████████████  $168,438  | Demand:   127
GraphQL     █████████████████████████████████████████  $167,500  | Demand:   445
Mongo       ████████████████████████████████████████   $162,250  | Demand:   265
FastAPI     ███████████████████████████████████████    $157,500  | Demand:   204

----------------------------------------------------------------------

KEY INSIGHTS & TAKEAWAYS:

- Rust has the highest median salary at $210K, making it the highest-compensated 
  skill in the dataset. However, its demand is relatively low, appearing in only 
  232 job postings. This suggests a specialized, high-paying niche rather than a 
  broadly required skill.

- Golang and Terraform both reach a $184K median salary, but their market presence 
  is very different. Golang appears in 912 postings, while Terraform appears in 3,248,
  making Terraform a much stronger combination of high compensation + market demand.

- Terraform stands out as the strongest practical opportunity. 
  Its $184K median salary combined with more than 3,200 postings
  suggests that it is not only highly compensated but also relatively widely requested.

- Specialized data technologies also command strong salaries. 
  Neo4j ($170K), GraphQL ($167.5K), Mongo ($162.25K), and FastAPI ($157.5K) all appear
  among the highest-paying skills, although their demand is considerably lower 
  than some mainstream Data Engineering technologies.

- Airflow is particularly interesting because of its combination of salary and demand.
  Its median salary is $150K, below the top-paying skills, but it appears in 9,996 postings.
  This indicates a skill with very strong market demand and still-high compensation,
  rather than a niche premium skill.

- Salary and demand do not necessarily move together. The results show two different types of valuable skills:
  - High salary + low demand: Rust, Neo4j, FastAPI → specialized premium skills.
  - High salary + stronger demand: Terraform → potentially attractive skill-development priority.
  - Moderate-high salary + very high demand: Airflow → broad employability with strong compensation.

Overall takeaway

> The highest salary does not automatically identify the best skill to learn. 
  The strongest opportunities are found by considering both compensation and frequency.
  In this dataset, Terraform stands out as particularly attractive, 
  while Airflow demonstrates the value of a highly demanded skill 
  even without being at the very top of the salary ranking.

*The use of median salary makes these comparisons more representative of typical compensation 
 because it reduces the influence of unusually high or low salaries.

 VISUAL CHART:

                     SALARY       DEMAND
                     ↑             ↑
                     │             │
Rust             HIGH $$$$$      LOW
Golang           HIGH $$$$       LOW
Terraform        HIGH $$$$       ███████  ← STRONG BALANCE
Spring           HIGH $$$$       LOW
Neo4j            HIGH $$$$       LOW
GDPR             HIGH $$$$       LOW
Zoom             HIGH $$$$       VERY LOW
GraphQL          HIGH $$$$       LOW
Mongo            HIGH $$$        LOW
FastAPI          HIGH $$$        LOW

Airflow          $150K          ████████████████████  ← 9,996 jobs

-------------------------------------------------------------------
*/