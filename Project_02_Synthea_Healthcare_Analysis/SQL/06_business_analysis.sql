/* =========================================================
   SYNTHEA HEALTHCARE ANALYSIS
   BUSINESS ANALYSIS QUERIES
   ========================================================= */


/* =========================================================
   1. OVERALL HEALTHCARE ACTIVITY
   What are the total number of patients, encounters,
   conditions, medications and procedures?
   ========================================================= */

SELECT COUNT(*) AS NumberOfPatients
FROM SyntheticData.Patients;

SELECT COUNT(*) AS NumberOfEncounters
FROM SyntheticData.Encounters;

SELECT COUNT(*) AS NumberOfConditions
FROM SyntheticData.Conditions;

SELECT COUNT(*) AS NumberOfMedications
FROM SyntheticData.Medications;

SELECT COUNT(*) AS NumberOfProcedures
FROM SyntheticData.Procedures;



/* =========================================================
   2. PATIENT DISTRIBUTION BY LIFE STATUS
   ========================================================= */

WITH LifeStatus AS
(
    SELECT
        CASE
            WHEN DEATHDATE IS NULL THEN 'ALIVE'
            ELSE 'DECEASED'
        END AS PatientStatus
    FROM SyntheticData.Patients
)
SELECT
    PatientStatus,
    COUNT(*) AS PatientCount
FROM LifeStatus
GROUP BY PatientStatus;



/* =========================================================
   3. PATIENT DISTRIBUTION BY GENDER
   ========================================================= */

SELECT
    GENDER,
    COUNT(*) AS PatientCount
FROM SyntheticData.Patients
GROUP BY GENDER
ORDER BY PatientCount DESC;



/* =========================================================
   4. PATIENT DISTRIBUTION BY AGE GROUP
   ========================================================= */

SELECT
    CASE
        WHEN AGE >= 0 AND AGE <= 17 THEN '0-17'
        WHEN AGE >= 18 AND AGE <= 34 THEN '18-34'
        WHEN AGE >= 35 AND AGE <= 49 THEN '35-49'
        WHEN AGE >= 50 AND AGE <= 64 THEN '50-64'
        ELSE '65+'
    END AS AgeGroup,
    COUNT(*) AS PatientCount
FROM SyntheticData.Patients
GROUP BY
    CASE
        WHEN AGE >= 0 AND AGE <= 17 THEN '0-17'
        WHEN AGE >= 18 AND AGE <= 34 THEN '18-34'
        WHEN AGE >= 35 AND AGE <= 49 THEN '35-49'
        WHEN AGE >= 50 AND AGE <= 64 THEN '50-64'
        ELSE '65+'
    END
ORDER BY PatientCount DESC;



/* =========================================================
   5. MOST COMMON CONDITIONS
   ========================================================= */

SELECT
    CODE,
    DESCRIPTION,
    COUNT(*) AS ConditionCount
FROM SyntheticData.Conditions
GROUP BY
    CODE,
    DESCRIPTION
ORDER BY ConditionCount DESC;



/* =========================================================
   6. MOST FREQUENT ENCOUNTER CLASSES
   ========================================================= */

SELECT
    ENCOUNTERCLASS,
    COUNT(*) AS EncounterCount
FROM SyntheticData.Encounters
GROUP BY ENCOUNTERCLASS
ORDER BY EncounterCount DESC;



/* =========================================================
   7. PATIENTS WITH THE HIGHEST NUMBER OF ENCOUNTERS
   ========================================================= */

SELECT
    PatientID,
    COUNT(*) AS EncounterCount
FROM SyntheticData.Encounters
GROUP BY PatientID
ORDER BY EncounterCount DESC;



/* =========================================================
   8. TOP 10 PATIENTS BY ENCOUNTER COUNT
   ========================================================= */

SELECT TOP 10
    PatientID,
    COUNT(*) AS EncounterCount
FROM SyntheticData.Encounters
GROUP BY PatientID
ORDER BY EncounterCount DESC;



/* =========================================================
   9. MOST COMMONLY PRESCRIBED MEDICATIONS
   ========================================================= */

SELECT
    CODE,
    DESCRIPTION,
    COUNT(*) AS MedicationCount
FROM SyntheticData.Medications
GROUP BY
    CODE,
    DESCRIPTION
ORDER BY MedicationCount DESC;



/* =========================================================
   10. MOST COMMON PROCEDURES
   ========================================================= */

SELECT
    CODE,
    DESCRIPTION,
    COUNT(*) AS ProcedureCount
FROM SyntheticData.Procedures
GROUP BY
    CODE,
    DESCRIPTION
ORDER BY ProcedureCount DESC;



/* =========================================================
   11. TOTAL AND AVERAGE CLAIM COST
   BY ENCOUNTER CLASS
   ========================================================= */

SELECT
    ENCOUNTERCLASS,
    ROUND(SUM(TOTAL_CLAIM_COST), 2) AS TotalClaimCost,
    ROUND(AVG(TOTAL_CLAIM_COST), 2) AS AverageClaimCost
FROM SyntheticData.Encounters
GROUP BY ENCOUNTERCLASS
ORDER BY TotalClaimCost DESC;



/* =========================================================
   12. AVERAGE OUT OF POCKET COST
   BY ENCOUNTER CLASS
   ========================================================= */

SELECT
    ENCOUNTERCLASS,
    ROUND(
        AVG(TOTAL_CLAIM_COST - PAYER_COVERAGE),
        2
    ) AS AverageOutOfPocketCost
FROM SyntheticData.Encounters
GROUP BY ENCOUNTERCLASS
ORDER BY AverageOutOfPocketCost DESC;



/* =========================================================
   13. HEALTHCARE UTILISATION BY YEAR AND MONTH
   ========================================================= */

SELECT
    YEAR(START) AS EncounterYear,
    MONTH(START) AS EncounterMonth,
    COUNT(EncounterID) AS EncounterCount
FROM SyntheticData.Encounters
GROUP BY
    YEAR(START),
    MONTH(START)
ORDER BY
    EncounterYear,
    EncounterMonth;



/* =========================================================
   14. HEALTHCARE UTILISATION AND CLAIM COST
   BY YEAR AND MONTH
   ========================================================= */

SELECT
    YEAR(START) AS EncounterYear,
    MONTH(START) AS EncounterMonth,
    COUNT(EncounterID) AS EncounterCount,
    ROUND(SUM(TOTAL_CLAIM_COST), 2) AS TotalClaimCost
FROM SyntheticData.Encounters
GROUP BY
    YEAR(START),
    MONTH(START)
ORDER BY
    EncounterYear,
    EncounterMonth;



/* =========================================================
   15. HEALTHCARE UTILISATION BY AGE GROUP
   ========================================================= */

SELECT
    CASE
        WHEN P.AGE >= 0 AND P.AGE <= 17 THEN '0-17'
        WHEN P.AGE >= 18 AND P.AGE <= 34 THEN '18-34'
        WHEN P.AGE >= 35 AND P.AGE <= 49 THEN '35-49'
        WHEN P.AGE >= 50 AND P.AGE <= 64 THEN '50-64'
        ELSE '65+'
    END AS AgeGroup,

    COUNT(E.EncounterID) AS EncounterCount

FROM SyntheticData.Patients AS P

INNER JOIN SyntheticData.Encounters AS E
    ON P.PatientID = E.PatientID

GROUP BY
    CASE
        WHEN P.AGE >= 0 AND P.AGE <= 17 THEN '0-17'
        WHEN P.AGE >= 18 AND P.AGE <= 34 THEN '18-34'
        WHEN P.AGE >= 35 AND P.AGE <= 49 THEN '35-49'
        WHEN P.AGE >= 50 AND P.AGE <= 64 THEN '50-64'
        ELSE '65+'
    END

ORDER BY EncounterCount DESC;



/* =========================================================
   16. PATIENT CONDITION BURDEN
   Number of distinct conditions per patient
   ========================================================= */

SELECT
    PatientID,
    COUNT(DISTINCT CODE) AS NumberOfConditions
FROM SyntheticData.Conditions
GROUP BY PatientID
ORDER BY NumberOfConditions DESC;



/* =========================================================
   17. PATIENTS WITH MULTIPLE CONDITIONS
   ========================================================= */

SELECT
    PatientID,
    COUNT(DISTINCT CODE) AS NumberOfConditions
FROM SyntheticData.Conditions
GROUP BY PatientID
HAVING COUNT(DISTINCT CODE) > 1
ORDER BY NumberOfConditions DESC;



/* =========================================================
   18. PATIENT UTILISATION GROUPS
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
   19. NUMBER OF PATIENTS BY UTILISATION GROUP
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



/* =========================================================
   20. PROPORTION OF PATIENTS
   BY UTILISATION GROUP
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
    COUNT(*) AS PatientCount,

    ROUND(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER(),
        2
    ) AS PatientPercentage

FROM UtilisationGroups

GROUP BY UtilisationGroup
ORDER BY PatientCount DESC;



/* =========================================================
   21. ENCOUNTER COST BANDS
   ========================================================= */

SELECT
    TOTAL_CLAIM_COST,
    CASE
        WHEN TOTAL_CLAIM_COST < 1000 THEN 'Low Cost'
        WHEN TOTAL_CLAIM_COST >= 1000
             AND TOTAL_CLAIM_COST < 5000 THEN 'Medium Cost'
        ELSE 'High Cost'
    END AS CostBand
FROM SyntheticData.Encounters;



/* =========================================================
   22. NUMBER OF ENCOUNTERS BY COST BAND
   ========================================================= */

WITH CostGroups AS
(
    SELECT
        EncounterID,
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
    COUNT(*) AS EncounterCount
FROM CostGroups
GROUP BY CostBand
ORDER BY EncounterCount DESC;



/* =========================================================
   23. PROPORTION OF ENCOUNTERS
   BY COST BAND
   ========================================================= */

WITH CostGroups AS
(
    SELECT
        EncounterID,
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
    COUNT(*) AS EncounterCount,

    ROUND(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER(),
        2
    ) AS EncounterPercentage

FROM CostGroups

GROUP BY CostBand
ORDER BY EncounterCount DESC;



/* =========================================================
   24. CONDITIONS ASSOCIATED WITH
   THE HIGHEST ENCOUNTER UTILISATION
   ========================================================= */

SELECT
    CODE,
    DESCRIPTION,
    COUNT(DISTINCT EncounterID) AS EncounterCount
FROM SyntheticData.Conditions
GROUP BY
    CODE,
    DESCRIPTION
ORDER BY EncounterCount DESC;



/* =========================================================
   25. CONDITIONS ASSOCIATED WITH
   MEDICATION TREATMENT ACTIVITY

   Uses EncounterID to connect conditions and medications.
   COUNT(DISTINCT) is used to reduce duplication.
   ========================================================= */

SELECT
    C.CODE AS ConditionCode,
    C.DESCRIPTION AS ConditionDescription,
    COUNT(DISTINCT M.CODE) AS DistinctMedicationCount
FROM SyntheticData.Conditions AS C

INNER JOIN SyntheticData.Medications AS M
    ON C.EncounterID = M.EncounterID

GROUP BY
    C.CODE,
    C.DESCRIPTION

ORDER BY DistinctMedicationCount DESC;



/* =========================================================
   26. CONDITIONS ASSOCIATED WITH
   PROCEDURE TREATMENT ACTIVITY
   ========================================================= */

SELECT
    C.CODE AS ConditionCode,
    C.DESCRIPTION AS ConditionDescription,
    COUNT(DISTINCT P.CODE) AS DistinctProcedureCount
FROM SyntheticData.Conditions AS C

INNER JOIN SyntheticData.Procedures AS P
    ON C.EncounterID = P.EncounterID

GROUP BY
    C.CODE,
    C.DESCRIPTION

ORDER BY DistinctProcedureCount DESC;