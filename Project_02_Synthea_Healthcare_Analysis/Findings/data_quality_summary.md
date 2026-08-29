# Data Quality Summary

## Overview

A structured data-quality validation process was completed before beginning the main healthcare analysis.

The checks covered structural integrity, missing values, referential relationships, logical date sequences and healthcare cost fields.

---

# Dataset Row Counts

| Table | Rows |
|---|:---|
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

Two timeline issues were identified during logical date validation.

## Issues Identified

### Medication STOP Before START

**5 medication records** had a recorded `STOP` date earlier than the corresponding `START` date.

These records were retained as source-data quality findings and should be interpreted cautiously in medication-duration analysis.

### Encounters After Recorded Patient Death

**165 encounter records** occurred after the associated patient's recorded death date.

These records may affect longitudinal patient-journey analysis and should be interpreted carefully when analysing healthcare activity relative to recorded patient death.

## No Issues Found

No records were identified where:

- encounter `STOP` preceded `START`
- condition `STOP` preceded `START`
- procedure `STOP` preceded `START`
- allergy `STOP` preceded `START`
- careplan `STOP` preceded `START`
- patient death occurred before birth
- an encounter occurred before patient birth

The remaining logical date checks therefore showed no additional timeline inconsistencies in the tested records.
---

# Dataset Coverage

All 1,163 patients had at least one recorded encounter.

The available encounter data spans a long historical period within the synthetic dataset.

---

# Conclusion

The data-quality validation produced four main conclusions:

1. **Structural integrity was strong.**  
   The tested primary keys were complete and unique, and no unmatched patient or encounter relationships were identified. This provides confidence that the core relational structure is suitable for downstream analysis.

2. **Clinical and cost fields were generally consistent.**  
   No missing key clinical codes or descriptions were identified in the tested clinical tables, and no negative values were found in the tested healthcare cost fields.

3. **The main data-quality concerns were timeline-related.**  
   **5 medication records** had `STOP` dates earlier than `START` dates, while **165 encounter records** occurred after recorded patient death. These issues may affect medication-duration calculations and longitudinal patient-journey analysis.

4. **Healthcare-specific validation added value beyond structural checks.**  
   Although the database performed well on key, relationship, clinical-field and cost validation, logical timeline checks still identified important inconsistencies. This shows why healthcare data should be assessed not only for technical integrity, but also for clinical and temporal plausibility.

The identified issues were retained and documented so that their potential analytical impact remains transparent throughout the project.

---

## Explore the Validation SQL

[View Data Quality Validation SQL](../SQL/02_data_quality_validation.sql)

[View Date and Logical Validation SQL](../SQL/03_date_logical_validation.sql)

[View Clinical and Cost Validation SQL](../SQL/04_clinical_cost_validation.sql)
