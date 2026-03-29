# Key DAX Measures

## Overview

This project uses DAX measures to calculate key performance indicators related to student risk, intervention coverage, attendance, and academic growth.

The measures are designed to:
- Identify at-risk student populations
- Evaluate intervention participation and coverage
- Measure academic improvement over time
- Adapt dynamically to filter context within visuals

---

## Risk Classification

### Risk Tier

```DAX
Risk Tier =
VAR r = [Attendance Risk Flag] + [Academic Risk Flag]
RETURN
SWITCH(
    TRUE(),
    r >= 2, "High",
    r = 1, "Moderate",
    "Low"
)

This measure classifies students into risk tiers based on combined academic and attendance risk signals.

Core Metrics
Students
Students =
DISTINCTCOUNT(DimStudent[StudentID])
High Risk Students
High Risk Students =
COALESCE(
    CALCULATE(
        DISTINCTCOUNT(DimStudent[StudentID]),
        KEEPFILTERS(
            FILTER(
                DimStudent,
                [Risk Tier] = "High"
            )
        )
    ),
    0
)
Students in Intervention
Students in Intervention =
DISTINCTCOUNT(FactInterventionParticipation[StudentID])
Rate & Coverage Metrics
% High Risk
% High Risk =
COALESCE(
    DIVIDE([High Risk Students], [Students]),
    0
)
% Students in Intervention
% Students in Intervention =
COALESCE(
    DIVIDE([Students in Intervention], [Students]),
    0
)
% High Risk Covered
% High Risk Covered =
COALESCE(
    DIVIDE([High Risk In Intervention], [High Risk Students]),
    0
)
Coverage Gap
Coverage Gap =
COALESCE([% High Risk], 0) - COALESCE([% Students in Intervention], 0)

The coverage gap measures alignment between student need and intervention support:

Positive → underserved students
Near zero → strong alignment
Negative → proactive or expanded support
Attendance Metric
Attendance Rate
Attendance Rate =
COALESCE(
    DIVIDE(
        SUM(FactAttendanceDaily[PresentFlag]),
        COUNTROWS(FactAttendanceDaily)
    ),
    0
)

This measure calculates the proportion of days students are present.

Growth Metrics
Growth (B3 - B1)
Growth (B3 - B1) =
VAR Bench1 =
    CALCULATE(
        AVERAGE(FactAssessment[Score]),
        FactAssessment[DateKey] = 20241015
    )
VAR Bench3 =
    CALCULATE(
        AVERAGE(FactAssessment[Score]),
        FactAssessment[DateKey] = 20250420
    )
RETURN
    Bench3 - Bench1

This measure calculates academic improvement between the first and final benchmark assessments.

Growth (Intervention Matrix)
Growth (Intervention Matrix) =
VAR InterventionStudents =
    CALCULATETABLE(
        VALUES(FactInterventionParticipation[StudentID]),
        KEEPFILTERS(VALUES(DimIntervention[InterventionName]))
    )
VAR Bench1 =
    CALCULATE(
        AVERAGE(FactAssessment[Score]),
        FactAssessment[DateKey] = 20241015,
        TREATAS(InterventionStudents, DimStudent[StudentID])
    )
VAR Bench3 =
    CALCULATE(
        AVERAGE(FactAssessment[Score]),
        FactAssessment[DateKey] = 20250420,
        TREATAS(InterventionStudents, DimStudent[StudentID])
    )
RETURN
IF(
    ISINSCOPE(DimIntervention[InterventionName]),
    Bench3 - Bench1,
    BLANK()
)

This measure is designed for matrix visuals and ensures growth is only displayed at the intervention level.

Growth (Intervention KPI)
Growth (Intervention KPI) =
VAR InterventionStudents =
    VALUES(FactInterventionParticipation[StudentID])
VAR Bench1 =
    CALCULATE(
        AVERAGE(FactAssessment[Score]),
        FactAssessment[DateKey] = 20241015,
        TREATAS(InterventionStudents, DimStudent[StudentID])
    )
VAR Bench3 =
    CALCULATE(
        AVERAGE(FactAssessment[Score]),
        FactAssessment[DateKey] = 20250420,
        TREATAS(InterventionStudents, DimStudent[StudentID])
    )
RETURN
    Bench3 - Bench1

This KPI measure isolates intervention students and calculates their growth independently of other filters.

Summary

These measures collectively power the dashboard by:

Defining student risk levels
Measuring intervention participation and alignment
Calculating attendance and performance trends
Evaluating the effectiveness of intervention programs

They demonstrate the use of filter context, row context, and advanced DAX techniques such as CALCULATE, TREATAS, and ISINSCOPE.
