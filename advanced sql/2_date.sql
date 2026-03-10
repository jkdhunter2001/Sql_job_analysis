SELECT 
job_title_short AS title,
job_location AS location,
job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date,
EXTRACT(MONTH FROM job_posted_date) AS date_month,
EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM job_postings_fact
LIMIT 10;

SELECT
COUNT(job_id) AS job_posted_count,
EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE
job_title_short='Data Analyst'
GROUP BY 
month
ORDER BY job_posted_count;

---classwork 1
SELECT
job_schedule_type,
AVG(salary_year_avg) AS avg_yearly_sal,
AVG(salary_hour_avg) AS avg_hourly_sal
FROM job_postings_fact
WHERE job_posted_date > '2023-06-01'
GROUP BY job_schedule_type
ORDER BY job_schedule_type;

--classwork 2
SELECT
COUNT(job_id) AS job_count,
EXTRACT(MONTH FROM(job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_york')) AS month
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM(job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_york')) =2023
GROUP BY month
ORDER BY month;

--classwork 3
SELECT
c.name as company_name,
COUNT(J.job_id) AS job_count
FROM job_postings_fact j
JOIN company_dim c ON j.company_id=c.company_id
WHERE 
j.job_health_insurance=TRUE AND
EXTRACT(YEAR FROM j.job_posted_date)=2023
AND EXTRACT(QUARTER FROM j.job_posted_date)=2
GROUP BY company_name
ORDER BY job_count DESC;