
# Recommendations

The recommendations below are analytical recommendations based on the patterns identified in the synthetic Synthea dataset.

They are not clinical recommendations and should not be interpreted as guidance for real patient care.

---

## 1. Review High-Utilisation Patients Separately

Only 1.29% of patients were classified as High Utilisation, but individual patients within this segment recorded very large numbers of encounters.

### Recommendation

Create a dedicated high-utilisation patient view combining:

- encounter count
- age
- condition burden
- encounter class
- healthcare cost
- medication activity
- procedure activity

This would help identify whether high service use is associated with multimorbidity, repeated routine care, acute events or specific treatment pathways.

---

## 2. Combine Utilisation With Condition Burden

Encounter count alone does not fully describe patient complexity.

Older patients showed both higher encounter frequency and substantially greater condition burden.

### Recommendation

Use utilisation and distinct condition count together when segmenting patient complexity.

A future patient-level analytical model could combine:

- number of encounters
- number of distinct conditions
- age group
- total claim cost
- inpatient or emergency activity

to create a more complete patient complexity profile.

---

## 3. Include Age in Healthcare Capacity Analysis

Patients aged 65+ recorded 27,615 encounters and an average of 18.56 distinct conditions per patient.

### Recommendation

Age should be included as a key dimension when analysing:

- service demand
- encounter frequency
- condition burden
- treatment activity
- healthcare expenditure

Older age groups should be analysed separately when investigating resource utilisation.

---

## 4. Analyse Inpatient and Emergency Cost Drivers Separately

Inpatient and emergency encounters had the highest average claim and out-of-pocket costs.

### Recommendation

Create a focused analysis of these encounter classes to identify:

- most frequent associated conditions
- high-cost procedures
- repeat patients
- average cost by condition
- total cost by condition
- common treatment pathways

This would provide a clearer view of what drives high-cost acute care.

---

## 5. Evaluate High-Cost Conditions Using Cost and Volume Together

Several rare conditions produced extremely high average claim costs.

For example, some of the highest-cost conditions occurred in only one or a few encounters.

### Recommendation

Do not rank conditions using average claim cost alone.

Use at least the following measures together:

- average claim cost
- total claim cost
- encounter count
- patient count

This reduces the risk of treating rare but expensive events as the largest overall cost drivers.

---

## 6. Separate Diagnoses From Social and Contextual Findings

The Conditions table contains clinical diagnoses alongside findings such as employment status, stress, social isolation and other social observations.

### Recommendation

Create a classification field that separates records into categories such as:

- clinical disorder
- finding
- social determinant
- situation
- pregnancy-related record
- other

Disease-specific reporting should then use only clinically relevant diagnosis categories.

This would make condition rankings and Power BI visuals more interpretable.

---

## 7. Analyse Preventive and Behavioural Health Activity Separately

Health and social-care assessments, depression screening, anxiety assessment and substance-use screening were among the most frequent procedures.

### Recommendation

Separate procedure reporting into groups such as:

- preventive care
- behavioural-health assessment
- diagnostic procedures
- therapeutic procedures
- monitoring and follow-up

This would provide a clearer understanding of the type of healthcare activity being delivered.

---

## 8. Use Cost Bands as an Exploratory Segmentation Tool

Most encounters were classified as Low Cost, while 18.74% were High Cost.

### Recommendation

Use cost bands to compare:

- encounter class
- age group
- condition burden
- utilisation group
- clinical condition

The current thresholds are analyst-defined and should be described clearly rather than presented as official healthcare classifications.

---

## 9. Investigate the Relationship Between Gender and Utilisation

Female patients recorded higher average encounter utilisation than male patients.

### Recommendation

Further analysis could compare gender groups using:

- encounter class
- age distribution
- pregnancy-related activity
- condition burden
- preventive screening
- average cost per patient

This would help identify which factors contribute to the observed utilisation difference within the synthetic dataset.

---

## 10. Use City-Level Rather Than State-Level Geographic Analysis

All patients were located in Massachusetts, preventing meaningful state-level comparisons.

### Recommendation

Use city-level geography when exploring:

- patient counts
- encounter volumes
- common conditions
- average claim cost
- high-utilisation patients

State-level maps or comparisons should be avoided because they would show only one geographic category.

---

## 11. Maintain Patient Timeline Validation Rules

Five medication records had STOP dates before START dates, and 165 encounters occurred after recorded patient death dates.

### Recommendation

Future healthcare data pipelines should automatically flag:

- STOP before START
- encounters before birth
- encounters after death
- impossible treatment durations
- missing patient or encounter references

These checks should be completed before calculating patient journeys, duration measures or longitudinal trends.

---

## 12. Preserve Source-Data Issues Rather Than Silently Correcting Them

The logical inconsistencies identified during validation were documented rather than overwritten.

### Recommendation

Continue using this approach in analytical projects.

Where source data contains questionable values:

1. identify the issue
2. quantify the affected records
3. document the analytical impact
4. exclude or correct records only where there is a justified rule
5. retain transparency in the project documentation

This produces a more defensible analytical workflow.

---

# Overall Recommendation

The strongest analytical opportunity is to combine patient demographics, condition burden, encounter utilisation and cost into a patient-level view.

Rather than analysing each healthcare table independently, a future extension could create a patient summary model containing:

- patient demographics
- total encounters
- utilisation group
- distinct condition count
- total medication activity
- total procedure activity
- total claim cost
- inpatient encounters
- emergency encounters

This would provide a more complete view of patient complexity and healthcare demand while avoiding direct many-to-many joins between transactional clinical tables.
