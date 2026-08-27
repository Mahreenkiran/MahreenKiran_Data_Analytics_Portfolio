/* =========================================================
   PRIMARY KEY AND FOREIGN KEY CONSTRAINTS
   SYNTHEA HEALTHCARE DATABASE
   ========================================================= */


/* =========================================================
   1. PRIMARY KEYS
   ========================================================= */


/* ---------------------------------------------------------
   1.1 Patients Primary Key
   --------------------------------------------------------- */

ALTER TABLE SyntheticData.Patients
ADD CONSTRAINT PK_Patients
PRIMARY KEY (PatientID);


/* ---------------------------------------------------------
   1.2 Encounters Primary Key
   --------------------------------------------------------- */

ALTER TABLE SyntheticData.Encounters
ADD CONSTRAINT PK_Encounters
PRIMARY KEY (EncounterID);


/* ---------------------------------------------------------
   1.3 Careplans Primary Key
   --------------------------------------------------------- */

ALTER TABLE SyntheticData.Careplans
ADD CONSTRAINT PK_Careplans
PRIMARY KEY (CareplanID);


/* =========================================================
   2. PATIENT FOREIGN KEYS
   ========================================================= */


/* ---------------------------------------------------------
   2.1 Encounters to Patients
   --------------------------------------------------------- */

ALTER TABLE SyntheticData.Encounters
ADD CONSTRAINT FK_Encounters_Patients
FOREIGN KEY (PatientID)
REFERENCES SyntheticData.Patients(PatientID);


/* ---------------------------------------------------------
   2.2 Conditions to Patients
   --------------------------------------------------------- */

ALTER TABLE SyntheticData.Conditions
ADD CONSTRAINT FK_Conditions_Patients
FOREIGN KEY (PatientID)
REFERENCES SyntheticData.Patients(PatientID);


/* ---------------------------------------------------------
   2.3 Medications to Patients
   --------------------------------------------------------- */

ALTER TABLE SyntheticData.Medications
ADD CONSTRAINT FK_Medications_Patients
FOREIGN KEY (PatientID)
REFERENCES SyntheticData.Patients(PatientID);


/* ---------------------------------------------------------
   2.4 Procedures to Patients
   --------------------------------------------------------- */

ALTER TABLE SyntheticData.Procedures
ADD CONSTRAINT FK_Procedures_Patients
FOREIGN KEY (PatientID)
REFERENCES SyntheticData.Patients(PatientID);


/* ---------------------------------------------------------
   2.5 Allergies to Patients
   --------------------------------------------------------- */

ALTER TABLE SyntheticData.Allergies
ADD CONSTRAINT FK_Allergies_Patients
FOREIGN KEY (PatientID)
REFERENCES SyntheticData.Patients(PatientID);


/* ---------------------------------------------------------
   2.6 Careplans to Patients
   --------------------------------------------------------- */

ALTER TABLE SyntheticData.Careplans
ADD CONSTRAINT FK_Careplans_Patients
FOREIGN KEY (PatientID)
REFERENCES SyntheticData.Patients(PatientID);


/* =========================================================
   3. ENCOUNTER FOREIGN KEYS
   ========================================================= */


/* ---------------------------------------------------------
   3.1 Conditions to Encounters
   --------------------------------------------------------- */

ALTER TABLE SyntheticData.Conditions
ADD CONSTRAINT FK_Conditions_Encounters
FOREIGN KEY (EncounterID)
REFERENCES SyntheticData.Encounters(EncounterID);


/* ---------------------------------------------------------
   3.2 Medications to Encounters
   --------------------------------------------------------- */

ALTER TABLE SyntheticData.Medications
ADD CONSTRAINT FK_Medications_Encounters
FOREIGN KEY (EncounterID)
REFERENCES SyntheticData.Encounters(EncounterID);


/* ---------------------------------------------------------
   3.3 Procedures to Encounters
   --------------------------------------------------------- */

ALTER TABLE SyntheticData.Procedures
ADD CONSTRAINT FK_Procedures_Encounters
FOREIGN KEY (EncounterID)
REFERENCES SyntheticData.Encounters(EncounterID);


/* ---------------------------------------------------------
   3.4 Allergies to Encounters
   --------------------------------------------------------- */

ALTER TABLE SyntheticData.Allergies
ADD CONSTRAINT FK_Allergies_Encounters
FOREIGN KEY (EncounterID)
REFERENCES SyntheticData.Encounters(EncounterID);


/* ---------------------------------------------------------
   3.5 Careplans to Encounters
   --------------------------------------------------------- */

ALTER TABLE SyntheticData.Careplans
ADD CONSTRAINT FK_Careplans_Encounters
FOREIGN KEY (EncounterID)
REFERENCES SyntheticData.Encounters(EncounterID);