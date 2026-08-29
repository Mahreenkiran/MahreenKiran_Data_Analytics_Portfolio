# Key Findings

## 1. Older Patients Recorded the Highest Healthcare Utilisation

Patients aged 65+ recorded **27,615 healthcare visits**, substantially more than any other age group.

| Age Group | Healthcare Visits |
|---|:---|
| 65+ | 27,615 |
| 50-64 | 13,468 |
| 18-34 | 9,254 |
| 35-49 | 7,915 |
| 0-17 | 3,207 |

This indicates that healthcare demand within the synthetic population was concentrated among older patients, making age an important dimension when analysing utilisation patterns.

---

## 2. Condition Burden Increased Strongly With Age

Average distinct conditions per patient increased consistently with age.

| Age Group | Average Conditions Per Patient |
|---|:---|
| 65+ | 18.56 |
| 50-64 | 16.29 |
| 35-49 | 14.37 |
| 18-34 | 10.66 |
| 0-17 | 4.02 |

Patients aged 65+ therefore had more than four times the average number of conditions recorded among patients aged 0-17.

This helps explain why older patients also recorded substantially higher healthcare utilisation and suggests that condition burden and visit frequency should be interpreted together.

---

## 3. High Healthcare Utilisation Was Concentrated in a Small Patient Segment

Patients were segmented by healthcare visit frequency.

| Utilisation Group | Patients | Percentage |
|---|:---|:---|
| Low Utilisation | 725 | 62.34% |
| Medium Utilisation | 423 | 36.37% |
| High Utilisation | 15 | 1.29% |

Only **15 patients**, representing **1.29% of the total patient population**, were classified as High Utilisation.

The highest-utilisation individual patient recorded **1,563 healthcare visits**.

This shows that very high healthcare utilisation was concentrated within a small minority of patients, which would be difficult to identify from overall visit totals alone.

---

## 4. Female Patients Recorded Higher Average Healthcare Utilisation

Female patients recorded an average of **57.68 healthcare visits per patient**, compared with **47.40** for male patients.

| Gender | Average Visits Per Patient |
|---|:---|
| Female | 57.68 |
| Male | 47.40 |

This difference reflects the characteristics of the synthetic dataset and should not be interpreted as a general population-level conclusion.

It does, however, demonstrate the value of including demographic dimensions when analysing patient-level utilisation patterns.

---

## 5. Wellness and Ambulatory Care Dominated Healthcare Activity

Wellness and ambulatory visits were the most frequent visit types.

| Visit Type | Healthcare Visits |
|---|:---|
| Wellness | 24,038 |
| Ambulatory | 20,124 |
| Outpatient | 10,837 |
| Urgent Care | 2,564 |
| Emergency | 2,168 |
| Inpatient | 1,728 |

Together, wellness and ambulatory visits represented the majority of recorded healthcare activity.

This indicates that the dataset is driven primarily by routine, preventive and community-based healthcare interactions rather than acute hospital care.

---

## 6. Inpatient Care Had the Highest Average Financial Burden

Although inpatient visits were relatively uncommon, they had the highest average claim cost.

| Visit Type | Total Claim Cost | Average Claim Cost |
|---|:---|:---|
| Ambulatory | £131.29M | £6,524.19 |
| Wellness | £45.90M | £1,909.49 |
| Outpatient | £30.64M | £2,827.51 |
| Emergency | £17.18M | £7,926.41 |
| Inpatient | £15.15M | £8,766.00 |
| Urgent Care | £14.87M | £5,798.27 |

Inpatient visits also had the highest average out-of-pocket amount.

| Visit Type | Average Out-of-Pocket Cost |
|---|:---|
| Inpatient | £7,461.18 |
| Emergency | £6,065.60 |
| Ambulatory | £4,982.29 |
| Urgent Care | £4,362.66 |
| Outpatient | £2,105.95 |
| Wellness | £1,297.46 |

This shows that lower-volume visit types can still create substantial financial burden at the individual visit level.

It also demonstrates why healthcare cost analysis should consider both **visit frequency and cost intensity** rather than relying on total expenditure alone.

---

## 7. Most Healthcare Visits Were Low Cost

Healthcare visits were grouped into analyst-defined cost bands.

| Cost Band | Healthcare Visits | Percentage |
|---|:---|:---|
| Low Cost | 36,233 | 58.95% |
| Medium Cost | 13,707 | 22.30% |
| High Cost | 11,519 | 18.74% |

Most healthcare visits had total claim costs below **£1,000**.

However, almost one in five visits was classified as High Cost, with a total claim cost of **£5,000 or more**.

This shows that although most healthcare visits were relatively low cost, a meaningful proportion of activity still occurred within the high-cost segment.

---

## 8. Preventive and Behavioural Assessments Represented Substantial Procedure Activity

The most frequently recorded procedures were primarily assessments and screening activities.

| Procedure | Records |
|---|:---|
| Assessment of health and social care needs | 8,901 |
| Depression screening | 7,727 |
| PHQ-2 depression screening | 6,940 |
| Assessment of substance use | 6,199 |
| Medication reconciliation | 6,032 |
| Assessment of anxiety | 4,954 |

This demonstrates that healthcare activity in the dataset extends beyond treatment procedures and includes substantial preventive, behavioural-health and social-care activity.

The procedure profile therefore reflects not only treatment delivery, but also screening, monitoring and ongoing patient assessment.

---

## 9. Cardiovascular and Metabolic Medications Were Frequently Recorded

The most frequently recorded medications included:

| Medication | Records |
|---|:---|
| Lisinopril 10 MG Oral Tablet | 8,166 |
| Hydrochlorothiazide 25 MG | 7,509 |
| Amlodipine 2.5 MG Oral Tablet | 5,942 |
| Insulin Human Isophane | 4,068 |
| Metformin ER 500 MG | 2,996 |
| Simvastatin 10 MG Oral Tablet | 2,489 |

The medication profile shows substantial treatment activity relating to cardiovascular disease, blood pressure management, diabetes and lipid management.

This is consistent with the higher condition burden observed among older patients and suggests that chronic disease management represents an important component of treatment activity in the dataset.

---

## 10. The Conditions Table Included Both Clinical and Social Information

The most frequent records in the Conditions table included both medical diagnoses and broader findings.

Examples included:

| Record | Count |
|---|:---|
| Full-time employment (finding) | 13,805 |
| Stress (finding) | 5,137 |
| Part-time employment (finding) | 2,426 |
| Social isolation (finding) | 1,243 |
| Viral sinusitis (disorder) | 1,233 |

This means the Conditions table should not automatically be interpreted as a disease-only table.

The raw frequencies also explain why **Full-time employment** and **Part-time employment** were excluded from the Power BI Top 10 Conditions & Findings visual, allowing the dashboard to provide a more analytically useful comparison.

Among clearly clinical conditions, frequently recorded diagnoses included:

- Viral sinusitis
- Acute viral pharyngitis
- Acute bronchitis
- Prediabetes
- Anaemia
- Hypertension
- Chronic sinusitis
- Otitis media

This distinction is important because social, behavioural and contextual findings can otherwise dominate condition rankings and distort disease-focused interpretation.

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

The utilisation difference should therefore be interpreted as a broader demographic pattern within the synthetic dataset rather than being attributed to a single dominant condition group.

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

Age-based analysis provides additional context by showing that both the **type and burden of recorded conditions** vary across different life stages.

---

## 13. Severe Acute Conditions Were Associated With High Average Claim Costs

Some severe acute conditions were associated with particularly high average claim costs.

| Condition | Healthcare Visits | Average Claim Cost |
|---|:---|:---|
| Injury of kidney | 1 | £284,854.75 |
| Acute respiratory distress syndrome | 4 | £232,212.84 |
| Septic shock | 6 | £193,573.55 |
| Sepsis | 40 | £112,588.67 |
| Myocardial infarction | 20 | £75,432.97 |
| Stroke | 49 | £25,496.00 |

The very highest average costs were sometimes based on very small numbers of healthcare visits.

For this reason, average cost should always be interpreted alongside visit volume.

A condition with an extremely high average cost but only one or two associated visits may have less overall financial impact than a more common condition with a lower average cost.

---

## 14. Geographic Analysis Was Limited to Massachusetts

All patients in the available sample were located in Massachusetts.

The state accounted for:

- **1,163 patients with healthcare visits**
- **61,459 healthcare visits**
- **38,094 condition records**
- approximately **£255.03M in total claim cost**
- approximately **£4,149.66 average claim cost**

Because only one state was represented, state-level comparisons were not meaningful.

City-level analysis is therefore more appropriate for geographic comparison within this dataset because it provides variation within the available geographic coverage.

---

## 15. Data Validation Identified Important Timeline Issues

Most structural and logical data-quality checks passed successfully.

However, two timeline issues were identified:

- **5 medication records** had `STOP` dates earlier than `START` dates
- **165 healthcare visits** occurred after the associated patient's recorded death date

These findings demonstrate the importance of performing healthcare-specific logical validation before analysing longitudinal patient journeys or treatment durations.

They also show that technically valid relational data can still contain timeline inconsistencies that may affect interpretation.

---

# Overall Findings Conclusion

The analysis produced five main conclusions:

1. **Healthcare utilisation increased substantially with age and condition burden.**  
   Patients aged 65+ recorded the highest healthcare activity and the greatest average number of distinct conditions, showing that age and clinical complexity were closely associated within the synthetic population.

2. **Extreme healthcare utilisation was concentrated within a very small patient group.**  
   Only **15 patients (1.29%)** were classified as High Utilisation, demonstrating the importance of patient-level analysis alongside overall visit totals.

3. **Routine care dominated healthcare activity, while acute care carried greater average financial burden.**  
   Wellness and ambulatory visits accounted for most activity, whereas inpatient and emergency care were less frequent but considerably more costly per visit.

4. **Clinical interpretation required more than simple record counts.**  
   The Conditions table combined diagnoses with social and contextual findings, while procedure and medication patterns showed substantial preventive, behavioural-health and chronic disease management activity.

5. **Healthcare-specific data validation was essential to the analysis.**  
   Although structural integrity was strong, timeline checks identified medication and post-death visit inconsistencies that could affect longitudinal analysis.

Overall, the findings show that meaningful healthcare analysis requires utilisation, condition burden, treatment activity, cost and data-quality context to be interpreted together rather than as isolated measures.

---

## Explore the Supporting SQL

[View Business Analysis SQL](../SQL/06_business_analysis.sql)

[View Demographic and Clinical Analysis SQL](../SQL/07_demographic_clinical_analysis.sql)

[View Data Quality Validation SQL](../SQL/02_data_quality_validation.sql)

[View Date and Logical Validation SQL](../SQL/03_date_logical_validation.sql)

[View Clinical and Cost Validation SQL](../SQL/04_clinical_cost_validation.sql)

[View Derived Fields and Calculations SQL](../SQL/05_derived_fields_calculations.sql)

---

[Return to Main Project README](../README.md)
