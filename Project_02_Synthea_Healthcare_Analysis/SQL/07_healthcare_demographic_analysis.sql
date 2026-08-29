/* =========================================================
   ADDITIONAL HEALTHCARE ANALYSIS
   DEMOGRAPHIC, GEOGRAPHIC AND CLINICAL PATTERNS
   ========================================================= */


/* =========================================================
   27. MOST COMMON CONDITIONS BY GENDER
   Which conditions are most common among male and
   female patients?
   ========================================================= */

SELECT
    P.GENDER,
    C.CODE,
    C.DESCRIPTION,
    COUNT(*) AS ConditionCount
FROM SyntheticData.Conditions AS C
INNER JOIN SyntheticData.Patients AS P
    ON C.PatientID = P.PatientID
GROUP BY
    P.GENDER,
    C.CODE,
    C.DESCRIPTION
ORDER BY
    P.GENDER,
    ConditionCount DESC;



/* =========================================================
   28. MOST COMMON CONDITIONS BY AGE GROUP
   ========================================================= */

SELECT
    CASE
        WHEN P.AGE >= 0 AND P.AGE <= 17 THEN '0-17'
        WHEN P.AGE >= 18 AND P.AGE <= 34 THEN '18-34'
        WHEN P.AGE >= 35 AND P.AGE <= 49 THEN '35-49'
        WHEN P.AGE >= 50 AND P.AGE <= 64 THEN '50-64'
        ELSE '65+'
    END AS AgeGroup,

    C.CODE,
    C.DESCRIPTION,
    COUNT(*) AS ConditionCount

FROM SyntheticData.Conditions AS C

INNER JOIN SyntheticData.Patients AS P
    ON C.PatientID = P.PatientID

GROUP BY
    CASE
        WHEN P.AGE >= 0 AND P.AGE <= 17 THEN '0-17'
        WHEN P.AGE >= 18 AND P.AGE <= 34 THEN '18-34'
        WHEN P.AGE >= 35 AND P.AGE <= 49 THEN '35-49'
        WHEN P.AGE >= 50 AND P.AGE <= 64 THEN '50-64'
        ELSE '65+'
    END,
    C.CODE,
    C.DESCRIPTION

ORDER BY
    AgeGroup,
    ConditionCount DESC;



/* =========================================================
   29. AREAS WITH THE HIGHEST CONDITION ACTIVITY
   Which states have the highest number of recorded
   conditions?
   ========================================================= */

SELECT
    P.STATE,
    COUNT(*) AS ConditionCount,
    COUNT(DISTINCT C.PatientID) AS PatientsWithConditions
FROM SyntheticData.Conditions AS C
INNER JOIN SyntheticData.Patients AS P
    ON C.PatientID = P.PatientID
GROUP BY P.STATE
ORDER BY ConditionCount DESC;



/* =========================================================
   30. MOST COMMON CONDITIONS BY STATE
   ========================================================= */

SELECT
    P.STATE,
    C.CODE,
    C.DESCRIPTION,
    COUNT(*) AS ConditionCount
FROM SyntheticData.Conditions AS C
INNER JOIN SyntheticData.Patients AS P
    ON C.PatientID = P.PatientID
GROUP BY
    P.STATE,
    C.CODE,
    C.DESCRIPTION
ORDER BY
    P.STATE,
    ConditionCount DESC;



/* =========================================================
   31. MOST COMMON CONDITIONS BY CITY
   ========================================================= */

SELECT
    P.CITY,
    C.CODE,
    C.DESCRIPTION,
    COUNT(*) AS ConditionCount
FROM SyntheticData.Conditions AS C
INNER JOIN SyntheticData.Patients AS P
    ON C.PatientID = P.PatientID
GROUP BY
    P.CITY,
    C.CODE,
    C.DESCRIPTION
ORDER BY
    P.CITY,
    ConditionCount DESC;



/* =========================================================
   32. HEALTHCARE UTILISATION BY STATE
   Which geographic areas have the highest number
   of encounters?
   ========================================================= */

SELECT
    P.STATE,
    COUNT(E.EncounterID) AS EncounterCount,
    COUNT(DISTINCT E.PatientID) AS PatientsWithEncounters
FROM SyntheticData.Encounters AS E
INNER JOIN SyntheticData.Patients AS P
    ON E.PatientID = P.PatientID
GROUP BY P.STATE
ORDER BY EncounterCount DESC;



/* =========================================================
   33. AVERAGE CLAIM COST BY STATE
   Which areas have the highest average claim cost?
   ========================================================= */

SELECT
    P.STATE,
    ROUND(AVG(E.TOTAL_CLAIM_COST), 2) AS AverageClaimCost,
    ROUND(SUM(E.TOTAL_CLAIM_COST), 2) AS TotalClaimCost
FROM SyntheticData.Encounters AS E
INNER JOIN SyntheticData.Patients AS P
    ON E.PatientID = P.PatientID
GROUP BY P.STATE
ORDER BY AverageClaimCost DESC;



/* =========================================================
   34. CONDITION BURDEN BY AGE GROUP
   Which age groups have the highest number of
   distinct conditions per patient?
   ========================================================= */

WITH PatientConditionBurden AS
(
    SELECT
        P.PatientID,

        CASE
            WHEN P.AGE >= 0 AND P.AGE <= 17 THEN '0-17'
            WHEN P.AGE >= 18 AND P.AGE <= 34 THEN '18-34'
            WHEN P.AGE >= 35 AND P.AGE <= 49 THEN '35-49'
            WHEN P.AGE >= 50 AND P.AGE <= 64 THEN '50-64'
            ELSE '65+'
        END AS AgeGroup,

        COUNT(DISTINCT C.CODE) AS NumberOfConditions

    FROM SyntheticData.Patients AS P

    INNER JOIN SyntheticData.Conditions AS C
        ON P.PatientID = C.PatientID

    GROUP BY
        P.PatientID,
        CASE
            WHEN P.AGE >= 0 AND P.AGE <= 17 THEN '0-17'
            WHEN P.AGE >= 18 AND P.AGE <= 34 THEN '18-34'
            WHEN P.AGE >= 35 AND P.AGE <= 49 THEN '35-49'
            WHEN P.AGE >= 50 AND P.AGE <= 64 THEN '50-64'
            ELSE '65+'
        END
)

SELECT
    AgeGroup,
    ROUND(AVG(CAST(NumberOfConditions AS decimal(10,2))), 2)
        AS AverageConditionsPerPatient
FROM PatientConditionBurden
GROUP BY AgeGroup
ORDER BY AverageConditionsPerPatient DESC;



/* =========================================================
   35. AVERAGE ENCOUNTERS PER PATIENT BY GENDER
   Which gender has the highest average healthcare
   utilisation?
   ========================================================= */

WITH PatientEncounters AS
(
    SELECT
        P.PatientID,
        P.GENDER,
        COUNT(E.EncounterID) AS EncounterCount

    FROM SyntheticData.Patients AS P

    LEFT JOIN SyntheticData.Encounters AS E
        ON P.PatientID = E.PatientID

    GROUP BY
        P.PatientID,
        P.GENDER
)

SELECT
    GENDER,
    ROUND(
        AVG(CAST(EncounterCount AS decimal(10,2))),
        2
    ) AS AverageEncountersPerPatient
FROM PatientEncounters
GROUP BY GENDER
ORDER BY AverageEncountersPerPatient DESC;



/* =========================================================
   36. CONDITIONS ASSOCIATED WITH THE HIGHEST
   AVERAGE CLAIM COST
   ========================================================= */

SELECT
    C.CODE,
    C.DESCRIPTION,
    COUNT(DISTINCT C.EncounterID) AS EncounterCount,
    ROUND(AVG(E.TOTAL_CLAIM_COST), 2) AS AverageClaimCost
FROM SyntheticData.Conditions AS C
INNER JOIN SyntheticData.Encounters AS E
    ON C.EncounterID = E.EncounterID
GROUP BY
    C.CODE,
    C.DESCRIPTION
ORDER BY AverageClaimCost DESC;



/* =========================================================
   37. CONDITIONS ASSOCIATED WITH MEDICATION ACTIVITY
   ========================================================= */

SELECT
    C.CODE AS ConditionCode,
    C.DESCRIPTION AS ConditionDescription,
    COUNT(DISTINCT M.CODE) AS DistinctMedicationCount,
    COUNT(DISTINCT M.EncounterID) AS MedicationEncounterCount
FROM SyntheticData.Conditions AS C
INNER JOIN SyntheticData.Medications AS M
    ON C.EncounterID = M.EncounterID
GROUP BY
    C.CODE,
    C.DESCRIPTION
ORDER BY MedicationEncounterCount DESC;



/* =========================================================
   38. CONDITIONS ASSOCIATED WITH PROCEDURE ACTIVITY
   ========================================================= */

SELECT
    C.CODE AS ConditionCode,
    C.DESCRIPTION AS ConditionDescription,
    COUNT(DISTINCT PR.CODE) AS DistinctProcedureCount,
    COUNT(DISTINCT PR.EncounterID) AS ProcedureEncounterCount
FROM SyntheticData.Conditions AS C
INNER JOIN SyntheticData.Procedures AS PR
    ON C.EncounterID = PR.EncounterID
GROUP BY
    C.CODE,
    C.DESCRIPTION
ORDER BY ProcedureEncounterCount DESC;