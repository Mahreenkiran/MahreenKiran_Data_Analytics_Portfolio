# Recommendations

The recommendations below are based on patterns identified in the synthetic Synthea dataset.

They are intended as analytical and operational recommendations rather than clinical guidance.

---

## 1. Prioritise High-Utilisation Patients for Focused Review

Only **1.29% of patients** were classified as High Utilisation, yet this small group recorded very high numbers of healthcare visits.

A healthcare organisation could review high-utilisation patients as a distinct analytical segment to better understand whether repeated service use is associated with multimorbidity, frequent routine care, acute events or complex treatment needs.

Combining visit frequency with age, condition burden, treatment activity and healthcare cost would provide a more complete view of this group.

---

## 2. Assess Patient Complexity Using More Than Visit Count

Older patients showed both higher healthcare utilisation and greater condition burden.

This suggests that visit frequency alone may not fully represent patient complexity.

Healthcare utilisation analysis should therefore consider visit count alongside distinct conditions, age, healthcare cost and acute-care activity to provide a more balanced view of patient need.

---

## 3. Incorporate Age Into Healthcare Demand Planning

Patients aged 65+ recorded **27,615 healthcare visits** and an average of **18.56 distinct conditions per patient**.

This suggests that older patient groups may place greater demand on healthcare services because of both higher utilisation and greater condition burden.

Age should therefore be included as an important dimension in service-demand analysis, resource planning and workload forecasting.

---

## 4. Monitor Inpatient and Emergency Care as High-Cost Service Areas

Inpatient and emergency visits had the highest average claim and out-of-pocket costs.

Although these visit types occurred less frequently than wellness or ambulatory care, their average financial burden was considerably higher.

Healthcare cost analysis should therefore monitor inpatient and emergency activity closely when identifying major cost drivers and areas of concentrated financial burden.

---

## 5. Evaluate High-Cost Conditions Using Both Cost and Frequency

Several severe conditions were associated with very high average claim costs.

However, some of the highest average values were based on only a small number of healthcare visits.

Average claim cost alone may therefore overstate the overall importance of rare conditions.

Condition-level cost analysis should consider **average cost, total cost, visit volume and number of affected patients together** to identify the most meaningful cost drivers.

---

## 6. Separate Clinical Diagnoses From Social and Contextual Findings

The Conditions table contains medical diagnoses alongside employment information, social findings, behavioural observations and other contextual records.

This creates a risk of misleading rankings if all records are presented as diseases.

Clinical disorders should therefore be separated from broader social and contextual findings when producing disease-focused analysis and reporting.

---

## 7. Report Preventive and Behavioural-Health Activity as Distinct Service Categories

Several of the most common procedures involved depression screening, anxiety assessment, substance-use assessment and health and social-care evaluation.

This suggests that a substantial proportion of recorded healthcare activity relates to prevention, behavioural health and social assessment.

Reporting these activities separately from diagnostic and treatment procedures would provide a clearer picture of how healthcare services are being used.

---

## 8. Use Cost Segmentation to Identify Concentrated High-Cost Activity

Most healthcare visits were classified as Low Cost, while **18.74%** were classified as High Cost.

This indicates that healthcare costs are not evenly distributed across visits.

Cost segmentation can be used to compare patient groups, visit types and clinical conditions to identify where higher-cost healthcare activity is concentrated.

The current thresholds should continue to be treated as **exploratory analytical categories rather than formal healthcare classifications**.

---

## 9. Investigate Demographic Differences in Healthcare Utilisation

Female patients recorded a higher average number of healthcare visits than male patients.

The difference may reflect several factors within the synthetic dataset, including age distribution, pregnancy-related care, preventive screening or differences in condition burden.

Further demographic analysis could help determine which factors are most strongly associated with this utilisation difference.

---

## 10. Use City-Level Analysis for More Meaningful Geographic Comparison

All patients in the dataset were located in Massachusetts, which limits the value of state-level comparison.

Geographic analysis is therefore more meaningful at city level, where differences in patient volume, healthcare visits, common conditions and healthcare costs may be more visible.

City-level reporting should be preferred where geographic variation is required.

---

## 11. Maintain Healthcare Timeline Validation as a Routine Data-Quality Control

Five medication records had `STOP` dates earlier than `START` dates, while **165 healthcare visits** occurred after recorded patient death dates.

These inconsistencies could affect treatment-duration calculations and longitudinal patient analysis.

Healthcare data pipelines should therefore include routine checks for impossible or inconsistent patient timelines before data is used for reporting or longitudinal analysis.

---

## 12. Clearly Document Source-Data Quality Issues and Analytical Limitations

The analysis identified a small number of logical inconsistencies while most structural checks passed successfully.

Clearly documenting these issues improves transparency and helps readers understand which findings may be affected by source-data limitations.

Where questionable records are retained, their potential analytical impact should be documented so that interpretation remains transparent.

---

# Overall Recommendation

The analysis supports four broader recommendations:

1. **Assess utilisation, condition burden and cost together.**  
   **Reason:** Patients with high visit frequency were not necessarily the same as those with the highest condition burden or financial impact. Considering these measures together provides a more complete view of healthcare demand.

2. **Use patient-level segmentation to distinguish different forms of healthcare need.**  
   **Reason:** Only a small proportion of patients were classified as High Utilisation, while high-cost activity and clinical complexity followed different patterns. These groups should therefore be analysed separately rather than treated as equivalent.

3. **Include demographic and clinical context when interpreting healthcare activity.**  
   **Reason:** Age was strongly associated with both utilisation and condition burden, while gender and clinical profiles also showed differences within the synthetic population. Demographic context therefore helps explain why utilisation patterns vary.

4. **Maintain strong data-quality and timeline controls throughout the analytical process.**  
   **Reason:** Although structural and referential checks were strong, logical validation still identified medication date inconsistencies and healthcare visits recorded after patient death. Technical integrity alone is therefore not sufficient for reliable longitudinal analysis.

A patient-level analytical view combining **demographics, visit frequency, condition burden, treatment activity and healthcare cost** would provide a more complete understanding of healthcare demand and support more focused service and resource analysis.

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
