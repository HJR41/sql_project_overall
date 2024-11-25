/* 
What skills fetch the highest salaries for Data-Analyst Roles?
- Use the top 10 list from the first query
- Using a CTE, join my first query with skills data to find the specific skills required for these roles.
This is useful as it wil show me an in depth look at the skills that are required to get the highest
paying roles, within the UK.
Helping job seekers understand which skills to develop to be among the highest earners.
*/
WITH data_analyst_roles AS (
    SELECT
        job_id,
        job_title,
        company_dim.name AS company_name,
        salary_year_avg * 1.26 AS salary_year_gbp --1.26 is the Exchange Rate GBP to USD. Exchange rate taken from 'Fixer' 25/11/2024
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_country = 'United Kingdom' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    data_analyst_roles.job_id,
    job_title,
    company_name,
    skills_dim.skills AS skill_name,
    salary_year_gbp
FROM
    data_analyst_roles
INNER JOIN skills_job_dim ON data_analyst_roles.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
        salary_year_gbp DESC,
        company_name,
        skill_name;

/*
Breakdown of skills required based on query above, analysis have been done with exported CSV file.

- Python is the most in-demand skill, with a count of 5.
- SQL follows closely with a count of 4.
- Excel with a count of 3.
- Flow, r, SQL Server, AWS, Azure, mySQL and mongodb all with counts of 2.


Query Results (JSON)

[
  {
    "job_id": 1401033,
    "job_title": "Market Data Lead Analyst",
    "company_name": "Deutsche Bank",
    "skill_name": "excel",
    "salary_year_gbp": "226800.000"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "company_name": "DeepMind",
    "skill_name": "c++",
    "salary_year_gbp": "223376.580"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "company_name": "DeepMind",
    "skill_name": "numpy",
    "salary_year_gbp": "223376.580"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "company_name": "DeepMind",
    "skill_name": "pandas",
    "salary_year_gbp": "223376.580"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "company_name": "DeepMind",
    "skill_name": "python",
    "salary_year_gbp": "223376.580"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "company_name": "DeepMind",
    "skill_name": "pytorch",
    "salary_year_gbp": "223376.580"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "company_name": "DeepMind",
    "skill_name": "tensorflow",
    "salary_year_gbp": "223376.580"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "aurora",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "aws",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "azure",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "elasticsearch",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "hadoop",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "kafka",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "mongodb",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "mongodb",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "oracle",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "postgresql",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "python",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "r",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "redshift",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "scala",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "sql",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "company_name": "AND Digital",
    "skill_name": "sql server",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 1563887,
    "job_title": "Data Architect",
    "company_name": "Darktrace",
    "skill_name": "flow",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 1563887,
    "job_title": "Data Architect",
    "company_name": "Darktrace",
    "skill_name": "mysql",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 1563887,
    "job_title": "Data Architect",
    "company_name": "Darktrace",
    "skill_name": "sql",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 1563887,
    "job_title": "Data Architect",
    "company_name": "Darktrace",
    "skill_name": "sql server",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 1246069,
    "job_title": "Data Analyst",
    "company_name": "Plexus Resource Solutions",
    "skill_name": "aws",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 1246069,
    "job_title": "Data Analyst",
    "company_name": "Plexus Resource Solutions",
    "skill_name": "mysql",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 1246069,
    "job_title": "Data Analyst",
    "company_name": "Plexus Resource Solutions",
    "skill_name": "python",
    "salary_year_gbp": "207900.000"
  },
  {
    "job_id": 478395,
    "job_title": "Data Architect",
    "company_name": "Logispin",
    "skill_name": "azure",
    "salary_year_gbp": "206365.320"
  },
  {
    "job_id": 478395,
    "job_title": "Data Architect",
    "company_name": "Logispin",
    "skill_name": "looker",
    "salary_year_gbp": "206365.320"
  },
  {
    "job_id": 478395,
    "job_title": "Data Architect",
    "company_name": "Logispin",
    "skill_name": "nosql",
    "salary_year_gbp": "206365.320"
  },
  {
    "job_id": 1813715,
    "job_title": "Data Architect - Trading and Supply",
    "company_name": "Shell",
    "skill_name": "excel",
    "salary_year_gbp": "197190.000"
  },
  {
    "job_id": 1813715,
    "job_title": "Data Architect - Trading and Supply",
    "company_name": "Shell",
    "skill_name": "express",
    "salary_year_gbp": "197190.000"
  },
  {
    "job_id": 1813715,
    "job_title": "Data Architect - Trading and Supply",
    "company_name": "Shell",
    "skill_name": "flow",
    "salary_year_gbp": "197190.000"
  },
  {
    "job_id": 1813715,
    "job_title": "Data Architect - Trading and Supply",
    "company_name": "Shell",
    "skill_name": "shell",
    "salary_year_gbp": "197190.000"
  },
  {
    "job_id": 217504,
    "job_title": "Analytics Engineer - ENA London, Warsaw- (F/M)",
    "company_name": "AccorCorpo",
    "skill_name": "python",
    "salary_year_gbp": "175412.160"
  },
  {
    "job_id": 217504,
    "job_title": "Analytics Engineer - ENA London, Warsaw- (F/M)",
    "company_name": "AccorCorpo",
    "skill_name": "sql",
    "salary_year_gbp": "175412.160"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "company_name": "AJ Bell",
    "skill_name": "excel",
    "salary_year_gbp": "166950.000"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "company_name": "AJ Bell",
    "skill_name": "power bi",
    "salary_year_gbp": "166950.000"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "company_name": "AJ Bell",
    "skill_name": "python",
    "salary_year_gbp": "166950.000"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "company_name": "AJ Bell",
    "skill_name": "r",
    "salary_year_gbp": "166950.000"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "company_name": "AJ Bell",
    "skill_name": "sql",
    "salary_year_gbp": "166950.000"
  }
]


*/

