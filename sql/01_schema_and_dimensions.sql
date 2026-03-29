/* =========================================================
   01_schema_and_dimensions.sql
   Education Intervention Effectiveness Dashboard
   SQL Server schema build script
   ========================================================= */

IF DB_ID('EduConsultingBI') IS NULL
BEGIN
    CREATE DATABASE EduConsultingBI;
END
GO

USE EduConsultingBI;
GO

/* ---------- Drop tables ---------- */
IF OBJECT_ID('dbo.FactInterventionParticipation','U') IS NOT NULL DROP TABLE dbo.FactInterventionParticipation;
IF OBJECT_ID('dbo.FactAttendanceDaily','U') IS NOT NULL DROP TABLE dbo.FactAttendanceDaily;
IF OBJECT_ID('dbo.FactAssessment','U') IS NOT NULL DROP TABLE dbo.FactAssessment;

IF OBJECT_ID('dbo.DimStudent','U') IS NOT NULL DROP TABLE dbo.DimStudent;
IF OBJECT_ID('dbo.DimIntervention','U') IS NOT NULL DROP TABLE dbo.DimIntervention;
IF OBJECT_ID('dbo.DimDate','U') IS NOT NULL DROP TABLE dbo.DimDate;
IF OBJECT_ID('dbo.DimSubject','U') IS NOT NULL DROP TABLE dbo.DimSubject;
IF OBJECT_ID('dbo.DimGrade','U') IS NOT NULL DROP TABLE dbo.DimGrade;
IF OBJECT_ID('dbo.DimSchool','U') IS NOT NULL DROP TABLE dbo.DimSchool;
GO

/* ---------- Dimensions ---------- */

CREATE TABLE dbo.DimSchool (
    SchoolID INT PRIMARY KEY,
    SchoolName NVARCHAR(150),
    DistrictName NVARCHAR(150),
    City NVARCHAR(100),
    State CHAR(2),
    SchoolType NVARCHAR(20),
    EnrollmentCapacity INT
);

CREATE TABLE dbo.DimGrade (
    GradeID INT PRIMARY KEY,
    GradeLabel NVARCHAR(10)
);

CREATE TABLE dbo.DimSubject (
    SubjectID INT PRIMARY KEY,
    SubjectName NVARCHAR(50)
);

CREATE TABLE dbo.DimDate (
    DateKey INT PRIMARY KEY,
    [Date] DATE,
    SchoolYear NVARCHAR(9),
    Term NVARCHAR(10),
    MonthName NVARCHAR(20),
    MonthNumber TINYINT,
    WeekOfYear TINYINT,
    IsSchoolDay BIT
);

CREATE TABLE dbo.DimIntervention (
    InterventionID INT PRIMARY KEY,
    InterventionName NVARCHAR(150),
    Category NVARCHAR(30),
    TargetSubjectID INT,
    Tier TINYINT
);

CREATE TABLE dbo.DimStudent (
    StudentID INT PRIMARY KEY,
    SchoolID INT,
    GradeID INT,
    CohortYear INT,
    Gender CHAR(1),
    Ethnicity NVARCHAR(30),
    FRL_Flag BIT,
    SPED_Flag BIT,
    ELL_Flag BIT
);

/* ---------- Facts ---------- */

CREATE TABLE dbo.FactAssessment (
    AssessmentID BIGINT IDENTITY PRIMARY KEY,
    StudentID INT,
    SchoolID INT,
    SubjectID INT,
    DateKey INT,
    AssessmentType NVARCHAR(20),
    Score DECIMAL(5,2),
    ProficiencyLevel NVARCHAR(15),
    ProficientFlag BIT,
    Percentile TINYINT
);

CREATE TABLE dbo.FactAttendanceDaily (
    AttendanceID BIGINT IDENTITY PRIMARY KEY,
    StudentID INT,
    SchoolID INT,
    DateKey INT,
    AttendanceStatus NVARCHAR(10),
    PresentFlag BIT,
    AbsentFlag BIT,
    MinutesAbsent SMALLINT,
    ExcusedFlag BIT
);

CREATE TABLE dbo.FactInterventionParticipation (
    ParticipationID BIGINT IDENTITY PRIMARY KEY,
    StudentID INT,
    InterventionID INT,
    StartDateKey INT,
    EndDateKey INT,
    SessionsPlanned SMALLINT,
    SessionsAttended SMALLINT,
    Status NVARCHAR(12)
);
