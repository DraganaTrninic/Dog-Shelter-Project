/*Includes data on shelter locations and contact information. 
Description: “For over 25 years, Petfinder has helped find forever homes for loving animals across North America. 
In addition to its searchable adoptable pet database, Petfinder also provides a directory of over 10,000 animal 
shelters in the United States, Canada and Mexico. This dataset contains the extracted data from the shelters available 
in the Petfinder database.”*/

SELECT*
FROM [dbo].[petfinder_shelters_original]

--PART I: DATA CLEANING

-- 1. Duplicate table to have orginal data backed up before making any changes and work with the copied data only. 

SELECT *
INTO [dbo].[petfinder_shelters_copy]
FROM [dbo].[petfinder_shelters_original];

SELECT *
FROM [dbo].[petfinder_shelters_copy]

-- 2. Check if any rows are duplicate using id. 

SELECT [id]
FROM [dbo].[petfinder_shelters_copy]
GROUP BY [id]
HAVING COUNT(*) > 1;

-- 3. Check if any rows are duplicate using [name] + [state]. 

SELECT [name], [state]
FROM [dbo].[petfinder_shelters_copy]
GROUP BY [name], [state]
HAVING COUNT(*) > 1; -- 10 duplicates returned:

-- 1. California Miniature Schnauzer Rescue in CA
SELECT *
FROM [dbo].[petfinder_shelters_copy]
WHERE [name] = 'California Miniature Schnauzer Rescue' AND [state] = 'CA';
-- Same organization but different locations - keep both locations. 

-- 2. Camp Cocker Rescue in CA
SELECT *
FROM [dbo].[petfinder_shelters_copy]
WHERE [name] = 'California Miniature Schnauzer Rescue' AND [state] = 'CA';
-- Same organization but different locations - keep both locations.

-- 3. County of San Diego Department of Animal Services in CA
SELECT *
FROM [dbo].[petfinder_shelters_copy]
WHERE [name] = 'County of San Diego Department of Animal Services' AND [state] = 'CA';
-- Same organization but 3 different locations and contact information - keep all locations.

-- 4. National Cat Protection Society in CA
SELECT *
FROM [dbo].[petfinder_shelters_copy]
WHERE [name] = 'National Cat Protection Society' AND [state] = 'CA';
-- Same organization but different locations and contact information - keep both locations.

-- 5. Russell Rescue CA in CA
SELECT *
FROM [dbo].[petfinder_shelters_copy]
WHERE [name] = 'Russell Rescue CA' AND [state] = 'CA';
-- Same organization, same location, different emails.

-- 6. Atlanta Humane Society in GA
SELECT *
FROM [dbo].[petfinder_shelters_copy]
WHERE [name] = 'Atlanta Humane Society' AND [state] = 'GA';
-- Same organization but different locations - keep both locations.

-- 7. Animal Rescue League of Boston in MA
SELECT *
FROM [dbo].[petfinder_shelters_copy]
WHERE [name] = 'Animal Rescue League of Boston' AND [state] = 'MA';
-- Same organization but different locations - keep both locations.

-- 8. The Cat Connection in MI
SELECT *
FROM [dbo].[petfinder_shelters_copy]
WHERE [name] = 'The Cat Connection' AND [state] = 'MI';
-- Same organization but different locations - keep both locations.

-- 9. Bideawee in NY
SELECT *
FROM [dbo].[petfinder_shelters_copy]
WHERE [name] = 'Bideawee' AND [state] = 'NY'; 
-- Same organization but different locations - keep both locations. 

-- 10. Texas Humane Heroes -- No Kill Animal Adoption Centers in TX
SELECT *
FROM [dbo].[petfinder_shelters_copy]
WHERE [name] = 'Texas Humane Heroes -- No Kill Animal Adoption Centers' AND [state] = 'TX';
-- Same organization but different locations - keep both locations. 


SELECT *
FROM [dbo].[petfinder_shelters_copy]

