SELECT
job_title_short,
company_id,
job_location
FROM
january_jobs

UNION ALL

--get jobs and companies from february
SELECT
job_title_short,
company_id,
job_location
FROM
february_jobs

UNION ALL--combine another table

SELECT
job_title_short,
company_id,
job_location
FROM
march_jobs

--Advanced practice problem 8
/*
Find job postings from the first quarter that have a salary greater than $70k
-Combine job posting tables from the first quarter of 2023 (jan-mar)
-Gets job postings with an average yearly salary greater than $70k
*/
SELECT 
quarter1_job_postings.job_title_short,
quarter1_job_postings.job_location,
quarter1_job_postings.job_via,
quarter1_job_postings.job_posted_date::date,
quarter1_job_postings.salary_year_avg
FROM(
SELECT *
FROM january_jobs
UNION ALL
SELECT *
FROM february_jobs
UNION ALL
SELECT *
FROM march_jobs)
AS  quarter1_job_postings
WHERE 
quarter1_job_postings.salary_year_avg>70000 AND
quarter1_job_postings.job_title_short='Data Analyst'
ORDER BY quarter1_job_postings.salary_year_avg DESC;

--if you remove those e.g 'quarter1_job_postings. and use only job_via,you get same thing'
SELECT 
job_title_short,
job_location,
job_via,
job_posted_date::date,
salary_year_avg
FROM(
SELECT *
FROM january_jobs
UNION ALL
SELECT *
FROM february_jobs
UNION ALL
SELECT *
FROM march_jobs)
AS  quarter1_job_postings
WHERE 
salary_year_avg>70000 AND
job_title_short='Data Analyst'
ORDER BY salary_year_avg DESC;

--Practice problem 1
SELECT
quarter1_job_postings.salary_year_avg,
quarter1_job_postings.job_id,
skill.skills,
skill.type
FROM(
SELECT *
FROM january_jobs
WHERE 
salary_year_avg>70000
UNION ALL
SELECT *
FROM february_jobs
WHERE 
salary_year_avg>70000
UNION ALL
SELECT *
FROM march_jobs
WHERE 
salary_year_avg>70000)
AS  quarter1_job_postings
LEFT JOIN skills_job_dim sj
 ON quarter1_job_postings.job_id=sj.job_id
 LEFT JOIN skills_dim skill 
 ON sj.skill_id=skill.skill_id;
