/* =========================================================
   SYNTHEA HEALTHCARE ANALYSIS
   DATA QUALITY VALIDATION
   ========================================================= */

/* =========================================================
   1. ROW COUNTS
   ========================================================= */

SELECT 'Patients' AS [TableName], COUNT(*) AS [RowCount]
FROM [SyntheticData].[Patients]

UNION ALL

SELECT 'Encounters', COUNT(*)
FROM [SyntheticData].[Encounters]

UNION ALL

SELECT 'Conditions', COUNT(*)
FROM [SyntheticData].[Conditions]

UNION ALL

SELECT 'Medications', COUNT(*)
FROM [SyntheticData].[Medications]

UNION ALL

SELECT 'Procedures', COUNT(*)
FROM [SyntheticData].[Procedures]

UNION ALL

SELECT 'Allergies', COUNT(*)
FROM [SyntheticData].[Allergies]

UNION ALL

SELECT 'Careplans', COUNT(*)
FROM [SyntheticData].[Careplans];


/* =========================================================
   2. DUPLICATE PRIMARY KEY CHECKS
   ========================================================= */


/* ---------------------------------------------------------
   2.1 Check for duplicate PatientID values
   --------------------------------------------------------- */

SELECT
    PatientID,
    COUNT(*) AS DuplicateCount
FROM SyntheticData.Patients
GROUP BY PatientID
HAVING COUNT(*) > 1;


/* ---------------------------------------------------------
   2.2 Check for duplicate EncounterID values
   --------------------------------------------------------- */

SELECT
    EncounterID,
    COUNT(*) AS DuplicateCount
FROM SyntheticData.Encounters
GROUP BY EncounterID
HAVING COUNT(*) > 1;


/* ---------------------------------------------------------
   2.3 Check for duplicate CareplanID values
   --------------------------------------------------------- */

SELECT
    CareplanID,
    COUNT(*) AS DuplicateCount
FROM SyntheticData.Careplans
GROUP BY CareplanID
HAVING COUNT(*) > 1;


/* =========================================================
   3. NULL PRIMARY KEY CHECKS
   ========================================================= */


/* ---------------------------------------------------------
   3.1 Check for NULL PatientID values
   --------------------------------------------------------- */

SELECT *
FROM SyntheticData.Patients
WHERE PatientID IS NULL;


/* ---------------------------------------------------------
   3.2 Check for NULL EncounterID values
   --------------------------------------------------------- */

SELECT *
FROM SyntheticData.Encounters
WHERE EncounterID IS NULL;


/* ---------------------------------------------------------
   3.3 Check for NULL CareplanID values
   --------------------------------------------------------- */

SELECT *
FROM SyntheticData.Careplans
WHERE CareplanID IS NULL;


/* =========================================================
   4. REFERENTIAL INTEGRITY CHECKS
   PATIENT RELATIONSHIPS
   ========================================================= */


/* ---------------------------------------------------------
   4.1 Check for Encounters with unmatched PatientID values
   --------------------------------------------------------- */

SELECT
    E.*
FROM SyntheticData.Encounters AS E
LEFT JOIN SyntheticData.Patients AS P
    ON E.PatientID = P.PatientID
WHERE P.PatientID IS NULL;


/* ---------------------------------------------------------
   4.2 Check for Conditions with unmatched PatientID values
   --------------------------------------------------------- */

SELECT
    C.*
FROM SyntheticData.Conditions AS C
LEFT JOIN SyntheticData.Patients AS P
    ON C.PatientID = P.PatientID
WHERE P.PatientID IS NULL;


/* ---------------------------------------------------------
   4.3 Check for Medications with unmatched PatientID values
   --------------------------------------------------------- */

SELECT
    M.*
FROM SyntheticData.Medications AS M
LEFT JOIN SyntheticData.Patients AS P
    ON M.PatientID = P.PatientID
WHERE P.PatientID IS NULL;


/* ---------------------------------------------------------
   4.4 Check for Procedures with unmatched PatientID values
   --------------------------------------------------------- */

SELECT
    PR.*
FROM SyntheticData.Procedures AS PR
LEFT JOIN SyntheticData.Patients AS P
    ON PR.PatientID = P.PatientID
WHERE P.PatientID IS NULL;


/* ---------------------------------------------------------
   4.5 Check for Allergies with unmatched PatientID values
   --------------------------------------------------------- */

SELECT
    A.*
FROM SyntheticData.Allergies AS A
LEFT JOIN SyntheticData.Patients AS P
    ON A.PatientID = P.PatientID
WHERE P.PatientID IS NULL;


/* ---------------------------------------------------------
   4.6 Check for Careplans with unmatched PatientID values
   --------------------------------------------------------- */

SELECT
    C.*
FROM SyntheticData.Careplans AS C
LEFT JOIN SyntheticData.Patients AS P
    ON C.PatientID = P.PatientID
WHERE P.PatientID IS NULL;


/* =========================================================
   5. REFERENTIAL INTEGRITY CHECKS
   ENCOUNTER RELATIONSHIPS
   ========================================================= */


/* ---------------------------------------------------------
   5.1 Check for Conditions with unmatched EncounterID values
   --------------------------------------------------------- */

SELECT
    C.*
FROM SyntheticData.Conditions AS C
LEFT JOIN SyntheticData.Encounters AS E
    ON C.EncounterID = E.EncounterID
WHERE E.EncounterID IS NULL;


/* ---------------------------------------------------------
   5.2 Check for Medications with unmatched EncounterID values
   --------------------------------------------------------- */

SELECT
    M.*
FROM SyntheticData.Medications AS M
LEFT JOIN SyntheticData.Encounters AS E
    ON M.EncounterID = E.EncounterID
WHERE E.EncounterID IS NULL;


/* ---------------------------------------------------------
   5.3 Check for Procedures with unmatched EncounterID values
   --------------------------------------------------------- */

SELECT
    P.*
FROM SyntheticData.Procedures AS P
LEFT JOIN SyntheticData.Encounters AS E
    ON P.EncounterID = E.EncounterID
WHERE E.EncounterID IS NULL;


/* ---------------------------------------------------------
   5.4 Check for Allergies with unmatched EncounterID values
   --------------------------------------------------------- */

SELECT
    A.*
FROM SyntheticData.Allergies AS A
LEFT JOIN SyntheticData.Encounters AS E
    ON A.EncounterID = E.EncounterID
WHERE E.EncounterID IS NULL;


/* ---------------------------------------------------------
   5.5 Check for Careplans with unmatched EncounterID values
   --------------------------------------------------------- */

SELECT
    C.*
FROM SyntheticData.Careplans AS C
LEFT JOIN SyntheticData.Encounters AS E
    ON C.EncounterID = E.EncounterID
WHERE E.EncounterID IS NULL;


