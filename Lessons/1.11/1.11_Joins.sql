-- LEFT JOINs
SELECT
    jpf.*,
    cd.*
FROM
    job_postings_fact AS jpf
LEFT JOIN
    company_dim AS cd
ON
    jpf.company_id = cd.company_id
LIMIT 10;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf
LEFT JOIN
    company_dim AS cd
ON
    jpf.company_id = cd.company_id
LIMIT 10;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf
LEFT JOIN
    company_dim AS cd
ON
    jpf.company_id = cd.company_id;


    --RIGHT JOINs

SELECT
    jpf.job_id,
    jpf.job_title_short,
    name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf
RIGHT JOIN
    company_dim AS cd
ON
    jpf.company_id = cd.company_id
LIMIT 10;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf
RIGHT JOIN
    company_dim AS cd
ON
    jpf.company_id = cd.company_id;

--INNER JOINs
SELECT
    jpf.job_id,
    jpf.job_title_short,
    name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf 
JOIN
    company_dim AS cd
ON
    jpf.company_id = cd.company_id;

    --FULL OUTER JOINs

SELECT
    jpf.job_id,
    jpf.job_title_short,
name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf
FULL JOIN
    company_dim AS cd
ON
    jpf.company_id = cd.company_id;

-- Exercise

SELECT *
FROM
    skills_job_dim
LIMIT 10;

SELECT *
FROM
    skills_dim
LIMIT 10;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM
    job_postings_fact AS jpf
LEFT JOIN
    skills_job_dim AS sjd
ON
    jpf.job_id = sjd.job_id
LEFT JOIN
    skills_dim AS sd
ON 
    sjd.skill_id = sd.skill_id;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM
    job_postings_fact AS jpf
INNER JOIN
    skills_job_dim AS sjd
ON
    jpf.job_id = sjd.job_id
INNER JOIN
    skills_dim AS sd
ON 
    sjd.skill_id = sd.skill_id;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM
    job_postings_fact AS jpf
FULL OUTER JOIN
    skills_job_dim AS sjd
ON
    jpf.job_id = sjd.job_id
FULL OUTER JOIN
    skills_dim AS sd
ON 
    sjd.skill_id = sd.skill_id;