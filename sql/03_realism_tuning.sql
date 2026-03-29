/* =========================================================
   03_realism_tuning.sql
   Intervention effect tuning
   ========================================================= */

USE EduConsultingBI;
GO

/* ---------- Adjust Bench 1 ---------- */

UPDATE dbo.FactAssessment
SET Score = Score - 3
WHERE DateKey = 20241015;

/* ---------- Adjust Bench 3 ---------- */

UPDATE dbo.FactAssessment
SET Score = Score + 5
WHERE DateKey = 20250420;

/* ---------- Recalculate proficiency ---------- */

UPDATE dbo.FactAssessment
SET ProficiencyLevel =
    CASE
        WHEN Score < 50 THEN 'Below'
        WHEN Score < 65 THEN 'Basic'
        WHEN Score < 85 THEN 'Proficient'
        ELSE 'Advanced'
    END,
    ProficientFlag = CASE WHEN Score >= 65 THEN 1 ELSE 0 END;
