/* =========================================================
   02_seed_and_mock_data.sql
   Mock data generation
   ========================================================= */

USE EduConsultingBI;
GO

/* ---------- Students ---------- */

DECLARE @StartStudentID INT = 50000;

INSERT INTO dbo.DimStudent
SELECT TOP 2000
    @StartStudentID + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    101 + (ABS(CHECKSUM(NEWID())) % 4),
    ABS(CHECKSUM(NEWID())) % 13,
    2026,
    CASE WHEN RAND(CHECKSUM(NEWID())) > .5 THEN 'M' ELSE 'F' END,
    'Mixed',
    ABS(CHECKSUM(NEWID())) % 2,
    ABS(CHECKSUM(NEWID())) % 2,
    ABS(CHECKSUM(NEWID())) % 2
FROM sys.objects;

/* ---------- Assessments ---------- */

INSERT INTO dbo.FactAssessment
SELECT
    StudentID,
    SchoolID,
    CASE WHEN RAND(CHECKSUM(NEWID())) > .5 THEN 10 ELSE 20 END,
    20241015,
    'Benchmark',
    60 + (ABS(CHECKSUM(NEWID())) % 30),
    'Basic',
    0,
    ABS(CHECKSUM(NEWID())) % 100
FROM dbo.DimStudent;
