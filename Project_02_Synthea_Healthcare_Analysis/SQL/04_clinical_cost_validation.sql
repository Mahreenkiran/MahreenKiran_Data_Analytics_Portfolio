/* =========================================================
   7. CLINICAL FIELD, COST AND DATA COVERAGE VALIDATION
   ========================================================= */


/* =========================================================
   7.1 CONDITIONS
   Check for missing clinical codes and descriptions
   ========================================================= */

-- Check for NULL or blank DESCRIPTION values in Conditions
SELECT *
FROM SyntheticData.Conditions
WHERE DESCRIPTION IS NULL
   OR TRIM(DESCRIPTION) = '';

-- Check for NULL or blank CODE values in Conditions
SELECT *
FROM SyntheticData.Conditions
WHERE CODE IS NULL
;


/* =========================================================
   7.2 MEDICATIONS
   Check for missing clinical codes and descriptions
   ========================================================= */

-- Check for NULL or blank DESCRIPTION values in Medications
SELECT *
FROM SyntheticData.Medications
WHERE DESCRIPTION IS NULL
   OR TRIM(DESCRIPTION) = '';

-- Check for NULL or blank CODE values in Medications
SELECT *
FROM SyntheticData.Medications
WHERE CODE IS NULL;


/* =========================================================
   7.3 PROCEDURES
   Check for missing clinical codes and descriptions
   ========================================================= */

-- Check for NULL or blank DESCRIPTION values in Procedures
SELECT *
FROM SyntheticData.Procedures
WHERE DESCRIPTION IS NULL
   OR TRIM(DESCRIPTION) = '';

-- Check for NULL or blank CODE values in Procedures
SELECT *
FROM SyntheticData.Procedures
WHERE CODE IS NULL;


/* =========================================================
   7.4 ALLERGIES
   Check for missing clinical codes and descriptions
   ========================================================= */

-- Check for NULL or blank DESCRIPTION values in Allergies
SELECT *
FROM SyntheticData.Allergies
WHERE DESCRIPTION IS NULL
   OR TRIM(DESCRIPTION) = '';

-- Check for NULL or blank CODE values in Allergies
SELECT *
FROM SyntheticData.Allergies
WHERE CODE IS NULL
;


/* =========================================================
   7.5 CAREPLANS
   Check for missing clinical codes and descriptions
   ========================================================= */

-- Check for NULL or blank DESCRIPTION values in Careplans
SELECT *
FROM SyntheticData.Careplans
WHERE DESCRIPTION IS NULL
   OR TRIM(DESCRIPTION) = '';

-- Check for NULL or blank CODE values in Careplans
SELECT *
FROM SyntheticData.Careplans
WHERE CODE IS NULL
;


/* =========================================================
   7.6 ENCOUNTER COST VALIDATION
   Check for negative cost values
   ========================================================= */

SELECT *
FROM SyntheticData.Encounters
WHERE BASE_ENCOUNTER_COST < 0
   OR TOTAL_CLAIM_COST < 0;


/* =========================================================
   7.7 MEDICATION COST VALIDATION
   Check for negative cost values
   ========================================================= */

SELECT *
FROM SyntheticData.Medications
WHERE BASE_COST < 0
   OR TOTALCOST < 0;


/* =========================================================
   7.8 PROCEDURE COST VALIDATION
   Check for negative cost values
   ========================================================= */

SELECT *
FROM SyntheticData.Procedures
WHERE BASE_COST < 0;


/* =========================================================
   7.9 PATIENT COST VALIDATION
   Check for negative healthcare expenses or coverage
   ========================================================= */

SELECT *
FROM SyntheticData.Patients
WHERE HEALTHCARE_EXPENSES < 0
   OR HEALTHCARE_COVERAGE < 0;


/* =========================================================
   7.10 DATASET DATE COVERAGE
   Identify earliest and latest encounter dates
   ========================================================= */

SELECT
    MIN(START) AS EarliestEncounterDate,
    MAX(START) AS LatestEncounterDate
FROM SyntheticData.Encounters;


/* =========================================================
   7.11 PATIENT COVERAGE
   Count patients with at least one encounter
   ========================================================= */

SELECT
    COUNT(DISTINCT PatientID) AS PatientsWithEncounters
FROM SyntheticData.Encounters;


/* =========================================================
   7.12 COMPARE TOTAL PATIENTS WITH PATIENTS WITH ENCOUNTERS
   ========================================================= */

SELECT
    (SELECT COUNT(*)
     FROM SyntheticData.Patients) AS TotalPatients,

    (SELECT COUNT(DISTINCT PatientID)
     FROM SyntheticData.Encounters) AS PatientsWithEncounters;
