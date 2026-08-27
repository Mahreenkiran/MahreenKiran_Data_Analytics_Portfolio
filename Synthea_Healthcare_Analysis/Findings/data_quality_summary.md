# Data Quality Summary

## Overview

A structured data-quality validation process was completed before beginning the main healthcare analysis.

The checks covered structural integrity, missing values, referential relationships, logical date sequences and healthcare cost fields.

---

# Dataset Row Counts

| Table | Rows |
|---|---:|
| Patients | 1,163 |
| Encounters | 61,459 |
| Conditions | 38,094 |
| Medications | 56,430 |
| Procedures | 83,823 |
| Allergies | 794 |
| Careplans | 3,931 |

---

# Structural Validation

The following checks returned no issues:

- duplicate PatientID values
- duplicate EncounterID values
- duplicate CareplanID values
- NULL PatientID values
- NULL EncounterID values
- NULL CareplanID values
- unmatched PatientID relationships
- unmatched EncounterID relationships

This confirmed that the tested primary keys and relational links were structurally consistent.

---

# Clinical Field Validation

No missing or blank clinical descriptions were identified in the tested Conditions, Medications, Procedures, Allergies or Careplans tables.

No missing clinical codes were identified in these tables.

---

# Cost Validation

No negative values were identified in:

- encounter base costs
- encounter total claim costs
- medication base costs
- medication total costs
- procedure base costs
- patient healthcare expenses
- patient healthcare coverage

---

# Logical and Date Validation

Most logical date checks returned no issues.

No records were identified where:

- encounter STOP preceded START
- condition STOP preceded START
- procedure STOP preceded START
- allergy STOP preceded START
- careplan STOP preceded START
- patient death occurred before birth
- an encounter occurred before patient birth

Two timeline issues were identified.

## Medication STOP Before START

Five medication records had a recorded STOP date earlier than the corresponding START date.

These records were retained as source-data quality findings and should be treated cautiously in medication-duration analysis.

## Encounters After Recorded Patient Death

165 encounter records occurred after the associated patient's recorded death date.

These records could distort longitudinal patient-journey analysis and should be flagged or excluded where post-death encounters are not analytically appropriate.

---

# Dataset Coverage

All 1,163 patients had at least one recorded encounter.

The available encounter data spans a long historical period within the synthetic dataset.

---

# Conclusion

The database demonstrated strong structural and referential integrity across the tested relationships.

However, the medication and post-death encounter timeline inconsistencies demonstrate the importance of combining structural validation with logical healthcare-specific checks.

The identified issues were documented rather than silently corrected so that the analytical limitations remain transparent.
