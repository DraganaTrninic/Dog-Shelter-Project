/* SAC free dataset on feline and canine data by US state from 2019-2022. 
Includes the number of organizations that participated, feline and canine intakes 
(relinquished, stray, transferred, owner intended euthanasia, other) and outcomes 
(adoption, returned to owner, died in care, etc.)*/

SELECT*
FROM [dbo].[animal_intake_outcome_original]

--PART I: DATA CLEANING

-- 1. Duplicate table to have orginal data backed up before making any changes and work with the copied data only. 

SELECT *
INTO [dbo].[animal_intake_outcome_copy]
FROM [dbo].[animal_intake_outcome_original];

SELECT *
FROM [dbo].[animal_intake_outcome_copy]

-- 2. Check if any rows are duplicate using State and Year. 

SELECT [State], [Year]
FROM [dbo].[animal_intake_outcome_copy]
GROUP BY [State], [Year]
HAVING COUNT(*) > 1;

-- No duplicate rows. Cleaning Complete. 

