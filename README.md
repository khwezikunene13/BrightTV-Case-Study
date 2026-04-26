# BrightTV-Case-Study

1. Problem Statement
BrightTV aims to aggressively grow its subscription base for the current financial year. To achieve this, the Customer Value Management (CVM) team requires data-driven insights to understand current viewership behavior, identify risks, and pinpoint growth opportunities.

2. Aim of the Project
To analyze and viewership patterns across the user demographic to provide actionable recommendations that will increase platform engagement and expand the subscriber footprint.

3. Objectives
a. Data ingestion and processing: excel dataset will be ingested into databricks.
  - Perform a LEFT JOIN between User Profiles and Viewership records to create a master dataset.
  - Behavioral Segmentation:
      - Time Segmentation: Categorize viewing times into segments (e.g., Night Owl, Morning, Prime Time) using SQL CASE statements.
      - Age Segmentation: Group age into segments (e.g. infants, kids, teens, young adults, adults, seniors) usinf SQL case statement.
  - Date and TIme: Further cleaning of the timestamp data to exatrcat date, month, watch time and session duration in a usable format for analysis.

b. Trend Analysis: Processed data will be exported to excel for deeper analysis 
  - Isolate days and time of day with low and high consumption to identify gaps in consumption.
  - Demographic Profiling: Identify which provinces, age groups, genders, or races are under-represented or have low consumption rates.
c. Visualization: Build a Power BI dashboard for real-time health monitoring of key business metrics.

4. Summary of Results (Template for your Preso)
Once you finish your analysis in Excel/PowerBI, you can fill this out:
Consumption Drivers: "We found that consumption is heavily influenced by [e.g., Province X] and peaks during the [e.g., Late Evening] segment."
Low-Consumption Fix: "On [e.g., Tuesdays], viewership drops by X%. We recommend introduced [e.g., Local Dramas/Movies] during these slots to retain users."
Growth Initiatives: "To grow the base, we should target the [e.g., 18-24 age bracket] in [e.g., Western Cape] who currently show high registration but low watch time."


5. Tools used in the case study. 
- Databricks: Data Cleaning, case statment, complex joins.
- Excel: Deep Dive pivot tables, trend charting.
- Canva: Final slide deck for the CEO presentation.
- PowerBI: Executive Dashboard for high-level to track business health.
