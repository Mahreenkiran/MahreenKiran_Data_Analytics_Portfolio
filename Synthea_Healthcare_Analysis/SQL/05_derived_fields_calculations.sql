/* =========================================================
   SYNTHEA HEALTHCARE ANALYSIS
   DERIVED FIELDS AND CALCULATIONS
   ========================================================= */


/* =========================================================
   1. PATIENT AGE
   What is each patient's current age,
   or age at death if deceased?
   ========================================================= */

SELECT
    PatientID,
    BIRTHDATE,
    DEATHDATE,
    CASE
        WHEN DEATHDATE IS NULL
            THEN DATEDIFF(YEAR, BIRTHDATE, GETDATE())
        ELSE
            DATEDIFF(YEAR, BIRTHDATE, DEATHDATE)
    END AS Age
FROM SyntheticData.Patients;


/* =========================================================
   2. PATIENT AGE GROUP
   Group patients into age bands
   ========================================================= */

SELECT
    PatientID,
    AGE,
    CASE
        WHEN AGE >= 0 AND AGE <= 17 THEN '0-17'
        WHEN AGE >= 18 AND AGE <= 34 THEN '18-34'
        WHEN AGE >= 35 AND AGE <= 49 THEN '35-49'
        WHEN AGE >= 50 AND AGE <= 64 THEN '50-64'
        ELSE '65+'
    END AS AgeGroup
FROM SyntheticData.Patients;


/* =========================================================
   3. PATIENT STATUS
   Classify patients as Alive or Deceased
   ========================================================= */

SELECT
    PatientID,
    BIRTHDATE,
    DEATHDATE,
    CASE
        WHEN DEATHDATE IS NOT NULL THEN 'DECEASED'
        ELSE 'ALIVE'
    END AS PatientStatus
FROM SyntheticData.Patients;


/* =========================================================
   4. ENCOUNTER DURATION
   Calculate encounter duration in hours
   ========================================================= */

SELECT
    EncounterID,
    PatientID,
    START,
    STOP,
    DATEDIFF(HOUR, START, STOP) AS EncounterDurationHours
FROM SyntheticData.Encounters;


/* =========================================================
   5. MEDICATION DURATION
   Calculate medication duration in days
   ========================================================= */

SELECT
    PatientID,
    EncounterID,
    START,
    STOP,
    CASE
        WHEN STOP IS NOT NULL
            THEN DATEDIFF(DAY, START, STOP)
    END AS MedicationDurationDays
FROM SyntheticData.Medications;


/* =========================================================
   6. CONDITION DURATION
   Calculate condition duration in days
   ========================================================= */

SELECT
    PatientID,
    EncounterID,
    START,
    STOP,
    DATEDIFF(DAY, START, STOP) AS ConditionDurationDays
FROM SyntheticData.Conditions;


/* =========================================================
   7. ENCOUNTER YEAR AND MONTH
   Extract encounter year and month
   ========================================================= */

SELECT
    EncounterID,
    START,
    STOP,
    YEAR(START) AS EncounterYear,
    MONTH(START) AS EncounterMonth
FROM SyntheticData.Encounters;


/* =========================================================
   8. ENCOUNTER YEAR-MONTH
   Create reporting field such as 2020-03

   START is stored as text, therefore TRY_CAST is used
   before FORMAT.
   ========================================================= */

SELECT
    EncounterID,
    START,
    FORMAT(
        TRY_CAST(START AS datetime2),
        'yyyy-MM'
    ) AS EncounterYearMonth
FROM SyntheticData.Encounters;


/* =========================================================
   9. PATIENT HEALTHCARE COVERAGE PERCENTAGE
   Calculate percentage of healthcare expenses covered
   ========================================================= */

SELECT
    PatientID,
    HEALTHCARE_EXPENSES,
    HEALTHCARE_COVERAGE,
    CASE
        WHEN HEALTHCARE_EXPENSES <> 0 THEN
            ROUND(
                (HEALTHCARE_COVERAGE / HEALTHCARE_EXPENSES) * 100,
                2
            )
        ELSE 0
    END AS CoveragePercentage
FROM SyntheticData.Patients;


/* =========================================================
   10. UNCOVERED HEALTHCARE EXPENSE
   Calculate healthcare expenses not covered
   ========================================================= */

SELECT
    PatientID,
    HEALTHCARE_EXPENSES,
    HEALTHCARE_COVERAGE,
    (HEALTHCARE_EXPENSES - HEALTHCARE_COVERAGE)
        AS UncoveredHealthcareExpense
FROM SyntheticData.Patients;


/* =========================================================
   11. ENCOUNTER PAYER COVERAGE PERCENTAGE
   Calculate percentage of each claim covered by payer
   ========================================================= */

SELECT
    EncounterID,
    BASE_ENCOUNTER_COST,
    TOTAL_CLAIM_COST,
    PAYER_COVERAGE,
    ROUND(
        (PAYER_COVERAGE / NULLIF(TOTAL_CLAIM_COST, 0)) * 100,
        2
    ) AS CoveragePercentage
FROM SyntheticData.Encounters;


/* =========================================================
   12. OUT OF POCKET AMOUNT
   Calculate amount not covered by payer
   ========================================================= */

SELECT
    EncounterID,
    BASE_ENCOUNTER_COST,
    TOTAL_CLAIM_COST,
    PAYER_COVERAGE,
    (TOTAL_CLAIM_COST - PAYER_COVERAGE)
        AS OutOfPocketAmount
FROM SyntheticData.Encounters;


/* =========================================================
   13A. ENCOUNTER COST BANDS
   Categorise encounters using TOTAL_CLAIM_COST

   13B. Encounter cost segmentation.

   NOTE:
   These thresholds can be refined later based on the
   actual claim cost distribution.
   ========================================================= */

SELECT
    EncounterID,
    TOTAL_CLAIM_COST,
    CASE
        WHEN TOTAL_CLAIM_COST < 1000 THEN 'Low Cost'
        WHEN TOTAL_CLAIM_COST >= 1000
             AND TOTAL_CLAIM_COST < 5000 THEN 'Medium Cost'
        ELSE 'High Cost'
    END AS CostBand
FROM SyntheticData.Encounters;

--13.B Encounter cost segmentation.

WITH CTE AS
(
    SELECT
        TOTAL_CLAIM_COST,
        CASE
            WHEN TOTAL_CLAIM_COST < 1000 THEN 'Low Cost'
            WHEN TOTAL_CLAIM_COST >= 1000
                 AND TOTAL_CLAIM_COST < 5000 THEN 'Medium Cost'
            ELSE 'High Cost'
        END AS CostBand
    FROM SyntheticData.Encounters
)
SELECT
    CostBand,
    COUNT(*) AS Frequency
FROM CTE
GROUP BY CostBand
ORDER BY Frequency DESC;

/* =========================================================
   14. NUMBER OF ENCOUNTERS PER PATIENT
   ========================================================= */

SELECT
    PatientID,
    COUNT(EncounterID) AS EncounterCount
FROM SyntheticData.Encounters
GROUP BY PatientID
ORDER BY PatientID;


/* =========================================================
   15. PATIENT UTILISATION GROUP
   Classify patients based on encounter count
   ========================================================= */

WITH EncounterCounts AS
(
    SELECT
        PatientID,
        COUNT(EncounterID) AS EncounterCount
    FROM SyntheticData.Encounters
    GROUP BY PatientID
),
UtilisationGroups AS
(
    SELECT
        PatientID,
        EncounterCount,
        CASE
            WHEN EncounterCount <= 50 THEN 'Low Utilisation'
            WHEN EncounterCount <= 250 THEN 'Medium Utilisation'
            ELSE 'High Utilisation'
        END AS UtilisationGroup
    FROM EncounterCounts
)
SELECT
    PatientID,
    EncounterCount,
    UtilisationGroup
FROM UtilisationGroups;


/* =========================================================
   16. NUMBER OF PATIENTS BY UTILISATION GROUP
   ========================================================= */

WITH EncounterCounts AS
(
    SELECT
        PatientID,
        COUNT(EncounterID) AS EncounterCount
    FROM SyntheticData.Encounters
    GROUP BY PatientID
),
UtilisationGroups AS
(
    SELECT
        PatientID,
        EncounterCount,
        CASE
            WHEN EncounterCount <= 50 THEN 'Low Utilisation'
            WHEN EncounterCount <= 250 THEN 'Medium Utilisation'
            ELSE 'High Utilisation'
        END AS UtilisationGroup
    FROM EncounterCounts
)
SELECT
    UtilisationGroup,
    COUNT(*) AS PatientCount
FROM UtilisationGroups
GROUP BY UtilisationGroup
ORDER BY PatientCount DESC;