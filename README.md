# Education Intervention Effectiveness Dashboard (Power BI + SQL)

## Overview

This project analyzes student risk, intervention participation, and academic outcomes across multiple schools.

The goal is to answer a key question:

**Are intervention programs effectively improving student performance?**

The dashboard connects three critical components:
- Student risk (who needs support)
- Intervention participation (who is receiving support)
- Academic outcomes (are students improving over time)

Using simulated data, the project demonstrates how data can be used to evaluate program effectiveness and guide resource allocation.

---

## Tools Used

- Power BI (data visualization and dashboard design)
- DAX (calculated measures and logic)
- SQL Server (data modeling and data generation)

---

## Data Model

A relational data model was built using SQL Server, including:

- **DimStudent** – student-level attributes
- **DimSchool** – school-level information
- **DimGrade** – grade-level structure
- **DimIntervention** – intervention programs
- **FactAssessment** – student performance scores (Bench 1 and Bench 3)
- **FactInterventionParticipation** – intervention participation, status, and sessions attended

The model supports filtering across schools, grades, and interventions while maintaining accurate aggregation.

---

## Key Concepts

### Benchmarks (Bench 1 vs Bench 3)

- **Bench 1** represents an earlier assessment (starting point)
- **Bench 3** represents a later assessment (ending point)

Growth is calculated as:


Growth = Bench 3 – Bench 1


This allows measurement of student improvement over time.

---

### Intervention Coverage Gap

The coverage gap measures alignment between student need and support:


Coverage Gap = High-Risk Rate – Intervention Rate


- Positive gap → underserved students
- Near zero → strong alignment
- Negative gap → proactive or broad intervention coverage

---

## Dashboard Pages

### 1. Overview (District-Level View)

Provides a high-level snapshot across all schools:

- Total students
- High-risk rate
- Intervention rate
- Attendance rate

Visuals include:
- Scatter plot (performance vs attendance)
- Coverage gap by school
- School comparison matrix

**Purpose:**
Identify which schools are performing well and which require attention.

---

### 2. School Detail (Drill-Down Analysis)

Allows deeper analysis at the school level:

- KPI metrics for selected school
- Grade-level performance breakdown
- Detailed matrix of risk, intervention, attendance, and outcomes

**Purpose:**
Diagnose where performance issues exist within a school.

---

### 3. Intervention Analysis (Impact Evaluation)

Focuses on intervention effectiveness:

- Students in intervention
- Completion rate
- Average sessions attended
- Growth (Bench 1 → Bench 3)

Key visual:
- Comparison of growth between intervention and non-intervention students

**Key Insight:**
Students receiving intervention demonstrate significantly greater growth compared to peers not in intervention.

---

## Key Findings

- Intervention students start at a lower baseline but show stronger improvement over time
- Non-intervention students start higher but show smaller gains
- Some schools show gaps between at-risk students and intervention coverage
- Negative coverage gaps suggest proactive or preventative intervention strategies

---

## Features

- Multi-page dashboard with intuitive navigation
- Drillthrough functionality for school-level analysis
- Dynamic filtering using slicers
- Context-aware DAX measures
- Intervention vs non-intervention comparison logic

---

## Project Structure


/screenshots
/sql
/powerbi
/docs


- Screenshots: dashboard visuals
- SQL: data model and data generation scripts
- Power BI: `.pbix` file
- Docs: project explanation and notes

---

## Purpose

This project demonstrates how data can be used to:

- identify at-risk populations
- evaluate intervention effectiveness
- support data-driven decision-making

It is designed as a portfolio project showcasing end-to-end analytics development.

---

## Author

Built as a portfolio project to demonstrate data analytics, business intelligence, and data storytelling skills.
