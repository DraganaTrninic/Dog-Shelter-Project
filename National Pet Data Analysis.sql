--SELECT * FROM [dbo].[animal_intake_outcome_copy]; --A
--SELECT * FROM [dbo].[petfinder_shelters_copy];    --B
--SELECT * FROM [dbo].[pet_adoption_copy];          --c

-- ANALYSIS
-- Focus on human decisions in terms of pets. 

-- 1A. Which State had the highest/lowest intake-reliquished by owner of cats/dogs over the four year period on average (intakes / organizations)?
SELECT [State], 
	   CAST(SUM([Intake - Relinquished By Owner Total-Feline])/(SUM([Organizations])/COUNT([Year])) AS INT) AS Average_Total_Felines_Relinquished_by_Owner
FROM [dbo].[animal_intake_outcome_copy]
GROUP BY [State]
ORDER BY Average_Total_Felines_Relinquished_by_Owner
-- AR had the lowest number of felines relinquished by owner on average from 2019-2022 at 206 per organization,
-- and HI had the highest at 1988.

SELECT [State], 
	   CAST(SUM([Intake - Relinquished By Owner Total-Canine])/(SUM([Organizations])/COUNT([Year])) AS INT) AS Average_Total_Canines_Relinquished_by_Owner
FROM [dbo].[animal_intake_outcome_copy]
GROUP BY [State]
ORDER BY Average_Total_Canines_Relinquished_by_Owner
-- CT had the lowest number of canines relinquished by owner on average from 2019-2022 at 114 per organization, 
-- and HI had the highest at 2272.



-- 2A. Which State had the highest/lowest live outcome - adoption of cats/dogs over the four year period on average (inatkes / organizations)?
SELECT [State], 
	   CAST(SUM([Live Outcome - Adoption Total-Feline])/(SUM([Organizations])/COUNT([Year])) AS INT) AS Average_Total_Adoption_Felines
FROM [dbo].[animal_intake_outcome_copy]
GROUP BY [State]
ORDER BY 2 
-- SD had the lowest number of felines adopted on average from 2019-2022 at 573 per organization, 
-- and WA highest at 4538 (HI had the second highest at 4036).

SELECT [State], 
	   CAST(SUM([Live Outcome - Adoption Total-Canine])/(SUM([Organizations])/COUNT([Year])) AS INT) AS Average_Total_Adoption_Canines
FROM [dbo].[animal_intake_outcome_copy]
GROUP BY [State]
ORDER BY 2 
-- AK had the lowest number of canines adopted on average from 2019-2022 at 142 per organization, 
-- and TX highest at 4327.



-- 3A. Which year saw the highets/lowest average number of intake and highest/lowest average number of adoptions overall?
-- FELINE INTAKES
SELECT [Year],
	   CAST((SUM([Intake - Relinquished By Owner Total-Feline])/(SUM(Organizations)/COUNT([Year])))/COUNT(DISTINCT [State]) AS INT) AS Average_Felines_Relinquished_By_Owner_Per_Organization
FROM [dbo].[animal_intake_outcome_copy] 
GROUP BY [Year]
ORDER BY 2
-- 2020 had the lowest number of felines relinquished by owners on average from 2019-2022 at 213 per organization, 
-- and 2019 the highest at 261.

-- FELINE ADOPTIONS
SELECT [Year],
	   CAST((SUM([Live Outcome - Adoption Total-Feline])/(SUM(Organizations)/COUNT([Year])))/COUNT(DISTINCT [State]) AS INT) AS Average_Felines_Adoption_Per_Organization
FROM [dbo].[animal_intake_outcome_copy] 
GROUP BY [Year]
ORDER BY 2
-- 2020 had the lowest number of felines adopted on average from 2019-2022 at 555 per organization, 
-- and 2019 the highest at 625.

-- CANINE INTAKES
SELECT [Year],
	   CAST((SUM([Intake - Relinquished By Owner Total-Canine])/(SUM(Organizations)/COUNT([Year])))/COUNT(DISTINCT [State]) AS INT) AS Average_Canines_Relinquished_By_Owner_Per_Organization
FROM [dbo].[animal_intake_outcome_copy] 
GROUP BY [Year]
ORDER BY 2
-- 2020 had the lowest number of canines relinquished by owners on average from 2019-2022 at 189 per organization, 
-- and 2019 the highest at 261.

-- CANINE ADOPTIONS
SELECT [Year],
	   CAST((SUM([Live Outcome - Adoption Total-Canine])/(SUM(Organizations)/COUNT([Year])))/COUNT(DISTINCT [State]) AS INT) AS Average_Canine_Adoption_Per_Organization
FROM [dbo].[animal_intake_outcome_copy] 
GROUP BY [Year]
ORDER BY 2
-- 2020 had the lowest number of canines adopted on average from 2019-2022 at 436 per organization, 
-- and 2019 the highest at 567.




-- 4A. Which state/year had the highest/lowest euthanasia of felines/canines?

-- CAT SHELTER EUTHANASIA BY STATE
SELECT [State], 
	   CAST(SUM([Other Outcome - Shelter Euthanasia Total-Feline])/(SUM([Organizations])/COUNT([Year])) AS INT) AS Average_Shelter_Euthanasia_Felines
FROM [dbo].[animal_intake_outcome_copy]
GROUP BY [State]
ORDER BY 2 
-- SD had the lowest number of felines euthenized by shelters on average from 2019-2022 at 26 per organization, 
-- and HI highest at 3235 (CA had the second highest at 770).

-- CAT SHELTER EUTHANASIA BY YEAR
SELECT [Year],
	   CAST((SUM([Other Outcome - Shelter Euthanasia Total-Feline])/(SUM(Organizations)/COUNT([Year])))/COUNT(DISTINCT [State]) AS INT) AS Average_Shelter_Euthanasia_Felines
FROM [dbo].[animal_intake_outcome_copy] 
GROUP BY [Year]
ORDER BY 2
-- 2020 had the lowest number of felines euthenized by shelters on average from 2019-2022 at 71, 
-- while 2019 had the highest at 138 (2022 at 74 & 2021 at 75).

-- DOG SHELTER EUTHANASIA BY STATE
SELECT [State], 
	   CAST(SUM([Other Outcome - Shelter Euthanasia Total-Canine])/(SUM([Organizations])/COUNT([Year])) AS INT) AS Average_Shelter_Euthanasia_Canines
FROM [dbo].[animal_intake_outcome_copy]
GROUP BY [State]
ORDER BY 2 
-- AK had the lowest number of canines euthanized by shelters on average from 2019-2022 at 8 per organization, 
-- and HI had the highest at 735 (followed closely by TX at 671 and NM at 653).

-- DOG EUTHANASIA YEAR
SELECT [Year],
	   CAST((SUM([Other Outcome - Shelter Euthanasia Total-Canine])/(SUM(Organizations)/COUNT([Year])))/COUNT(DISTINCT [State]) AS INT) AS Average_Shelter_Euthanasia_Canines
FROM [dbo].[animal_intake_outcome_copy] 
GROUP BY [Year]
ORDER BY 2
-- 2020 had the lowest number of canines euthanized by shelters at 43 per organization, 
-- while 2019 had the highest at 80.




-- 5A. Questions 1A - 4A looking specifically at Texas. 
-- 5A(1A). How many cats/dogs on average were Relinquished By Owner over the four year period per organization?

-- AVG FELINES RELINQUISHED BY OWNER PER ORGANIZATION IN TEXAS FROM 2019-2022.
SELECT [State], 
	   CAST(SUM([Intake - Relinquished By Owner Total-Feline])/(SUM([Organizations])/COUNT([Year])) AS INT) AS Average_Total_Felines_Relinquished_by_Owner
FROM [Animal Shelters USA and International].[dbo].[animal_intake_outcome_copy]
WHERE [State] = 'TX'
GROUP BY [State]
ORDER BY Average_Total_Felines_Relinquished_by_Owner -- 1445

-- AVG CANINES RELINQUISHED BY OWNER PER ORGANIZATION IN TEXAS 2019-2022.
SELECT [State], 
	   CAST(SUM([Intake - Relinquished By Owner Total-Canine])/(SUM([Organizations])/COUNT([Year])) AS INT) AS Average_Total_Canines_Relinquished_by_Owner
FROM [dbo].[animal_intake_outcome_copy]
WHERE [State] = 'TX'
GROUP BY [State]
ORDER BY Average_Total_Canines_Relinquished_by_Owner -- 2093


-- 5A(2A). On average, how many cats/dogs were adopted per organization from 2019-2022?
-- AVG FELINES ADOPTED PER ORGANIZATION 2019-2022.
SELECT [State], 
	   CAST(SUM([Live Outcome - Adoption Total-Feline])/(SUM([Organizations])/COUNT([Year])) AS INT) AS Average_Total_Adoption_Felines
FROM [dbo].[animal_intake_outcome_copy]
WHERE [State] = 'TX'
GROUP BY [State]
ORDER BY 2 -- 3327

-- AVG CANINES ADOPTED PER ORGANIZATION 2019-2022.
SELECT [State], 
	   CAST(SUM([Live Outcome - Adoption Total-Canine])/(SUM([Organizations])/COUNT([Year])) AS INT) AS Average_Total_Adoption_Canines
FROM [dbo].[animal_intake_outcome_copy]
WHERE [State] = 'TX'
GROUP BY [State]
ORDER BY 2 -- 4327 (highest among all 50 states).

-- 5A(3A). Which year saw the highets/lowest average number of intake 
-- and highest/lowest average number of adoptions in Texas?

-- AVG FELINES RELINQUISHED BY OWNER 2019-2022 IN TEXAS.
SELECT [Year],
	   CAST((SUM([Intake - Relinquished By Owner Total-Feline])/(SUM(Organizations)/COUNT([Year])))/COUNT(DISTINCT [State]) AS INT) AS Average_Felines_Relinquished_By_Owner_Per_Organization
FROM [dbo].[animal_intake_outcome_copy] 
WHERE [State] = 'TX'
GROUP BY [Year]
ORDER BY 2 -- LOWEST RELINQUISHED BY OWNER FELINE: 2022 AT 329. HIGHEST 2019 AT 445.

-- AVG FELINE ADOPTIONS 2019-2022 IN TEXAS.
SELECT [Year],
	   CAST((SUM([Live Outcome - Adoption Total-Feline])/(SUM(Organizations)/COUNT([Year])))/COUNT(DISTINCT [State]) AS INT) AS Average_Felines_Adoption_Per_Organization
FROM [dbo].[animal_intake_outcome_copy] 
WHERE [State] = 'TX'
GROUP BY [Year]
ORDER BY 2 -- LOWEST ADOPTION FELINE: 2020 AT 789. HIGHEST 2019 AT 881.

-- AVG CANINE RELINQUISHED BY OWNER 2019-2022 IN TEXAS. 
SELECT [Year],
	   CAST((SUM([Intake - Relinquished By Owner Total-Canine])/(SUM(Organizations)/COUNT([Year])))/COUNT(DISTINCT [State]) AS INT) AS Average_Canines_Relinquished_By_Owner_Per_Organization
FROM [dbo].[animal_intake_outcome_copy] 
WHERE [State] = 'TX'
GROUP BY [Year]
ORDER BY 2 -- LOWEST RELINQUISHED BY OWNER CANINE: 2022 AT 433. HIGHEST 2019 AT 676.


-- AVG CANINES ADOPTED 2019-2022 IN TEXAS.
SELECT [Year],
	   CAST((SUM([Live Outcome - Adoption Total-Canine])/(SUM(Organizations)/COUNT([Year])))/COUNT(DISTINCT [State]) AS INT) AS Average_Canine_Adoption_Per_Organization
FROM [dbo].[animal_intake_outcome_copy] 
WHERE [State] = 'TX'
GROUP BY [Year]
ORDER BY 2 --LOWEST ADOPTIONS CANINE: 2021 AT 947. HIGHEST IN 2019 AT 1384.


-- 5A(4A). Which year had the highest/lowest euthanasia of felines/canines in Texas?

-- AVG. CAT SHELTER EUTHANASIA IN TEXAS FOR 2019-2022.
SELECT [State], 
	   CAST(SUM([Other Outcome - Shelter Euthanasia Total-Feline])/(SUM([Organizations])/COUNT([Year])) AS INT) AS Average_Shelter_Euthanasia_Felines
FROM [dbo].[animal_intake_outcome_copy]
WHERE [State] = 'TX'
GROUP BY [State]
ORDER BY 2 -- 466 FELINES EUTHANISED PER ORGANIZATION IN TX.

-- AVG. CAT SHELTER EUTHANASIA BY YEAR IN TX.
SELECT [Year],
	   CAST((SUM([Other Outcome - Shelter Euthanasia Total-Feline])/(SUM(Organizations)/COUNT([Year])))/COUNT(DISTINCT [State]) AS INT) AS Average_Shelter_Euthanasia_Felines
FROM [dbo].[animal_intake_outcome_copy] 
WHERE [State] = 'TX'
GROUP BY [Year]
ORDER BY 2 -- LOWEST AVG. FELINE EUTHANASIA 2020 AT 84. HIGHEST 2019 AT 188.


-- AVG. DOG SHELTER EUTHANASIA IN TEXAS FOR 2019-2022.
SELECT [State], 
	   CAST(SUM([Other Outcome - Shelter Euthanasia Total-Canine])/(SUM([Organizations])/COUNT([Year])) AS INT) AS Average_Shelter_Euthanasia_Canines
FROM [dbo].[animal_intake_outcome_copy]
WHERE [State] = 'TX'
GROUP BY [State]
ORDER BY 2 -- 671 CANINES EUTHANISED PER ORGANIZATION IN TEXAS. 


-- AVG. DOG EUTHANASIA BY YEAR IN TX. 
SELECT [Year],
	   CAST((SUM([Other Outcome - Shelter Euthanasia Total-Canine])/(SUM(Organizations)/COUNT([Year])))/COUNT(DISTINCT [State]) AS INT) AS Average_Shelter_Euthanasia_Canines
FROM [dbo].[animal_intake_outcome_copy] 
WHERE [State] = 'TX'
GROUP BY [Year]
ORDER BY 2  -- LOWEST AVG. CANINE EUTHANASIA 2020 AT 87 HIGHEST 2019 AT 244.



/* SO FAR IT SEEMS THAT OUR DATA DOES NOT BEAR OUT THE NOTION THAT AN EXCEPTIONAL NUMBER OF ANIMALS WERE ADOPTED
  FROM SHELTERS DURING THE LOCKDOWNS IN 2020/2021, BUT 2020 DOES SHOW EXCEPTIONALLY LOW NUMBERS OF SHELTER EUTHANASIA. */


-- 6A. Total intake - relinquished by owner and adoption over four years / by year.
-- TOTAL RELINQUISHED BY OWNER FELINES 2019-2022.
SELECT SUM([Intake - Relinquished By Owner Total-Feline]) AS Total_Felines_Relinquished_by_Owner
FROM [dbo].[animal_intake_outcome_copy] -- 1,041,551 FELINES RELINQUISHED BY OWNER NATIONWIDE FROM 2019-2022.

-- TOTAL ADOPTED FELINES 2019-2022.
SELECT SUM([Live Outcome - Adoption Total-Feline]) AS Total_Felines_Adopted
FROM [dbo].[animal_intake_outcome_copy] -- 2,603,698 FELINES ADOPTED NATIONWIDE FROM 2019-2022.

--APPROXIMATELY TWICE AS MANY FELINES ADOPTED AS RELINQUISHED. 

SELECT [Year],
	   SUM([Intake - Relinquished By Owner Total-Feline]) AS Total_Felines_Relinquished_by_Owner
FROM [dbo].[animal_intake_outcome_copy] 
GROUP BY [Year]
ORDER BY 2
-- LOWEST NUMBER OF FELINES RELINQUISHED BY OWNER NATIONWIDE 2020 AT 234,811.
-- HIGHEST NUMBER OF FELINES RELINQUISHED BY OWNER NATIONWIDE 2019 AT 288,105.

-- MATCHES WITH WHAT WE MIGHT EXPECT FROM COVID LOCKDOWNS IN 2020
-- I.E. PEOPLE MAY HAVE WANTED TO KEEP THEIR PETS OR NOT HAD A CHANCE TO RELINQUISH DUE TO LOCKDOWNS.

SELECT [Year],
	   SUM([Live Outcome - Adoption Total-Feline]) AS Total_Felines_Adopted
FROM [dbo].[animal_intake_outcome_copy] 
GROUP BY [Year]
ORDER BY 2
-- LOWEST NUMBER OF FELINES ADOPTED NATIONWIDE 2020 AT 611,950.
-- HIGHEST NUMBER OF FELINES ADOPTED NATIONWIDE 2019 AT 689,404.

-- DOES NOT MATCH THE HYPE OF NEWSPAPERS. 

-- 6A. Total intake - relinquished by owner and adoption over four years / by year.
-- TOTAL RELINQUISHED BY OWNER CANINES 2019-2022.
SELECT SUM([Intake - Relinquished By Owner Total-Canine]) AS Total_Canines_Relinquished_by_Owner
FROM [dbo].[animal_intake_outcome_copy] -- 947,700 CANINES RELINQUISHED BY OWNER NATIONWIDE FROM 2019-2022.

-- TOTAL ADOPTED CANINES 2019-2022.
SELECT SUM([Live Outcome - Adoption Total-Canine]) AS Total_Canines_Adopted
FROM [dbo].[animal_intake_outcome_copy] -- 2,098,404 CANINES ADOPTED FROM 2019-2022.

--MORE THAN TWICE AS MANY CANINES ADOPTED AS RELINQUISHED. 

SELECT [Year],
	   SUM([Intake - Relinquished By Owner Total-Canine]) AS Total_Canines_Relinquished_by_Owner
FROM [dbo].[animal_intake_outcome_copy] 
GROUP BY [Year]
ORDER BY 2
-- LOWEST NUMBER OF CANINES RELINQUISHED BY OWNER NATIONWIDE 2020 AT 209,161.
-- HIGHEST NUMBER OF CANINES RELINQUISHED BY OWNER NATIONWIDE 2019 AT 288,608.

-- MATCHES WITH WHAT WE MIGHT EXPECT FROM COVID LOCKDOWNS IN 2020
-- I.E. PEOPLE MAY HAVE WANTED TO KEEP THEIR PETS OR NOT HAD A CHANCE TO RELINQUISH DUE TO LOCKDOWNS.

SELECT [Year],
	   SUM([Live Outcome - Adoption Total-Canine]) AS Total_Canines_Adopted
FROM [dbo].[animal_intake_outcome_copy] 
GROUP BY [Year]
ORDER BY 2
-- LOWEST NUMBER OF CANINES ADOPTED NATIONWIDE 2020 AT 481,131.
-- HIGHEST NUMBER OF CANINES ADOPTED NATIONWIDE 2019 AT 625,848.

-- DOES NOT MATCH HYPE OF SHELTERS BEING EMPTY IN 2020/2021.


--------------------------------------------------------------------------------------------------------------------


-- 1B. Total number of organizations by state and country. 
-- 2B. Highest and lowest number of organizations by state. 
-- 3B. Highest number of organizations by city or zipcode. 

SELECT * FROM [dbo].[petfinder_shelters_copy]

-- 1B. Total number of organizations by state and country. 

SELECT COUNT(id)
FROM [dbo].[petfinder_shelters_copy]; --10,136 total rows.

SELECT DISTINCT [name]
FROM [dbo].[petfinder_shelters_copy]; --9,929 distinctly named organizations. 
-- Keeping in mind that some organizations may have branches with similar (though slightly different) names, and may show up here twice.
-- id would still show up as distinct because each entry is given a distinct id by petfinder.

SELECT DISTINCT [name]
FROM [dbo].[petfinder_shelters_copy]
WHERE Country = 'US'; --9,610 ORGANIZATIONS IN THE USA.

SELECT DISTINCT [name]
FROM [dbo].[petfinder_shelters_copy]
WHERE Country = 'CA'; --322 ORGANIZATIONS IN CANADA.

SELECT DISTINCT [name]
FROM [dbo].[petfinder_shelters_copy]
WHERE Country = 'MX' --2 ORGANIZATIONS IN MEXICO.

SELECT 9610 + 322 + 2 -- 9934. 
-- There are more distinct organizations here than accounted for in earlier (9,929).
-- Perhaps there are some duplicates in names between Canada and US?

SELECT DISTINCT [name], [country]
FROM [dbo].[petfinder_shelters_copy]
ORDER BY 1 -- 9,934 Rows (matching the final above)

-- Use a SELF JOIN to check which organization names match between USA and Canada.
SELECT A.[name],
	   A.[country]
FROM [dbo].[petfinder_shelters_copy] A
INNER JOIN [dbo].[petfinder_shelters_copy] B ON A.[name] = B.[name]
WHERE A.[country] != B.[country] 
ORDER BY A.[name];-- Returns 10 names rows. 5 for US. 5 for CA. - 5 organziation names are the same, but in different countries. 
-- Originally counted  9929 distinct organizations, but when divided by country counted 9934 (a difference of five).
-- This difference is explained by these 5 duplicate names in the two different countries. 


-- 2B. Highest and lowest number of organizations by state according to PetFinder data. 

SELECT COUNT(DISTINCT [name]) AS Organizations_From_PetFinders,
	   [State]
FROM [dbo].[petfinder_shelters_copy]
WHERE Country = 'US'
GROUP BY [State]
ORDER BY 1;
--WHERE State = 'AK'
 
-- HIGHEST NUMBER OF ORGANIZATIONS IS CA AT 1,023.
-- LOWEST NUMBER OF ORGANZATIONS IS AK AT 3.

/*SELECT DISTINCT[State],
	   [Organizations]
FROM [dbo].[animal_intake_outcome_copy]*/ -- This data is only within the USA.


-- JOIN THE SAC(A) AND PetFiner(B) TABLES TO COMPARE NUMBER OF ORGANIZATIONS.
SELECT  A.[State],
		COUNT (DISTINCT B.[name])/4 AS Organizations_From_Petfinder,
		A.[Organizations] AS Organizations_From_SAC,
		CAST((A.[Organizations]/(COUNT(B.[name])/4))*100 AS INT) AS SAC_Orgs_as_Percent_of_Petfinder_Orgs
FROM [dbo].[animal_intake_outcome_copy] AS A 
	INNER JOIN [dbo].[petfinder_shelters_copy] AS B
	ON A.[State] = B.[State]
GROUP BY  A.[State], A.[Organizations]
ORDER BY 1

/*SELECT  A.[State],
		COUNT (B.id)/4 AS Organizations_From_Petfinder,
		A.[Organizations] AS Organizations_From_SAC,
		CAST((A.[Organizations]/(COUNT(B.id)/4))*100 AS INT) AS SAC_Orgs_as_Percent_of_Petfinder_Orgs
FROM [dbo].[animal_intake_outcome_copy] AS A 
	INNER JOIN [dbo].[petfinder_shelters_copy] AS B
	ON A.[State] = B.[State]
GROUP BY  A.[State], A.[Organizations]
ORDER BY 1*/

-- FROM HERE WE CAN SAFELY ASSUME THAT THE INFORMATION WE HAVE FROM THE SAC TABLE (AND LIKELY THE PETFINDER TABLE)
-- IS JUST A FRACTIONAL REPRESENTATION OF THE SITUATION IN THE COUNTRY. 


-- 3B. Highest number of organizations by city or zipcode. 
SELECT [zip],
	   [City],
	   [State],
	   COUNT(DISTINCT[name]) AS Organizations_From_PetFinders
FROM [dbo].[petfinder_shelters_copy]
GROUP BY [zip], [City], [State]
ORDER BY 4 DESC;  -- MOST ZIPCODES ONLY HOST ONE ORGANIZATION, BUT SOME HOST MORE AND 37066 Gallatin, TN hosts 8.

-- BY CITY
SELECT [City],
	   [State],
	   COUNT(DISTINCT[name]) AS Organizations_From_PetFinders
FROM [dbo].[petfinder_shelters_copy]
GROUP BY [City], [State]
ORDER BY 3 DESC;  -- Houston, TX hosts the highest number of organizations at 75, followed by Los Angeles, CA at 58.

------------------------------------------------------------------------------------------------------------------------

-- 1C. Dogs by state (highest/lowest)?
--SELECT * FROM [dbo].[pet_adoption_copy];          --c

-- Date (start and end date).
SELECT [published_on_date],
[status_changed_on_date]
FROM [dbo].[pet_adoption_copy]
ORDER BY 1 
-- Data was collected from ads published from 21-23 July 2020.

SELECT MAX([status_changed_on_date])
FROM [dbo].[pet_adoption_copy] 
-- Data collection went up to 19 August 2020 (last day published as status_changed_on_date).

SELECT MIN([published_on_date]) AS Start_of_Data_Collection,
	   MAX([status_changed_on_date]) AS End_of_Data_Collection
FROM [dbo].[pet_adoption_copy]
--Start of Data Collection: 21 July 2020. 
--End of Data Collection: 19 August 2020.

-- Are dogs where [status_changed_on_date] = [published_on_date] dogs that were adopted the same day?
-- or that were not adopted by 19 Aug. 2020?
-- Check random sampling of URLs to answer above question.

SELECT [url],
	   [status],
	   [status_changed_on_date],
	   [published_on_date]
FROM [dbo].[pet_adoption_copy]
WHERE [status_changed_on_date] = [published_on_date]
--Urls that work: 
--16: [Status] = 'adoptable', on web litsed as 'adopted'. Must have been adopted AFTER 19 Aug. 2020 (MORE THAN 29 DAYS LISTED FOR ADOPTION).
--18: [Status] = 'adoptable', on web litsed as 'adopted'. Must have been adopted AFTER 19 Aug. 2020 (MORE THAN 29 DAYS LISTED FOR ADOPTION).
--22: [Status] = 'adoptable', on web litsed as 'adopted'. Must have been adopted AFTER 19 Aug. 2020 (MORE THAN 29 DAYS LISTED FOR ADOPTION).
--23: [Status] = 'adoptable', on web litsed as 'adopted'. Must have been adopted AFTER 19 Aug. 2020 (MORE THAN 29 DAYS LISTED FOR ADOPTION).
--24: [Status] = 'adoptable', on web litsed as 'adopted'. Must have been adopted AFTER 19 Aug. 2020 (MORE THAN 29 DAYS LISTED FOR ADOPTION).
--25: [Status] = 'adoptable', on web litsed as 'adopted'. Must have been adopted AFTER 19 Aug. 2020 (MORE THAN 29 DAYS LISTED FOR ADOPTION).

--Are there samples of dogs with status [Adopted] where [status_changed_on_date] = [published_on_date].
SELECT [url],
	   [status],
	   [status_changed_on_date],
	   [published_on_date]
FROM [dbo].[pet_adoption_copy]
WHERE [status_changed_on_date] = [published_on_date] AND
	  [status] = 'adopted' -- YES. 94 rows.
-- Without looking at metadata of each url (many have been deactivated) we can assume that:
-- A: The dog was listed and adopted on the same day or more likely...
-- B: The dog was listed and adopted before the data was collected, but the site had remained active.
-- Option be is supported by the fact that many urls from data are still active, but the dog is listed as "Adopted".
-- Therefore, we can surmise that the published_on_date is the date the data was collected rather than the date the advert was published. 


SELECT [tags], 
	   [name],
	   [description],
	   [status],
	   [days_listed_for_adoption],
	   [published_on_date],
	   [status_changed_on_date]
FROM [dbo].[pet_adoption_copy]
WHERE [status] = 'adopted' AND [days_listed_for_adoption] = 0 -- 94 rows
--WHERE [status] = 'adoptable' AND [days_listed_for_adoption] = 0 -- 191 rows

-- 1C. Dogs by state (highest/lowest)?

SELECT COUNT(DISTINCT [state])
FROM [dbo].[pet_adoption_copy]
WHERE [country] = 'US'-- 49 States listed. Check if Hawaii (HI) is listed?

SELECT DISTINCT [state]
FROM [dbo].[pet_adoption_copy]
WHERE [country] = 'US' AND [state] = 'HI' -- Hawaii is not included in this data. 

-- How many dogs are listed for adoption in Ohio?
SELECT [id],
	   [state],
	   [country]
FROM [dbo].[pet_adoption_copy]
WHERE [state] = 'OH' --39 rows returned.

-- Can we simplify above query?
SELECT COUNT([id]) AS Dogs,
	   [state],
	   [country]
FROM [dbo].[pet_adoption_copy]
WHERE [state] = 'OH'
GROUP BY [state], [country] --39 Dogs. 

-- OR
SELECT COUNT([id]) AS Dogs
FROM [dbo].[pet_adoption_copy]
WHERE [state] = 'OH' --39 

-- Can we expand query to include all states? 
SELECT [state],
	   [country],
	   COUNT([id]) AS Dogs
FROM [dbo].[pet_adoption_copy]
GROUP BY [state], [country] 
ORDER BY 3;
--In this dataset, only two dogs total are listed from Canada. 
--ND, WV, and WY tie for states with lowest number of dogs listed at 1 dog per state.
--CA is the state with most dogs listed at 58, followed closely by TX at 50.

-- Total dogs listed in the US?
SELECT COUNT([id]) AS Dogs
FROM [dbo].[pet_adoption_copy]
WHERE [country] = 'US'; --728 Dogs listed for adoption (status may be "adoptable" or "adopted") in the US in this dataset.

-- 2C. Dog breeds by state. 
SELECT DISTINCT[primary breed],
	   [secondary breed],
	   [coat],
	   [state],
	   [country],
	   [url]
FROM [dbo].[pet_adoption_copy]

-- Looking for patterns in breed by state. 
SELECT DISTINCT [primary breed],
	   [secondary breed],
	   [mixed breed],
	   [state],
	   [country],
	   [id],
	   [url]
FROM [dbo].[pet_adoption_copy]
WHERE [state] = 'TX'
--GROUP BY  [primary breed], [secondary breed], [mixed breed], [state], [country], [url]
ORDER BY [primary breed], [secondary breed]


SELECT [State],
	   [primary breed],
	   COUNT([primary breed]) AS Most_Popular_Breed
FROM [dbo].[pet_adoption_copy]
WHERE [State] = 'TX'
GROUP BY  [State], [primary breed] 
ORDER BY 3 DESC  -- The most popular dog breed (based on primary breed) up for adoption in Texas is the Chihuahua (mix). 
-- The second most popular dog breed in TX is a tie between the German Shpeherd Dog (mix), Shepherd breeds, and Terrier breeds.
-- Note "Shepherd" and "Terrier" are not recognized breeds, but general categories of dogs. 

SELECT [primary breed],
	   COUNT([primary breed]) AS Total_Breed_Count
FROM [dbo].[pet_adoption_copy]
WHERE [Country] = 'US'
GROUP BY  [primary breed] 
ORDER BY 2 DESC  -- The most popular dog breed (based on primary breed) up for adoption in the US is the Laborador Retriever (74). 
-- The next most common dog breeds/types up for adoption are Terriers, Mixed Breeds, Pit Bull Terriers, Chihuahuas, and German Shepherd Dogs.

-- 2C. Dog breeds by state (most popular)?

-- Getting the Maximum of the COUNT([primary breed])
WITH RankedBreedCounts AS (
    SELECT
        [State],
        [primary breed],
        COUNT([primary breed]) AS Most_Popular_Breed,
        ROW_NUMBER() OVER (PARTITION BY [State] ORDER BY COUNT([primary breed]) DESC) AS RowNum
    FROM [dbo].[pet_adoption_copy]
    GROUP BY [State], [primary breed]
	HAVING COUNT([primary breed])>5
)
SELECT [State], [primary breed], Most_Popular_Breed
FROM RankedBreedCounts
WHERE RowNum = 1;
-- In States where there are more than 5 dogs listed in the Most Popular Breed column, we see that:
-- in California the most common breed up for adoption is the German Shepherd Dog (mix) (10).
-- Labrador Retriever (mix) is the most common breed up for adoption in Indiana (16), Minnesota (6) and Ohio (10).
-- in Texas, the most popular type of dog up for adoption is the Chihuahua (6).
-- in Wisconsin the most popular type of dog up for adoption is mixed breeds (6).
-- and in Nebraska, the most popular type of dog up for adoption is the Terrier (9). 

-- What type of terriers are common up for adoption in NE? 
SELECT * 
FROM pet_adoption_copy
WHERE [State] = 'NE' AND [primary breed] = 'Terrier'; -- 9 rows
-- 1. id = 48554405 - bully type
-- 2. id = 48551090 - rat terrier type
-- 3. id = 48553854 - rat terrier type (best guess)
-- 4. id = 48554427 - bully type (best guess)
-- 5. id = 48554559 - bully type (best guess)
-- 6. id = 48554611 - unknown
-- 7. id = 48554275 - bully type (best guess)
-- 8. id = 48551132 - rat terrier type
-- 9. id = 48554588 - unknown type

-- Although these dogs are listed as terriers or terrier mixes, it is largely unclear if that is what they are. 
-- In any case, they are all short haired, small to medium sized dogs. 

-- Exploring breeds (primary and secondary). 
SELECT COUNT ([id])--,
	   --[primary breed],
	   --[secondary breed],
	   --[mixed breed],
	   --[state],
	   --[country],
	   --[url]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Chihuahua' OR [secondary breed] LIKE 'Chihuahua'
--GROUP BY  [primary breed], [secondary breed], [mixed breed], [state], [country], [url]
--ORDER BY [primary breed], [secondary breed]
-- Chihuahua AS Primary or Secondary breed = 59 results.

SELECT [id],
	   [primary breed],
	   [secondary breed],
	   [mixed breed],
	   [state],
	   [country],
	   [url]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Beagle' OR [secondary breed] LIKE 'Beagle'
--GROUP BY  [primary breed], [secondary breed], [mixed breed], [state], [country], [url]
ORDER BY [primary breed], [secondary breed]
--ORDER BY [secondary breed], [primary breed]
-- Chihuahua AS Primary or Secondary breed = 27 results.

--Using UNION to expodite most common breed search results.
--Specific breed is included if breed name appears more than once in [primary breed].

SELECT 'American Bulldog' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'American Bulldog' OR [secondary breed] LIKE 'American Bulldog'
UNION ALL
SELECT 'American Staffordshire Terrier' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'American Staffordshire Terrier' OR [secondary breed] LIKE 'American Staffordshire Terrier'
UNION ALL
SELECT 'Anatolian Shepherd' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Anatolian Shepherd' OR [secondary breed] LIKE 'Anatolian Shepherd'
UNION ALL
SELECT 'Australian Cattle Dog / Blue Heeler' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Australian Cattle Dog / Blue Heeler' OR [secondary breed] LIKE 'Australian Cattle Dog / Blue Heeler'
UNION ALL
SELECT 'Australian Shepherd' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Australian Shepherd' OR [secondary breed] LIKE 'Australian Shepherd'
UNION ALL
SELECT 'Basenji' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Basenji' OR [secondary breed] LIKE 'Basenji'
UNION ALL
SELECT 'Basset Hound' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Basset Hound' OR [secondary breed] LIKE 'Basset Hound'
UNION ALL
SELECT 'Beagle' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Beagle' OR [secondary breed] LIKE 'Beagle'
UNION ALL
SELECT 'Belgian Shepherd / Malinois' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Belgian Shepherd / Malinois' OR [secondary breed] LIKE 'Belgian Shepherd / Malinois'
UNION ALL
SELECT 'Black Mouth Cur' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Black Mouth Cur' OR [secondary breed] LIKE 'Black Mouth Cur'
UNION ALL
SELECT 'Border Collie' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Border Collie' OR [secondary breed] LIKE 'Border Collie'
UNION ALL
SELECT 'Boxer' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Boxer' OR [secondary breed] LIKE 'Boxer'
UNION ALL 
SELECT 'Catahoula Leopard Dog' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Catahoula Leopard Dog' OR [secondary breed] LIKE 'Catahoula Leopard Dog'
UNION ALL 
SELECT 'Cattle Dog' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Cattle Dog' OR [secondary breed] LIKE 'Cattle Dog'
UNION ALL 
SELECT 'Chihuahua' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Chihuahua' OR [secondary breed] LIKE 'Chihuahua'
UNION ALL
SELECT 'Chow Chow' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Chow Chow' OR [secondary breed] LIKE 'Chow Chow'
UNION ALL
SELECT 'Collie' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Collie' OR [secondary breed] LIKE 'Collie'
UNION ALL
SELECT 'Coonhound' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Coonhound' OR [secondary breed] LIKE 'Coonhound'
UNION ALL
SELECT 'Corgi' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Corgi' OR [secondary breed] LIKE 'Corgi'
UNION ALL
SELECT 'Dachshund' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Dachshund' OR [secondary breed] LIKE 'Dachshund'
UNION ALL
SELECT 'German Shepherd Dog' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'German Shepherd Dog' OR [secondary breed] LIKE 'German Shepherd Dog'
UNION ALL
SELECT 'Golden Retriever' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Golden Retriever' OR [secondary breed] LIKE 'Golden Retriever'
UNION ALL
SELECT 'Great Pyrenees' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Great Pyrenees' OR [secondary breed] LIKE 'Great Pyrenees'
UNION ALL
SELECT 'Hound' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Hound' OR [secondary breed] LIKE 'Hound'
UNION ALL
SELECT 'Husky' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE '%Husky' OR [secondary breed] LIKE '%Husky'
UNION ALL
SELECT 'Jack Russell Terrier' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Jack Russell Terrier' OR [secondary breed] LIKE 'Jack Russell Terrier'
UNION ALL
SELECT 'Jindo' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Jindo' OR [secondary breed] LIKE 'Jindo'
UNION ALL
SELECT 'Labrador Retriever' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE '%Labrador Retriever%' OR [secondary breed] LIKE '%Labrador Retriever%'
UNION ALL
SELECT 'Maltese' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Maltese' OR [secondary breed] LIKE 'Maltese'
UNION ALL
SELECT 'Mastiff' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Mastiff' OR [secondary breed] LIKE 'Mastiff'
UNION ALL
SELECT 'Miniature Pinscher' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Miniature Pinscher' OR [secondary breed] LIKE 'Miniature Pinscher'
UNION ALL
SELECT 'Mixed Breed' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Mixed Breed' OR [secondary breed] LIKE 'Mixed Breed'
UNION ALL
SELECT 'Mountain Dog' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Mountain Dog' OR [secondary breed] LIKE 'Mountain Dog'
UNION ALL
SELECT 'Pit Bull Terrier' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Pit Bull Terrier' OR [secondary breed] LIKE 'Pit Bull Terrier'
UNION ALL
SELECT 'Plott Hound' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Plott Hound' OR [secondary breed] LIKE 'Plott Hound'
UNION ALL
SELECT 'Pointer' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Pointer' OR [secondary breed] LIKE 'Pointer'
UNION ALL
SELECT 'Pomeranian' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Pomeranian' OR [secondary breed] LIKE 'Pomeranian'
UNION ALL
SELECT 'Poodle' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Poodle' OR [secondary breed] LIKE 'Poodle'
UNION ALL
SELECT 'Pug' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Pug' OR [secondary breed] LIKE 'Pug'
UNION ALL
SELECT 'Pyrenean Shepherd' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Pyrenean Shepherd' OR [secondary breed] LIKE 'Pyrenean Shepherd'
UNION ALL
SELECT 'Rat Terrier' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Rat Terrier' OR [secondary breed] LIKE 'Rat Terrier'
UNION ALL
SELECT 'Redbone Coonhound' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Redbone Coonhound' OR [secondary breed] LIKE 'Redbone Coonhound'
UNION ALL
SELECT 'Retriever' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Retriever' OR [secondary breed] LIKE 'Retriever'
UNION ALL
SELECT 'Rottweiler' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Rottweiler' OR [secondary breed] LIKE 'Rottweiler'
UNION ALL
SELECT 'Saint Bernard' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Saint Bernard' OR [secondary breed] LIKE 'Saint Bernard'
UNION ALL
SELECT 'Schnauzer' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Schnauzer' OR [secondary breed] LIKE 'Schnauzer'
UNION ALL
SELECT 'Shepherd' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Shepherd' OR [secondary breed] LIKE 'Shepherd'
UNION ALL
SELECT 'Shih Tzu' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Shih Tzu' OR [secondary breed] LIKE 'Shih Tzu'
UNION ALL
SELECT 'Spaniel' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE '%Spaniel' OR [secondary breed] LIKE '%Spaniel'
UNION ALL
SELECT 'Staffordshire Bull Terrier' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Staffordshire Bull Terrier' OR [secondary breed] LIKE 'Staffordshire Bull Terrier'
UNION ALL 
SELECT 'Terrier' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Terrier' OR [secondary breed] LIKE 'Terrier'
UNION ALL 
SELECT 'Treeing Walker Coonhound' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Treeing Walker Coonhound' OR [secondary breed] LIKE 'Treeing Walker Coonhound'
UNION ALL 
SELECT 'Yorkshire Terrier' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Yorkshire Terrier' OR [secondary breed] LIKE 'Yorkshire Terrier'
ORDER BY [Instances] DESC

-- AMONG BOTH MIXED AND PUREBRED DOGS, THE MOST COMMON UP FOR ADOPTION ARE:
-- LABORADOR RETRIEVERS AT 111.
-- FOLLOWED BY MIXED BREEDS AT 83.
-- THEN TERRIERS AT 74 AND PIT BULL TERRIERS AT 66.
-- CHIHUAHUAS AT 59, HOUNDS AT 45, SHEPHERDS AT 45, AND GERMAN SHEPHERD DOGS AT 36.


--PUREBRED DOGS
/*SELECT [primary breed],
	   [secondary breed],
	   [mixed breed]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Pit Bull Terrier' AND [secondary breed] LIKE 'None'*/
-- Shows some instances where dog has no secondary breed but still listed as mixed.
-- Therefore, it will be important to include the condition AND [mixed breed] = 'False' to ensure we are deeling with purebred dogs.


--Using UNION to explore most common breed search results FOR PUREBREED DOGS.
--Specific breed is included if breed name appears more than once in [primary breed].

SELECT 'American Bulldog' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'American Bulldog' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'American Staffordshire Terrier' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'American Staffordshire Terrier' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Anatolian Shepherd' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Anatolian Shepherd' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Australian Cattle Dog / Blue Heeler' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Australian Cattle Dog / Blue Heeler' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Australian Shepherd' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Australian Shepherd' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Basenji' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Basenji' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Basset Hound' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Basset Hound' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Beagle' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Beagle' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Belgian Shepherd / Malinois' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Belgian Shepherd / Malinois' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Black Mouth Cur' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Black Mouth Cur' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Border Collie' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Border Collie' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Boxer' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Boxer' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL 
SELECT 'Catahoula Leopard Dog' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Catahoula Leopard Dog' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL 
SELECT 'Cattle Dog' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Cattle Dog' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL 
SELECT 'Chihuahua' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Chihuahua' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Chow Chow' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Chow Chow' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Collie' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Collie' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Coonhound' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Coonhound' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Corgi' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Corgi' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Dachshund' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Dachshund' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'German Shepherd Dog' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'German Shepherd Dog' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Golden Retriever' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Golden Retriever' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Great Pyrenees' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Great Pyrenees' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Siberian Husky' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE '%Husky' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Jack Russell Terrier' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Jack Russell Terrier' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Jindo' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Jindo' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Labrador Retriever' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE '%Labrador Retriever%' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Maltese' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Maltese' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Mastiff' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Mastiff' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Miniature Pinscher' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Miniature Pinscher' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Mountain Dog' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Mountain Dog' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Pit Bull Terrier' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Pit Bull Terrier' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Plott Hound' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Plott Hound' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Pointer' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Pointer' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Pomeranian' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Pomeranian' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Poodle' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Poodle' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Pug' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Pug' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Pyrenean Shepherd' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Pyrenean Shepherd' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Rat Terrier' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Rat Terrier' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Redbone Coonhound' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Redbone Coonhound' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Retriever' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Retriever' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Rottweiler' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Rottweiler' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Saint Bernard' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Saint Bernard' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Schnauzer' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Schnauzer' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Shepherd' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Shepherd' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Shih Tzu' AS [Breed],
		COUNT ([id]) AS [Instances]
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Shih Tzu' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Spaniel' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE '%Spaniel' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL
SELECT 'Staffordshire Bull Terrier' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Staffordshire Bull Terrier' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL 
SELECT 'Terrier' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Terrier' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL 
SELECT 'Treeing Walker Coonhound' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Treeing Walker Coonhound' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
UNION ALL 
SELECT 'Yorkshire Terrier' AS [Breed],
	   COUNT ([id]) AS [Instances]  
FROM [dbo].[pet_adoption_copy]
WHERE [primary breed] LIKE 'Yorkshire Terrier' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False'
ORDER BY [Instances] DESC
-- THE MOST COMMON PUREBRED DOGS UP FOR ADOPTION ARE PIT BULL TERRIERS (22), FOLLOWED BY CHIHUAHUAS (11) AND GERMAN SHEPHERD DOGS (10).
-- NEXT WERE BEAGLES (8), DACHSHUNDS (8)  and TERRIERS (8) INCLUDED HERE THOUGH "TERRIERS" IS A TYPE RATHER THAN A BREED.
-- FOLLOWED BY LABRADOR RETRIEVERS (7).
-- Interestingly, although Labrador mixes were the most likely dogs to be listed, they are only the seventh most common purebred dog listed.

----------------------------------------------------
--3C. Average time to adoption by AGE / SIZE / COLOR / BREED / STATE / KEY WORDS (PERSONALITY) / ENVIRONMENT (DOGS/CATS/CHILDREN) 
-- / SPECIAL NEEDS / MALE VS FEMALE / SURRENDERED BECAUSE NOT HUNTING DOG?

SELECT* FROM [dbo].[pet_adoption_copy] --730 Rows.

-- How many days each dog was listed for adoption.
SELECT [age],
	   [days_listed_for_adoption]
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0
ORDER BY 2 DESC

-- How many days each Senior dog was listed for adoption. 
SELECT [age],
	   [days_listed_for_adoption]
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 AND [age] = 'Senior'
ORDER BY 2 DESC 

---------------------------------------------
--FIGURING OUT THE SHORTEST, LONGEST, AND AVERAGE TIME IN DAYS BEFORE DOGS OF DIFFERENT AGES WERE ADOPTED OUT.
SELECT [age],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
	   MAX([days_listed_for_adoption]) AS Longest_Wait,
	   AVG([days_listed_for_adoption]) AS Average_Wait
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 AND [age] = 'Senior'
GROUP BY [age] 
UNION 
SELECT [age],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
	   MAX([days_listed_for_adoption]) AS Longest_Wait,
	   AVG([days_listed_for_adoption]) AS Average_Wait
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 AND [age] = 'Adult'
GROUP BY [age] 
UNION
SELECT [age],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
	   MAX([days_listed_for_adoption]) AS Longest_Wait,
	   AVG([days_listed_for_adoption]) AS Average_Wait
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 AND [age] = 'Young'
GROUP BY [age] 
UNION 
SELECT [age],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
	   MAX([days_listed_for_adoption]) AS Longest_Wait,
	   AVG([days_listed_for_adoption]) AS Average_Wait
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 AND [age] = 'Baby'
GROUP BY [age] 
-- SENIOR DOGS HAD THE LONGEST AVERAGE TIME TO WAIT BEFORE ADOPTION (12 DAYS). 
-- YOUNG DOGS AND PUPPIES (BABY) HAD THE SHORTEST AVERAGE WAIT TIME BEFORE ADOPTION (8 DAYS).

--FIGURING OUT THE SHORTEST, LONGEST, AND AVERAGE TIME IN DAYS BEFORE DOGS OF DIFFERENT SIZES WERE ADOPTED OUT.
--IS IT TRUE THAT LARGE DOGS ARE HARDER TO ADOPT OUT? (NOT ACCORDING TO THIS DATA)
SELECT [size]
FROM [dbo].[pet_adoption_copy]

SELECT [size],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
	   MAX([days_listed_for_adoption]) AS Longest_Wait,
	   AVG([days_listed_for_adoption]) AS Average_Wait
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 AND [size] = 'Small'
GROUP BY [size] 
UNION 
SELECT [size],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
	   MAX([days_listed_for_adoption]) AS Longest_Wait,
	   AVG([days_listed_for_adoption]) AS Average_Wait
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 AND [size] = 'Medium'
GROUP BY [size] 
UNION
SELECT [size],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
	   MAX([days_listed_for_adoption]) AS Longest_Wait,
	   AVG([days_listed_for_adoption]) AS Average_Wait
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 AND [size] = 'Large'
GROUP BY [size]
UNION 
SELECT [size],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
	   MAX([days_listed_for_adoption]) AS Longest_Wait,
	   AVG([days_listed_for_adoption]) AS Average_Wait
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 AND [size] = 'Extra Large'
GROUP BY [size] 
-- THERE DOESN'T SEEM TO BE A SIGNIFICANT DIFFERENCE IN AVERAGE ADOPTION WAIT TIMES FOR DOGS BASED ON SIZE (RANGE IS 8-10 DAYS).
-- ONE MAJOR DIFFERENCE WAS THE SHORTEST WAIT FOR FOR EXTRA LARGE DOGS - 6 DAYS (VS 1 DAY FOR OTHER SIZES).
-- HOWEVER EXTRA LARGE DOGS LONGEST WAIT WAS ONLY 14 DAYS COMPARED TO NEARLY 30 DAYS FOR ALL OTHER SIZES. 

-------------------------------------------------
--FIGURING OUT THE SHORTEST, LONGEST, AND AVERAGE TIME IN DAYS BEFORE DOGS OF DIFFERENT COLORS WERE ADOPTED OUT.
--IS IT TRUE THAT BLACK DOGS WAIT LONGER TO BE ADOPTED?

SELECT DISTINCT [primary color]--,
	            --[secondary color],
	            --[tertiary color]
FROM [dbo].[pet_adoption_copy] -- 19 distinct pirmary colors listed. 
-- Note: One option for primary color is "None". Therefore not all dogs listed will be included in these analyses.

SELECT --[primary color],
	   'Light' AS [Color_Category],
       MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 
      AND ([primary color] LIKE '%White%' OR [primary color] LIKE '%Yellow%' OR [primary color] 
	  LIKE '%Beige%' OR [primary color] LIKE '%Gold%' OR [primary color] LIKE '%Blond%' OR [primary color] LIKE '%Cream%')
--GROUP BY [primary color]
UNION
SELECT 'Brown' AS [Color_Category],
       MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 
      AND ([primary color] LIKE '%Brown%' OR [primary color] LIKE '%Red%' OR [primary color] LIKE '%Brindle%')
UNION
SELECT 'Gray' AS [Color_Category],
       MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 
      AND ([primary color] LIKE '%Gray%' OR [primary color] LIKE '%Blue%')
UNION
SELECT 'Multiple Colors' AS [Color_Category],
       MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 
      AND ([primary color] LIKE '%Tricolor%' OR [primary color] LIKE '%Bicolor%' OR [primary color] LIKE '%Harlequin%')
UNION
SELECT 'Black' AS [Color_Category],
       MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 
      AND [primary color] LIKE '%Black%'
ORDER BY [Average_Wait];
-- Most common colors were Black (132), Light (112), and Brown (103). 
-- Least common colors were Multiple Colors (51) and gray (15).
-- DOGS WITH MULTIPLE COLORS (BICOLOR, TRICOLOR, HARLEQUIN) HAD THE SHORTEST AVERAGE WAIT UNTIL ADOPTION AT 7 DAYS. 
-- GRAY DOGS HAD THE LONGEST AVERAGE WAIT UNTIL ADOPTION (11 DAYS) 
-- BLACK DOGS HAD AN AVERAGE WAIT UNTIL ADOPTION OF 8 DAYS.
-- WHILE BROWN AND LIGHT-COLORED (WHITE, APRICOT, TAN, ETC.) DOGS HAD THE LONGEST AVERAGE WAIT AT 9 DAYS. 

-- OUR DATA (discounting instances where adoption time was 0 days
-- or primary_color was listed as "None") DOES NOT SUPPORT THE NOTION THAT BLACK DOGS TAKE LONGER TO ADOPT. 
---------------------------------------------------

-- TIME TO ADOPTION BY BREED. LOOKING AT MOST COMMON BREEDS.
-- TIME TO ADOPTION FOR MOST COMMON DOG BREEDS AND TYPES OVERALL: 
-- LABRADOR RETRIEVERS; MIXED BREEDS; TERRIERS;  PIT BULL TERRIERS; CHIHUAHUAS; AND GERMAN SHEPHERD DOGS.

SELECT [primary breed], [secondary breed]
FROM [dbo].[pet_adoption_copy]

SELECT --[primary breed], [secondary breed],
	   'Labrador Retriever (Mix)' AS [Breed],
       MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 
      AND ([primary breed] LIKE '%Labrador Retriever' OR [secondary breed] LIKE '%Labrador Retriever')
--GROUP BY [primary breed], [secondary breed]
UNION
SELECT --[primary breed], [secondary breed],
	   'Mixed Breed' AS [Breed],
       MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 
      AND ([primary breed] LIKE 'Mixed Breed' OR [secondary breed] LIKE 'Mixed Breed')
--GROUP BY [primary breed], [secondary breed]
UNION
SELECT --[primary breed], [secondary breed],
	   'Terrier (Mix)' AS [Breed],
       MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 
      AND ([primary breed] LIKE 'Terrier' OR [secondary breed] LIKE 'Terrier')
--GROUP BY [primary breed], [secondary breed]
UNION
SELECT --[primary breed], [secondary breed],
	   'Pit Bull Terrier (Mix)' AS [Breed],
       MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 
      AND ([primary breed] LIKE 'Pit Bull Terrier' OR [secondary breed] LIKE 'Pit Bull Terrier')
--GROUP BY [primary breed], [secondary breed]
UNION
SELECT --[primary breed], [secondary breed],
	   'Chihuahua (Mix)' AS [Breed],
       MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 
      AND ([primary breed] LIKE 'Chihuahua' OR [secondary breed] LIKE 'Chihuahua')
--GROUP BY [primary breed], [secondary breed]
UNION
SELECT --[primary breed], [secondary breed],
	   'German Shepherd Dog (Mix)' AS [Breed],
       MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 
      AND ([primary breed] LIKE 'German Shepherd Dog' OR [secondary breed] LIKE 'German Shepherd Dog')
--GROUP BY [primary breed], [secondary breed]
ORDER BY [Average_Wait]

-- OF THE MOST COMMON DOG BREEDS UP FOR ADOPTION:
-- LABRADOR RETRIEVERS AND LAB MIXES HAD THE SHORTEST AVERAGE WAIT TO ADOPTION (6 DAYS) AND WERE THE MOST COMMON BY FAR (94 DOGS).
-- THE LONGEST TIME A LAB SPENT UP FOR ADOPTION WAS 20 DAYS, WHICH WAS LESS THAN FOR ALL OTHER BREEDS WE LOOK AT HERE.
-- TERRIERS AND TERRIER MIXES HAD THE LONGEST AVERAGE WAIT TO ADOPTION (11 DAYS).
-- FOLLOWED CLOSELY BY PIT BULL TERRIER AND THEIR MIXES AND CHIHUAHUAS AND THEIR MIXES (10 DAYS).
-- SO WHILE LABS AND LAB MIXES MAY BE THE MOST LIKELY TO BE PUT UP FOR ADOPTION, THEY ARE ALSO SOME OF THE QUICKEST TO BE ADOPTED OUT.

--------------------------------------------
-- TIME TO ADOPTION FOR TOP 3 MOST COMMON PUREBRED DOGS: PIT BULL TERRIERS; CHIHUAHUAS; AND GERMAN SHEPHERD DOGS.
-- THE MOST COMMON PUREBRED DOGS UP FOR ADOPTION ARE PIT BULL TERRIERS (22), FOLLOWED BY CHIHUAHUAS (11) AND GERMAN SHEPHERD DOGS (10)
SELECT 'Pit Bull Terrier' AS [Breed],
       MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE  [days_listed_for_adoption] > 0 AND
       ([primary breed] LIKE 'Pit Bull Terrier' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False')
UNION
SELECT 'Chihuahua' AS [Breed],
       MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 
      AND ([primary breed] LIKE 'Chihuahua' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False')
UNION
SELECT 
	   'German Shepherd Dog' AS [Breed],
       MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 
      AND ([primary breed] LIKE 'German Shepherd Dog' AND [secondary breed] LIKE 'None' AND [mixed breed] = 'False')
ORDER BY [Average_Wait]

-- Note: Sample size has been reduced due to excluding dogs where days listed for adoption = 0.

-- Of the three most common purebreeds up for adopton:
-- GERMAN SHEPHERD DOGS had the SHORTEST AVERAGE WAIT to adoption at 9 DAYS.
-- CHIHUAHUAS HAD AN AVERAGE WAIT to adoption of 10 DAYS.
-- PIT BULL TERRIERS had the LONGEST AVERAGE WAIT to adoption at 11 DAYS.
-- Of the three top breeds up for adoption, GERMAN SHEPHERD DOGS had the LONGEST Shortest_Wait at 6 DAYS, 
-- Meanshile, PIT BULL TERRIERS had the shortest Shortest_Wait of the three breeds at only 2 DAYS.

-- As we saw with the mixed breeds above, on average dogs wait between one and two weeks for adoption based on this data set. 
-- However, we cannot say this with certainty. As we have seen, dogs may have been placed up for adoption BEFORE the data was collected...
-- but our data would nonetheless show that the dog has been waiting for adoption from the day the data was collected (and not before).
--------------------------------------------

-- TIME TO ADOPTION BY STATE.

SELECT [state],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 
	       AND ([country] = 'US')
GROUP BY [state]
ORDER BY [Average_Wait], [Sample_Size] 
-- IN THE US, THE SHORTEST AVG WAIT BY STATE WAS IN WV (1 DAY) AND THE LONGEST WAS IN ND & MS (21 DAYS). 

-- TIME TO ADOPTION BY COUNTRY.
SELECT [Country],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 AND
	  ([country] = 'US')
GROUP BY [Country]
UNION
SELECT [Country],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0 AND
      ([Country] = 'CA')
GROUP BY [Country]
-- IN THE US, THE SHORTEST WAIT TO ADOPTION WAS 1 DAY, THE LONGEST WAS 29 DAYS, AND THE AVG TIME TO ADOPTION WAS 9 DAYS (SAMPLE SIZE 443).
-- IN CANADA, THE SHORTEST WAIT TO ADOPTION WAS 5 DAYS, THE LONGEST WAS 14 DAYS, AND THE AVG TIME TO ADOPTION WAS 9 DAYS (SAMPLE SIZE 2).

-------------------------------------------------------------------------------------
-- TIME TO ADOPTION BY KEY WORDS (PERSONALITY).
SELECT [url],
	   [tags], 
	   [name],
	   [description]
FROM [dbo].[pet_adoption_copy]

--TAGS & DESCRIPTION
-- Positive: 'sweet%', 'playful', 'lov%', 'friendly', 'cuddly', 'affectionate', 'fun', 'attentive', 'calm', 'happy', 'darling', 'cuddle%', 'gentle%'
-- Negative: 'shy', 'timid', 'heartworm positive', 'no cats'


SELECT --[id], [name],
	  'Positive' AS [Personality_Traits],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0  AND
([tags] LIKE '%sweet%' OR [tags] LIKE '%playful%' OR [tags] LIKE '%lov%' OR[tags] LIKE '%friendly%' OR 
[tags] LIKE '%cuddl%'OR [tags] LIKE '%affectionate%' OR [tags] LIKE '%fun%' OR [tags] LIKE '%attentive%' OR
[tags] LIKE '%calm%' OR [tags] LIKE '%happy%' OR[tags] LIKE '%darling%' OR [tags] LIKE '%gentle%' OR
[description] LIKE '%sweet%' OR [description] LIKE '%playful%' OR [description] LIKE '%lov%' OR [description] LIKE '%friendly%' OR 
[description] LIKE '%cuddl%'OR [description] LIKE '%affectionate%' OR [description] LIKE '%fun%' OR [description] LIKE '%attentive%' OR
[description] LIKE '%calm%' OR [description] LIKE '%happy%' OR [description] LIKE '%darling%' OR [description] LIKE '%gentle%')
--GROUP BY [id], [name]
UNION
SELECT --[id], [name],
	  'Negative' AS [Personality_Traits],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0  AND
([tags] LIKE '%shy%' OR [tags] LIKE '%timid%' OR [tags] LIKE '%heartworm positive%' OR
[description] LIKE '%shy%' OR [description] LIKE '%timid%' OR [description] LIKE '%heartworm positive%')
--GROUP BY [id], [name]
ORDER BY [Sample_Size], [Average_Wait] 

-- Suprprisngly, the AVERAGE WAIT to adoption for dogs with traits such as SHY, TIMID, and HEARTWORM POSITIVE was the same... 
-- as for dogs those with positive traits such as FRIENDLY, CALM, CUDDLY, etc. i.e. 9 DAYS.

-----------------------------------------------------------------------------------

-- TIME TO ADOPTION BY COMPATIBLE ENIRONMENT.
SELECT [url],
	   [name],
	   [description],
	   [environment_children]--,
	   --[environment_dogs],
	   --[environment_cats]
FROM [dbo].[pet_adoption_copy]
WHERE [description] LIKE '% child %' OR [description] LIKE '% children %'
-- UNFORTUNATELY, UPON CLOSER INSPECTION, MANY TIMES THE ENVIRONMENT COLUMN WOULD DIRECTLY CONTRADICT THE DESCRIPTION FOR THE DOG...
-- IN CASES OF WHETHER THE DOG WAS/WASN'T COMPATIBLE WITH OTHER DOGS, CHILDREN, OR CATS. THEREFORE, WE CANNOT DRAW ANY CONCLUSIONS.. 
-- ABOUT A DOG'S COMPATABILITY WITH OTHER DOGS, CHILDREN, OR CATS AND THEIR TIME TO ADOPTION. 

-------------------------------------------------------------------------------------

-- TIME TO ADOPTION BY SPECIAL NEEDS.

-- How many dogs are listed as having Special Needs?
SELECT [id],
	   [url],
	   [name],
	   [description],
	   [special_needs],
	   [status_changed_on_date],
	   [published_on_date],
	   [days_listed_for_adoption]
FROM [dbo].[pet_adoption_copy]
WHERE [special_needs] = 'True' -- 14 Rows with dogs defined as having special needs.
	  AND [days_listed_for_adoption] > 0 -- 9 Rows.

-- What is the time to adoption for dogs with special needs vs those without?
SELECT 'True' AS [Dogs_With_Special_Needs],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0  AND
	  (special_needs = 'True')
UNION
SELECT 'False' AS [Dogs_With_Special_Needs],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0  AND
	  (special_needs = 'False')
ORDER BY [Sample_Size], [Average_Wait] 
-- ON AVERAGE dogs WITH SPECIAL NEEDS waited three days longer to be adopted (12 DAYS) than did dogs WITHOUT SPECIAL NEEDS (9 DAYS). 
-- The SHORTEST WAIT for adoption by a SPECIAL NEEDS DOG was 6 DAYS, compared to only 1 DAY for other dogs. 
-- We could conclude that there is likely a correlation between dogs having special needs and it taking a longer time to find them homes.
-----------------------------------------
-- Is there a difference in time to adoption based on sex.
SELECT 'Female' AS [Dog_Gender],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size -- Sample Size = 211
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0  AND
	  (gender = 'Female')
UNION
SELECT 'Male' AS [Dog_Gender],
	   MIN([days_listed_for_adoption]) AS Shortest_Wait,
       MAX([days_listed_for_adoption]) AS Longest_Wait,
       AVG([days_listed_for_adoption]) AS Average_Wait,
       COUNT([id]) AS Sample_Size -- Sample Size = 234
FROM [dbo].[pet_adoption_copy]
WHERE [days_listed_for_adoption] > 0  AND
	  (gender = 'Male') 
ORDER BY [Sample_Size], [Average_Wait] 

-- No significant difference in time to adoption for males and females. 
-- On average it took 9 days for males and females to be adopted. 
-------------------------------------------------------------------------------
-- INTERESTING NAMES
SELECT [name]
FROM [dbo].[pet_adoption_copy]
ORDER BY 1
-- Names I found interesting. 
-- 1. Mythological names: Odin, Hercules, Apollo, Artimis, Atlas, Xena, Zena. 
-- 2. Literary: Scout, Sawyer, Scarlett, Snow White, Oliver.
-- 3. Pop culture: Scooby, Serena, Woodrow, Elsa, Bernie, Banksy, Hershey.
-- 4. Unusual: Sandcastle, Spotiana. 

-- Most common Names.
SELECT [name],
	   COUNT([name]) AS Name_Count
FROM [dbo].[pet_adoption_copy]
GROUP BY [name]
HAVING COUNT(*) > 1
ORDER BY 2 DESC;
-- The most common name is "Buddy" (7) followed by "Scout" (5), "Max" (4), and "Gracie" (4).

-- Dogs listed as being given up for adoption because were not good for hunting. 
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE [description] LIKE '%hunt%' OR
	  [tags] LIKE '%hunt%'; -- 4 rows (one dog named "Hunter").

-- Hound mix in NJ, Maggie (id=48554732) listed as "dumped because she had no prey drive and therefore did not make a good hunting dog."
-- Purebred Beagle in SC, Pinto (id=48555262) listed as "My owner turned me in because I didn't want to hunt."
-- Purebred Beagle in SC, Precious (id=48555212) listed as "My owner turned me in because I didn't want to hunt."
-- At least 3 dogs out of the 730 listed have been surrendered because they were not good for hunting. 





/*
FINAL NOTES: While this dataset and analysis provides a decent overall view of nationwide animal adoption, there were some issues
with the datasets. 
(1) In our [dbo].[animal_intake_outcome_copy], we were only given numbers for intakes and outcomes, but no further information, 
    so we could not do any analysis for traits or factors that would make one animal more likely to be adopted over another.
	Furthermore, this dataset was incomplete in the sense that only a small fraction of shelters/rescue organizations have volunteered
	their information.
(2) While the [dbo].[petfinder_shelters_copy] data showed revealed to us that we were indeed looking at only a fraction of shelters/
    rescue organization in the [dbo].[animal_intake_outcome_copy] table, it was also data that had been scraped from an online site 
	(Petfinders) and itself contained only a fraction of all dog and cat shelters/rescue organization. Additionally, it contained 
	organizations that were dedicated to wildlife and exotic pets aside from just dogs and cats - while the intake_outcome table contained
	only feline and canine information. It was not possible to eliminate and organizations that catered to animals other than cats
	and dogs in any systematic way with this dataset. 
	So on the one hand, in [dbo].[petfinder_shelters_copy] we find information on many more organizations that are pertinent to our 
	analysis, and on the other hand, we are still only looking at a fraction of all shelters.
(3) Finally, in the [dbo].[pet_adoption_copy], the data was scraped from the Petfinder site, and while it included interesting and 
    varied information on dogs listed for adoption there were several key issues with the dataset. These include:
	(A). The descriptions were often cut short and incomplete because the data type chosen by the table creator was nvarchar(255). 
	(B). Data was only collected for approximately one month. It is not possible if this data is representative of general trends
         throughout the year. 
	(C). The published_at date/time and the status_changed_at date/time columns in the original table are not reliable. 
	     The published_at date/time in fact seems to be the day the data was collected rather than the date it was published. 
		 In rows where [published_at] = [status_changed_at] and [status] = 'adopted' we can assume that the post was published
		 and the dog was adopted before the data was collected, but the post remained listed on the site. 
		 In rows where [published_at] = [status_changed_at] and [status] = 'adoptable' we can assume that the post was published
		 on or before the first day of data collection, and the dog was still up for adoption at the end of the data collection 
		 (this is further supported by links that still work for such rows, where the status is now - a couple years later -
		 listed as 'adopted'). 
		 THEREFORE, when looking at how long on average it took for dogs with certain characteristics to be adopted, we can
		 make some generalizations, but we cannot take the findings at face value. 
	(D). The data had many errors  e.g.:
	     - duplicate rows (with different ids) for the same dog;
		 - several dogs listed in one row and under one id; 
	     - direct contradictions between dog's description and environment (e.g. dog is good NOT good with cats, but cats True as environment).
		 - coat length listed as 'None' (in copy it is 'Unknown').
		 - coat colors not included.
		 - dog breeds may not match their picture - though this is to be expected as with mixed breeds people may have different opinions
		   regarding what type of mix the dog is.

-- So while the analyses and conclusions drawn from this data may be used to describe potential and general trends, it is important
   to note the shortcomings of the data sets, and understand that with more complete data, the results may change. 
   THAT BEING SAID, this is a great springboard to look at trends in more complete datasets, perhaps in more localized environments 
   (like with the No-Kill Texas shelter Dataset we look at next).

