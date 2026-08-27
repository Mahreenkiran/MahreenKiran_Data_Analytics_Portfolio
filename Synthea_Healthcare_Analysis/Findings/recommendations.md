# Recommendations

The recommendations below are based on patterns identified in the synthetic Synthea dataset.

They are intended as analytical and operational recommendations rather than clinical guidance.

---

## 1. High-Utilisation Patients May Benefit From More Focused Review

Only 1.29% of patients were classified as High Utilisation, yet this small group recorded very high numbers of healthcare encounters.

A healthcare organisation could consider reviewing high-utilisation patients as a distinct segment to better understand whether repeated service use is associated with multimorbidity, frequent routine care, acute events or complex treatment needs.

Combining encounter frequency with age, condition burden, treatment activity and healthcare cost could provide a more complete view of this group.

---

## 2. Patient Complexity Should Be Assessed Using More Than Encounter Count

Older patients showed both higher healthcare utilisation and greater condition burden.

This suggests that encounter frequency alone may not fully represent patient complexity.

Healthcare utilisation analysis could therefore be strengthened by considering encounter count alongside distinct conditions, age, healthcare cost and acute-care activity.

---

## 3. Older Patient Groups May Require Greater Service Capacity

Patients aged 65+ recorded 27,615 encounters and an average of 18.56 distinct conditions per patient.

This suggests that older patient groups may place greater demand on healthcare services because of both higher utilisation and greater condition burden.

Age could therefore be an important factor in service-demand analysis, resource planning and workload forecasting.

---

## 4. Inpatient and Emergency Care Should Be Monitored as High-Cost Service Areas

Inpatient and emergency encounters had the highest average claim and out-of-pocket costs.

Although these encounter types occurred less frequently than wellness or ambulatory care, their average financial burden was considerably higher.

Healthcare cost analysis could therefore give particular attention to inpatient and emergency activity when identifying major cost drivers.

---

## 5. High-Cost Conditions Should Be Evaluated Using Both Cost and Frequency

Several severe conditions were associated with very high average claim costs.

However, some of the highest average values were based on only a small number of encounters.

This means that average claim cost alone may overstate the overall importance of rare conditions.

Condition-level cost analysis would be more informative when average cost is considered alongside total cost, encounter volume and number of affected patients.

---

## 6. Clinical Diagnoses Should Be Distinguished From Social and Contextual Findings

The Conditions table contains medical diagnoses alongside employment information, social findings, behavioural observations and other contextual records.

This creates a risk of misleading rankings if all records are presented as diseases.

Separating clinical disorders from broader findings and social information would improve the accuracy and interpretability of disease-focused reporting.

---

## 7. Preventive and Behavioural Health Activity Should Be Reported as Distinct Service Categories

Several of the most common procedures involved depression screening, anxiety assessment, substance-use assessment and health and social-care evaluation.

This suggests that a substantial proportion of recorded healthcare activity relates to prevention, behavioural health and social assessment.

Separating these activities from diagnostic and treatment procedures could provide a clearer picture of how healthcare services are being used.

---

## 8. Cost Segmentation Can Support More Focused Healthcare Cost Analysis

Most encounters were classified as Low Cost, while 18.74% were classified as High Cost.

This indicates that healthcare costs are not evenly distributed across encounters.

Cost segmentation could be used to compare patient groups, encounter classes and clinical conditions to identify where higher-cost healthcare activity is concentrated.

The current cost thresholds should be treated as exploratory analytical categories rather than formal healthcare classifications.

---

## 9. Gender Differences in Utilisation May Warrant Further Analysis

Female patients recorded a higher average number of encounters than male patients.

The difference may reflect several factors within the synthetic dataset, including age distribution, pregnancy-related care, preventive screening or differences in condition burden.

Further demographic analysis could help determine which factors are most strongly associated with this utilisation difference.

---

## 10. Geographic Analysis Is More Meaningful at City Level

All patients in the dataset were located in Massachusetts, which limits the value of state-level comparisons.

Geographic analysis would therefore be more meaningful at city level, where differences in patient volume, encounter activity, common conditions and healthcare costs may be more visible.

---

## 11. Healthcare Timeline Validation Should Remain an Important Data-Quality Control

Five medication records had STOP dates earlier than START dates, while 165 encounters occurred after recorded patient death dates.

These inconsistencies could affect treatment-duration calculations and longitudinal patient analysis.

Healthcare data pipelines would benefit from routine checks for impossible or inconsistent patient timelines before the data is used for reporting.

---

## 12. Source-Data Quality Issues Should Be Clearly Documented

The analysis identified a small number of logical inconsistencies while most structural checks passed successfully.

Clearly documenting these issues improves transparency and helps users understand which findings may be affected by source-data limitations.

Where questionable records are retained, their potential analytical impact should be made clear rather than being silently ignored.

---

# Overall Recommendation

The analysis suggests that healthcare utilisation, condition burden and cost should be considered together rather than independently.

A patient-level analytical view combining demographics, encounter frequency, condition burden, treatment activity and healthcare cost could provide a more complete understanding of healthcare demand.

This would make it easier to distinguish between high-utilisation patients, high-cost patients and patients with greater clinical complexity, while supporting more focused service and resource analysis.
