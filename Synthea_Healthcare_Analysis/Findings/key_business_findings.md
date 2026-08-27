# Key Findings

## 1. Older Patients Recorded the Highest Healthcare Utilisation

Patients aged 65+ recorded 27,615 encounters, substantially more than any other age group.

| Age Group | Encounters |
|---|---:|
| 65+ | 27,615 |
| 50-64 | 13,468 |
| 18-34 | 9,254 |
| 35-49 | 7,915 |
| 0-17 | 3,207 |

This indicates that healthcare utilisation in the synthetic population is strongly concentrated among older patients.

---

## 2. Condition Burden Increased Strongly With Age

Average distinct conditions per patient increased consistently with age.

| Age Group | Average Conditions Per Patient |
|---|---:|
| 65+ | 18.56 |
| 50-64 | 16.29 |
| 35-49 | 14.37 |
| 18-34 | 10.66 |
| 0-17 | 4.02 |

Patients aged 65+ therefore had more than four times the average number of conditions recorded among patients aged 0-17.

This helps explain why older patients also recorded substantially higher healthcare utilisation.

---

## 3. High Healthcare Utilisation Was Concentrated in a Small Patient Segment

Patients were segmented by encounter frequency.

| Utilisation Group | Patients | Percentage |
|---|---:|---:|
| Low Utilisation | 725 | 62.34% |
| Medium Utilisation | 423 | 36.37% |
| High Utilisation | 15 | 1.29% |

Only 15 patients, representing 1.29% of the total patient population, were classified as High Utilisation.

The highest-utilisation individual patient recorded 1,563 encounters.

This demonstrates that extreme healthcare activity is concentrated within a very small patient group.

---

## 4. Female Patients Recorded Higher Average Healthcare Utilisation

Female patients recorded an average of 57.68 encounters per patient compared with 47.40 for male patients.

| Gender | Average Encounters Per Patient |
|---|---:|
| Female | 57.68 |
| Male | 47.40 |

This difference reflects the characteristics of the synthetic dataset and should not be interpreted as a general population-level conclusion.

---

## 5. Wellness and Ambulatory Care Dominated Healthcare Activity

Wellness and ambulatory encounters were the most frequent encounter classes.

| Encounter Class | Encounters |
|---|---:|
| Wellness | 24,038 |
| Ambulatory | 20,124 |
| Outpatient | 10,837 |
| Urgent Care | 2,564 |
| Emergency | 2,168 |
| Inpatient | 1,728 |

Together, wellness and ambulatory encounters represented the majority of recorded healthcare activity.

This indicates that the dataset is driven primarily by routine, preventive and community-based healthcare interactions rather than acute hospital care.

---

## 6. Inpatient Care Had the Highest Average Financial Burden

Although inpatient encounters were relatively uncommon, they had the highest average claim cost.

| Encounter Class | Total Claim Cost | Average Claim Cost |
|---|---:|---:|
| Ambulatory | $131.29M | $6,524.19 |
| Wellness | $45.90M | $1,909.49 |
| Outpatient | $30.64M | $2,827.51 |
| Emergency | $17.18M | $7,926.41 |
| Inpatient | $15.15M | $8,766.00 |
| Urgent Care | $14.87M | $5,798.27 |

Inpatient encounters also had the highest average out-of-pocket amount.

| Encounter Class | Average Out-of-Pocket Cost |
|---|---:|
| Inpatient | $7,461.18 |
| Emergency | $6,065.60 |
| Ambulatory | $4,982.29 |
| Urgent Care | $4,362.66 |
| Outpatient | $2,105.95 |
| Wellness | $1,297.46 |

This shows that lower-volume encounter types can still create substantial financial burden at the individual encounter level.

---

## 7. Most Encounters Were Low Cost

Encounter costs were grouped into analyst-defined cost bands.

| Cost Band | Encounters | Percentage |
|---|---:|---:|
| Low Cost | 36,233 | 58.95% |
| Medium Cost | 13,707 | 22.30% |
| High Cost | 11,519 | 18.74% |

Most encounters had total claim costs below $1,000.

However, almost one in five encounters was classified as High Cost, with a total claim cost of $5,000 or more.

---

## 8. Preventive and Behavioural Assessments Represented Substantial Procedure Activity

The most frequently recorded procedures were primarily assessments and screening activities.

| Procedure | Records |
|---|---:|
| Assessment of health and social care needs | 8,901 |
| Depression screening | 7,727 |
| PHQ-2 depression screening | 6,940 |
| Assessment of substance use | 6,199 |
| Medication reconciliation | 6,032 |
| Assessment of anxiety | 4,954 |

This demonstrates that healthcare activity in the dataset extends beyond treatment procedures and includes substantial preventive, behavioural-health and social-care activity.

---

## 9. Cardiovascular and Metabolic Medications Were Frequently Recorded

The most frequently recorded medications included:

| Medication | Records |
|---|---:|
| Lisinopril 10 MG Oral Tablet | 8,166 |
| Hydrochlorothiazide 25 MG Oral Tablet | 7,509 |
| Amlodipine 2.5 MG Oral Tablet | 5,942 |
| Humulin Insulin Suspension | 4,068 |
| Metformin ER 500 MG | 2,996 |
| Simvastatin 10 MG Oral Tablet | 2,489 |

The medication profile shows substantial treatment activity relating to cardiovascular disease, blood pressure management, diabetes and lipid management.

---

## 10. The Conditions Table Included Both Clinical and Social Information

The most frequent records in the Conditions table included both medical diagnoses and broader findings.

Examples included:

| Record | Count |
|---|---:|
| Full-time employment (finding) | 13,805 |
| Stress (finding) | 5,137 |
| Part-time employment (finding) | 2,426 |
| Social isolation (finding) | 1,243 |
| Viral sinusitis (disorder) | 1,233 |

This means the Conditions table should not automatically be interpreted as a disease-only table.

Among clearly clinical conditions, frequently recorded diagnoses included:

- Viral sinusitis
- Acute viral pharyngitis
- Acute bronchitis
- Prediabetes
- Anaemia
- Hypertension
- Chronic sinusitis
- Otitis media

---

## 11. Common Clinical Conditions Were Broadly Similar Across Gender Groups

Viral sinusitis was the most frequent disorder-level record for both female and male patients.

Among female patients, prominent clinical conditions included:

- Viral sinusitis
- Acute viral pharyngitis
- Acute bronchitis
- Prediabetes
- Anaemia
- Hypertension

A similar pattern was identified among male patients.

This suggests that the higher average utilisation recorded among female patients was not simply explained by completely different leading condition profiles.

---

## 12. Clinical Patterns Varied by Age Group

Different age groups showed distinct clinical patterns.

Among patients aged 0-17, the most common conditions included:

- Otitis media
- Viral sinusitis
- Acute viral pharyngitis
- Acute bronchitis
- Streptococcal sore throat

Older groups showed much greater overall condition burden and higher healthcare utilisation.

This demonstrates the value of analysing clinical activity by age rather than only reporting overall condition totals.

---

## 13. Severe Acute Conditions Were Associated With High Average Claim Costs

Some severe acute conditions were associated with particularly high average claim costs.

| Condition | Encounters | Average Claim Cost |
|---|---:|---:|
| Injury of kidney | 1 | $284,854.75 |
| Acute respiratory distress syndrome | 4 | $232,212.84 |
| Septic shock | 6 | $193,573.55 |
| Sepsis | 40 | $112,588.67 |
| Myocardial infarction | 20 | $75,432.97 |
| Stroke | 49 | $25,496.00 |

The very highest average costs were sometimes based on very small numbers of encounters.

For this reason, average cost should always be interpreted alongside encounter volume.

---

## 14. Geographic Analysis Was Limited to Massachusetts

All patients in the available sample were located in Massachusetts.

The state accounted for:

- 1,163 patients with encounters
- 61,459 encounters
- 38,094 condition records
- approximately $255.03M in total claim cost
- approximately $4,149.66 average claim cost

Because only one state was represented, state-level comparisons were not meaningful.

City-level analysis is more appropriate for geographic comparison within this dataset.

---

## 15. Data Validation Identified Important Timeline Issues

Most structural and logical data-quality checks passed successfully.

However, two timeline issues were identified:

- 5 medication records had STOP dates earlier than START dates
- 165 encounter records occurred after the associated patient's recorded death date

These findings demonstrate the importance of performing healthcare-specific logical validation before analysing longitudinal patient journeys or treatment durations.

---

# Overall Findings Conclusion

Healthcare utilisation in the synthetic population was strongly associated with age and condition burden.

Patients aged 65+ recorded the highest healthcare activity and the greatest average number of distinct conditions.

Most healthcare interactions were routine wellness or ambulatory encounters, while inpatient and emergency care created the highest average financial burden.

Extreme utilisation was concentrated among a very small patient segment, highlighting the value of patient-level utilisation analysis.

The project also demonstrated the importance of interpreting healthcare data carefully. The Conditions table contained both clinical and social information, while timeline validation identified records that could affect longitudinal analysis.
