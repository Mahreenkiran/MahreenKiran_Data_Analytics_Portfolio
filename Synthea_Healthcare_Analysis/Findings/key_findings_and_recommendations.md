# Key Findings and Recommendations

# 1. Older Patients Recorded the Highest Healthcare Utilisation

## Finding

Patients aged 65+ recorded 27,615 encounters, substantially more than any other age group.

| Age Group | Encounters |
|---|---:|
| 65+ | 27,615 |
| 50-64 | 13,468 |
| 18-34 | 9,254 |
| 35-49 | 7,915 |
| 0-17 | 3,207 |

## Business Meaning

Healthcare activity in the synthetic population is heavily concentrated among older patients.

This is consistent with the higher condition burden identified in the same age group.

## Recommendation

Age should be included as a key dimension in healthcare utilisation and service-capacity analysis.

---

# 2. Condition Burden Increased Strongly With Age

## Finding

Average distinct conditions per patient increased consistently with age.

| Age Group | Average Conditions Per Patient |
|---|---:|
| 65+ | 18.56 |
| 50-64 | 16.29 |
| 35-49 | 14.37 |
| 18-34 | 10.66 |
| 0-17 | 4.02 |

## Business Meaning

Older patients are managing substantially more recorded conditions than younger groups.

This helps explain their higher encounter volumes.

## Recommendation

Patient complexity should be evaluated using both utilisation and condition burden rather than encounter count alone.

---

# 3. High Healthcare Utilisation Was Concentrated in a Small Patient Segment

## Finding

Only 15 patients were classified as High Utilisation.

| Utilisation Group | Patients | Percentage |
|---|---:|---:|
| Low Utilisation | 725 | 62.34% |
| Medium Utilisation | 423 | 36.37% |
| High Utilisation | 15 | 1.29% |

The highest-utilisation patient recorded 1,563 encounters.

## Business Meaning

Extreme healthcare activity is concentrated within a very small proportion of the patient population.

## Recommendation

High-utilisation patients could be analysed separately using condition burden, age, encounter types and claim costs to identify the drivers of repeated healthcare use.

---

# 4. Female Patients Recorded Higher Average Healthcare Utilisation

## Finding

Female patients averaged 57.68 encounters per patient compared with 47.40 for male patients.

## Business Meaning

The synthetic dataset contains a noticeable utilisation difference between gender groups.

## Recommendation

Gender should be included as a demographic analytical dimension, while avoiding general population conclusions from synthetic data.

---

# 5. Routine Care Dominated Healthcare Activity

## Finding

Wellness and ambulatory encounters represented the majority of healthcare activity.

| Encounter Class | Encounters |
|---|---:|
| Wellness | 24,038 |
| Ambulatory | 20,124 |
| Outpatient | 10,837 |
| Urgent Care | 2,564 |
| Emergency | 2,168 |
| Inpatient | 1,728 |

## Business Meaning

The synthetic healthcare environment is driven mainly by routine, preventive and community-based healthcare interactions rather than hospital admissions.

## Recommendation

Operational analysis should evaluate high-volume routine services separately from lower-volume acute services.

---

# 6. Inpatient Care Had the Highest Average Financial Burden

## Finding

Inpatient encounters had the highest average claim cost and average out-of-pocket amount.

| Encounter Class | Average Claim Cost | Average Out-of-Pocket Cost |
|---|---:|---:|
| Inpatient | $8,766.00 | $7,461.18 |
| Emergency | $7,926.41 | $6,065.60 |
| Ambulatory | $6,524.19 | $4,982.29 |
| Urgent Care | $5,798.27 | $4,362.66 |
| Outpatient | $2,827.51 | $2,105.95 |
| Wellness | $1,909.49 | $1,297.46 |

## Business Meaning

Although inpatient encounters represent a relatively small number of total encounters, each inpatient event carries a much greater average financial burden.

## Recommendation

Cost analysis should separate high-volume services from high-cost services rather than relying on total expenditure alone.

---

# 7. Most Encounters Were Low Cost

## Finding

58.95% of encounters had total claim costs below $1,000.

| Cost Band | Encounters | Percentage |
|---|---:|---:|
| Low Cost | 36,233 | 58.95% |
| Medium Cost | 13,707 | 22.30% |
| High Cost | 11,519 | 18.74% |

## Business Meaning

Most encounters are relatively inexpensive, although almost one in five belongs to the High Cost segment.

## Recommendation

High-cost encounters should be investigated by encounter class, patient condition burden and clinical diagnosis.

---

# 8. Preventive and Behavioural Assessments Were Highly Frequent

## Finding

The most common procedures included health and social-care assessment, depression screening, substance-use assessment, medication reconciliation and anxiety assessment.

## Business Meaning

Healthcare activity in the dataset extends beyond treatment and includes substantial preventive, behavioural-health and social-care activity.

## Recommendation

Procedure reporting should distinguish preventive assessment, behavioural-health screening and treatment procedures.

---

# 9. Severe Acute Conditions Were Associated With High Average Claim Costs

## Finding

Conditions such as acute respiratory distress syndrome, septic shock, sepsis and myocardial infarction were associated with high average claim costs.

Some of the highest averages were based on only a small number of encounters.

## Business Meaning

Average cost alone can overstate the importance of rare conditions.

## Recommendation

Condition cost analysis should consider:

- average claim cost
- total claim cost
- encounter count
- number of affected patients

together.

---

# 10. Conditions Data Included Clinical and Social Information

## Finding

The Conditions table contained diagnoses alongside findings such as employment status, stress, social isolation and other social observations.

## Business Meaning

Ranking all Conditions records as diseases would produce misleading conclusions.

## Recommendation

Clinical diagnoses should be separated from social findings and situations when creating disease-specific dashboards or reports.

---

# 11. Logical Timeline Validation Identified Source-Data Issues

## Finding

Five medication records had STOP dates earlier than START dates.

165 encounter records occurred after the patient's recorded death date.

## Business Meaning

These inconsistencies could affect treatment-duration and longitudinal patient-journey analysis.

## Recommendation

Healthcare pipelines should implement date-sequence and patient-timeline validation rules before longitudinal reporting.

---

# Overall Analytical Conclusion

Healthcare utilisation in the synthetic population was strongly related to age and condition burden.

Older patients generated the highest encounter volumes and had substantially greater numbers of recorded conditions.

Most healthcare activity consisted of wellness and ambulatory services, while inpatient and emergency encounters carried the highest average costs.

Extreme utilisation was concentrated among a very small group of patients, demonstrating why patient-level segmentation is useful when investigating healthcare demand.

The analysis also showed the importance of careful data interpretation. Clinical tables included both diagnoses and social findings, while longitudinal validation identified medication and post-death encounter inconsistencies.

Together, these findings demonstrate how SQL-based healthcare analytics can combine patient demographics, clinical burden, service utilisation and healthcare costs to produce a more complete view of patient activity.
