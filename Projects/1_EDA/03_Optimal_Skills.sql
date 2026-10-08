/* 

QUESTION: 

What are the most optimal skills for Data Engineers, balancing both demand and salary?

- Create a ranking column that combines demand count and median salary
to identify the most valuable skill.
- Focus only on remote Data Engineer job positions with specified annual salaries.

WHY?:
This approach highlights skills thatbalance market demand and financial compensation.
It weights core skills appropriately, rather than letting rare, 
outlier skills, to distort the results.

*/

-------------------------------------------------------------------
-- The following SQL query addresses the afore mentioned questions.
-------------------------------------------------------------------

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/1000000, 2) AS optimal_score,

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
    AND jpf.salary_year_avg IS NOT NULL

GROUP BY 
    sd.skills

HAVING 
    COUNT(jpf.*) > 100

ORDER BY 
    optimal_score DESC  

LIMIT 25;

-------------------------------------------------------------------

/*

RESULTS:

┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │          193 │             5.3 │          0.97 │
│ python     │      135000.0 │         1133 │             7.0 │          0.95 │
│ aws        │      137320.0 │          783 │             6.7 │          0.91 │
│ sql        │      130000.0 │         1128 │             7.0 │          0.91 │
│ airflow    │      150000.0 │          386 │             6.0 │          0.89 │
│ spark      │      140000.0 │          503 │             6.2 │          0.87 │
│ kafka      │      145000.0 │          292 │             5.7 │          0.82 │
│ snowflake  │      135500.0 │          438 │             6.1 │          0.82 │
│ azure      │      128000.0 │          475 │             6.2 │          0.79 │
│ java       │      135000.0 │          303 │             5.7 │          0.77 │
│ scala      │      137290.0 │          247 │             5.5 │          0.76 │
│ git        │      140000.0 │          208 │             5.3 │          0.75 │
│ kubernetes │      150500.0 │          147 │             5.0 │          0.75 │
│ databricks │      132750.0 │          266 │             5.6 │          0.74 │
│ redshift   │      130000.0 │          274 │             5.6 │          0.73 │
│ gcp        │      136000.0 │          196 │             5.3 │          0.72 │
│ nosql      │      134415.0 │          193 │             5.3 │          0.71 │
│ hadoop     │      135000.0 │          198 │             5.3 │          0.71 │
│ pyspark    │      140000.0 │          152 │             5.0 │           0.7 │
│ docker     │      135000.0 │          144 │             5.0 │          0.67 │
│ mongodb    │      135750.0 │          136 │             4.9 │          0.67 │
│ r          │      134775.0 │          133 │             4.9 │          0.66 │
│ go         │      140000.0 │          113 │             4.7 │          0.66 │
│ github     │      135000.0 │          127 │             4.8 │          0.65 │
│ bigquery   │      135000.0 │          123 │             4.8 │          0.65 │
└────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
  25 rows                                                           5 columns

-------------------------------------------------------------------

VISUAL CHART:

        MOST OPTIMAL DATA ENGINEERING SKILLS
       Demand + Salary Balance | Remote Jobs

Optimal
Score

1.00 ┤
     │  ███████████████████████████████████████████████  Terraform   0.97
0.95 ┤  ██████████████████████████████████████████████   Python      0.95
     │
0.90 ┤  ███████████████████████████████████████████      AWS        0.91
     │  ███████████████████████████████████████████      SQL        0.91
     │  █████████████████████████████████████████         Airflow    0.89
0.85 ┤  ████████████████████████████████████████          Spark      0.87
     │
0.80 ┤  █████████████████████████████████████             Kafka      0.82
     │  █████████████████████████████████████             Snowflake  0.82
     │
0.75 ┤  ████████████████████████████████████              Azure      0.79
     │  ███████████████████████████████████               Java       0.77
     │  ██████████████████████████████████                Scala      0.76
     │  ██████████████████████████████████                Git        0.75
     │  ██████████████████████████████████                Kubernetes 0.75
     │
0.70 ┤  █████████████████████████████████                 Databricks 0.74
     │  █████████████████████████████████                 Redshift   0.73
     │  ████████████████████████████████                  GCP        0.72
     │  ████████████████████████████████                  NoSQL      0.71
     │  ████████████████████████████████                  Hadoop     0.71
     │  ██████████████████████████████                    PySpark    0.70
     │
0.65 ┤  █████████████████████████████                     Docker     0.67
     │  █████████████████████████████                     MongoDB    0.67
     │  █████████████████████████████                     R          0.66
     │  █████████████████████████████                     Go         0.66
     │  █████████████████████████████                     GitHub     0.65
     │  █████████████████████████████                     BigQuery   0.65
     │
0.60 └──────────────────────────────────────────────────────────────

-------------------------------------------------------------------
Salary Vs Demand Balance:
The optimal score becomes much easier to understand when we look at the underlying numbers.

SKILL          MEDIAN SALARY       DEMAND        OPTIMAL
─────────────────────────────────────────────────────────────

Terraform      $184,000            193           ★ 0.97
Python         $135,000          1,133           ★ 0.95
AWS            $137,320            783           ★ 0.91
SQL            $130,000          1,128           ★ 0.91
Airflow        $150,000            386           ★ 0.89
Spark          $140,000            503           ★ 0.87
Kafka          $145,000            292           ★ 0.82
Snowflake      $135,500            438           ★ 0.82
Azure          $128,000            475           ★ 0.79
Java           $135,000            303           ★ 0.77

-------------------------------------------------------------------

KEY INSIGHTS:

What immediately stands out ; Terraform is #1 despite having only 193 postings.
That's because its $184K median salary is substantially higher than most of the other highly demanded skills.

Meanwhile:

Python and SQL are the opposite story.
They have much lower median salaries:
- Python → $135K
- SQL → $130K

But they occur in more than 1,100 postings each, which gives them an exceptionally strong overall score.
So the dataset identifies two different winning strategies:

             HIGH SALARY
                  ▲
                  │
                  │       TERRAFORM
                  │        $184K
                  │
                  │
                  │
                  │
                  │
                  │
                  │
                  │
                  │
                  └──────────────────────────► HIGH DEMAND
                         PYTHON / SQL
                         ~1,100 postings

-------------------------------------------------------------------

KEY TAKEAWAYS:

1. Terraform is the strongest overall skill

Terraform has the highest optimal score (0.97) and the highest salary among the top-ranked skills at $184K.
Although demand is only 193 postings, its combination of high compensation and meaningful demand makes it 
the strongest skill according to this ranking.

Interpretation: Terraform appears to be a high-value specialization rather than a universal requirement.

2. Python is probably the strongest "all-around" skill Python has:

- $135K median salary
- 1,133 postings
- 0.95 optimal score

This is particularly significant because Python combines very high demand with respectable compensation.
Unlike Terraform, Python isn't winning because of an unusually high salary. It wins because the market
wants it frequently while still paying well.

3. AWS and SQL form another powerful combination

AWS       $137,320   | 783 postings | 0.91
SQL       $130,000   | 1,128       | 0.91

They achieve exactly the same optimal score through different strengths.

AWS: higher salary + strong demand.
SQL: slightly lower salary + extremely high demand.
This reinforces the main finding: there isn't one single definition of a valuable skill.

4. Airflow and Spark are excellent middle-ground skills

Airflow     $150K    | 386 postings | 0.89
Spark       $140K    | 503 postings | 0.87

Both provide a particularly good balance between technical relevance, demand, and compensation.
They are not as universally demanded as SQL/Python, but their salaries are higher.

5. Azure is valuable, but ranks below AWS

AWS       $137,320 | 783 postings | 0.91
Azure     $128,000 | 475 postings | 0.79
GCP       $136,000 | 196 postings | 0.72

Within this dataset, AWS has the strongest combination of demand and salary among the three major cloud platforms.
Azure still performs well, but its lower median salary and demand result in a lower optimal score.

6. The ranking favors skills that are both useful AND scarce enough to pay well
This is perhaps the most important insight from the query.

Compare:
                 SALARY       DEMAND       SCORE

Terraform        $184K          193        0.97
Python           $135K        1,133        0.95
SQL              $130K        1,128        0.91
Airflow          $150K          386        0.89

You can see why simply sorting by salary would be misleading.
Terraform would look attractive based on salary alone, while Python and SQL would look less impressive.
But when demand is incorporated, Python and SQL rise to the top.

-------------------------------------------------------------------

Career-development interpretation
If we translate the results into a practical skill-development strategy:

                    OPTIMAL SKILL STACK

                 ┌──────────────────┐
                 │    TERRAFORM      │
                 │  High-value       │
                 │  specialization   │
                 └────────┬─────────┘
                          │
                 ┌────────▼─────────┐
                 │   PYTHON + SQL    │
                 │ Core foundation   │
                 │ Very high demand  │
                 └────────┬─────────┘
                          │
                 ┌────────▼─────────┐
                 │       AWS        │
                 │ Cloud platform   │
                 └────────┬─────────┘
                          │
              ┌───────────▼───────────┐
              │    SPARK + AIRFLOW    │
              │ Processing + pipelines│
              └───────────┬───────────┘
                          │
                 ┌────────▼─────────┐
                 │ SNOWFLAKE/KAFKA  │
                 │ Modern platform  │
                 └──────────────────┘

-------------------------------------------------------------------

Overall conclusion:

The optimal Data Engineering skill is not necessarily the highest-paid skill or the most frequently requested skill. 
It is the skill that provides the strongest combination of both.

The results identify Terraform (0.97) as the highest-scoring skill, while Python (0.95), AWS (0.91), and SQL (0.91) 
provide an especially strong combination of high demand and solid compensation.

For someone deciding what to learn, the data therefore suggests a strategy of building a broad foundation in SQL and Python,
adding cloud expertise such as AWS, then developing higher-value specializations such as 
Terraform, Airflow, Spark, and modern data platforms.

*/