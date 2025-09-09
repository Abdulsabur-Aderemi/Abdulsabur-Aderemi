# HR Analytics Dashboard – Summary Report
🧾 Project Objective
 
The goal of this project was to develop a comprehensive and interactive HR dashboard using Power BI. The dashboard analyzes key employee data to assist HR professionals in identifying trends, addressing issues like attrition, and making informed workforce decisions.

🔍 Key Insights from the Dashboard

Attrition Rate: 16% of employees have left the company (Attrition = Yes). This metric is critical for monitoring employee retention.

Employee Headcount:
Total number of employees: 1,470
Majority are in Research & Development and Sales departments.

Attrition by Department: Higher attrition observed in Sales and Human Resources, suggesting possible issues with workload, satisfaction, or management.

Gender and Department Breakdown: Males dominate in Sales and Research roles. Gender disparities may exist in certain departments.

Job Satisfaction Trends: On average, satisfaction remains relatively steady over years, but drops in early years could indicate onboarding or engagement issues.

Performance & Compensation:

Employees with higher performance ratings tend to earn slightly more

OverTime workers have lower satisfaction and higher attrition likelihood.

Challenges Faced & Solutions

Data Format Issue: The original CSV had formatting issues; data cleaning in Power Query resolved them (e.g. column names, data types).

Measure Errors: Calculated DAX measures initially returned incorrect values (e.g. counting all attrition values instead of filtered ones). This was fixed using CALCULATE() with proper filters.

🧠 Assumptions Made

Attrition was treated as a binary classification (Yes/No).

Job satisfaction was assumed to be on a 1–4 scale.

No missing or null values were included after cleaning.

📊 Dashboard Highlights

KPIs: Total employees, Average Monthly Income, Attrition Rate, Attrition Count

Visuals: Bar and donut charts for attrition and department distribution, line chart for job satisfaction trend, and slicers for filtering by job role, gender, overtime, and age group.

This dashboard serves as a valuable tool for HR decision-making, helping to uncover patterns in attrition, satisfaction, and departmental performance.

Dashboard Preview

<img width="1210" height="657" alt="HR Analytics Dashboard" src="https://github.com/user-attachments/assets/39cf6ddd-a389-4a3e-baae-7a015c8b0ad3" />




