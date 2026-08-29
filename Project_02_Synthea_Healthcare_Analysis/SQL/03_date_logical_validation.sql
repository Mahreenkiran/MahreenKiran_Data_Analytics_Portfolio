/* =========================================================
   DATE AND LOGICAL VALIDATION
   ========================================================= */


/* ---------------------------------------------------------
   6.1 Check for Encounters where STOP is earlier than START
   --------------------------------------------------------- */

SELECT *
FROM SyntheticData.Encounters
WHERE STOP < START;


/* ---------------------------------------------------------
   6.2 Check for Conditions where STOP is earlier than START
   --------------------------------------------------------- */

SELECT *
FROM SyntheticData.Conditions
WHERE STOP < START;


/* ---------------------------------------------------------
   6.3 Check for Medications where STOP is earlier than START
   --------------------------------------------------------- */

SELECT *
FROM SyntheticData.Medications
WHERE STOP < START;


/* ---------------------------------------------------------
   6.4 Check for Procedures where STOP is earlier than START
   --------------------------------------------------------- */

SELECT *
FROM SyntheticData.Procedures
WHERE STOP < START;


/* ---------------------------------------------------------
   6.5 Check for Allergies where STOP is earlier than START
   --------------------------------------------------------- */

SELECT *
FROM SyntheticData.Allergies
WHERE STOP < START;


/* ---------------------------------------------------------
   6.6 Check for Careplans where STOP is earlier than START
   --------------------------------------------------------- */

SELECT *
FROM SyntheticData.Careplans
WHERE STOP < START;


/* ---------------------------------------------------------
   6.7 Check for patients where DEATHDATE is earlier than BIRTHDATE
   --------------------------------------------------------- */

SELECT *
FROM SyntheticData.Patients
WHERE DEATHDATE < BIRTHDATE;


/* ---------------------------------------------------------
   6.8 Check for encounters that occurred before patient birth
   --------------------------------------------------------- */

SELECT
    E.EncounterID,
    E.PatientID,
    E.START,
    P.BIRTHDATE
FROM SyntheticData.Encounters AS E
INNER JOIN SyntheticData.Patients AS P
    ON E.PatientID = P.PatientID
WHERE CAST(E.START AS DATE) < P.BIRTHDATE;


/* ---------------------------------------------------------
   6.9 Check for encounters that occurred after patient death
   --------------------------------------------------------- */

SELECT
    E.EncounterID,
    E.PatientID,
    E.START,
    P.DEATHDATE,
    DATEDIFF(DAY, P.DEATHDATE, CAST(E.START AS DATE)) AS DaysAfterDeath
FROM SyntheticData.Encounters AS E
INNER JOIN SyntheticData.Patients AS P
    ON E.PatientID = P.PatientID
WHERE P.DEATHDATE IS NOT NULL
  AND CAST(E.START AS DATE) > P.DEATHDATE;