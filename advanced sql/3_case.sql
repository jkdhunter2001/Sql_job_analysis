CREATE TABLE january_jobs AS
    SELECT*
    FROM
    job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=1;

CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT
COUNT(job_id) AS number_of_jobs,
CASE
WHEN job_location='Anywhere' THEN 'Remote'
WHEN job_location='New York, NY' THEN 'Local'
ELSE 'Onsite'
END AS location_category
FROM job_postings_fact
WHERE job_title_short='Data Analyst'
GROUP BY 
location_category;

/*
Label new column as follows:
-'Anywhere' jobs as 'Remote'
-'New york,NY' jobs as 'Local'
-otherwise 'onsite'
*/
--practice problem 1
SELECT
    job_id,
    job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg >= 120000 THEN 'High'
        WHEN salary_year_avg BETWEEN 70000 AND 119999 THEN 'Standard'
        WHEN salary_year_avg < 70000 THEN 'Low'
        ELSE 'Unknown'
    END AS salary_bucket
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
  AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;