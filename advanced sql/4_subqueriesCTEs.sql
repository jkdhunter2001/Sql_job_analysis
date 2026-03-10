--creating temporary table for january jobs
SELECT*
FROM(--subquery starts from here
 SELECT*
    FROM
    job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=1
    ) AS january_jobs;--subquery ends here

    SELECT
    company_id,
    name AS company_name
    FROM
    company_dim
    WHERE company_id IN
    (SELECT
    company_id
    FROM 
    job_postings_fact
    WHERE 
    job_no_degree_mention = true
    ORDER BY
    company_id
    )
    /* find the companies that have the most job openings.
    -Get the total number of job postings per company id
    -return the total number of jobs with the company name*/

    WITH company_job_count AS (
    SELECT
    company_id,
    COUNT(*) AS total_jobs
    FROM
    job_postings_fact
    GROUP BY
    company_id)
    SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
    FROM company_dim
    LEFT JOIN company_job_count ON company_job_count.company_id=company_dim.company_id
    ORDER BY
    total_jobs DESC

    --ADVANCED PROBLEM 7
    /*Find the count of the number of remote job postings per skill
    -Display the top 5 skills by their demand in remote jobs
    -Include skill ID,name, and count of postings requiring the skills
    */

   WITH remote_job_skills AS(
    SELECT    skill_id,
    COUNT(*) AS skill_count
    FROM
    skills_job_dim AS skills_to_job
    INNER JOIN 
    job_postings_fact AS job_postings ON job_postings.job_id=skills_to_job.job_id
    WHERE
    job_postings.job_work_from_home=true and
    job_postings.job_title_short= 'Data Analyst'
    GROUP BY
    skill_id)
    SELECT 
    skills.skill_id,
    skills as skill_name,
    skill_count
    FROM remote_job_skills
    INNER JOIN skills_dim AS skills ON skills.skill_id= remote_job_skills.skill_id
    ORDER BY skill_count DESC
    LIMIT 7;

--practice problem 1
SELECT 
sd.skills,
skill_counts.skill_count
FROM(
   SELECT skill_id,
   COUNT(*) as skill_count
   FROM skills_job_dim
   GROUP BY skill_id
   ORDER BY skill_count DESC
   limit 7
) AS skill_counts
JOIN skills_dim sd ON skill_counts.skill_id=sd.skill_id
ORDER BY skill_counts.skill_count DESC

--Practice problem 2
    SELECT 
    cd.name,
    jf.job_count,
    CASE 
    WHEN job_count < 10 THEN 'small'
   WHEN job_count  BETWEEN 10 AND 50 THEN 'medium'
    ELSE 'large'
    END AS company_size
    FROM(
      SELECT company_id,
      COUNT(job_id) AS job_count
      FROM job_postings_fact
      GROUP BY company_id
    ) AS jf
   JOIN company_dim cd ON 
   jf.company_id=cd.company_id
   ORDER BY
    jf.job_count DESC;