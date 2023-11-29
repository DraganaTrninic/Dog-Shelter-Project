/* Scraped data from national US pet shelters via PetFinders.com API. 
Includes data only about dogs from different states. 
From July and August 2020.*/

SELECT*
FROM [dbo].[pet_adoption_original] --722 rows

--PART I: DATA CLEANING

-- 1. Duplicate table to have orginal data backed up before making any changes and work with the copied data only. 

SELECT *
INTO [dbo].[pet_adoption_copy]
FROM [dbo].[pet_adoption_original];

SELECT *
FROM [dbo].[pet_adoption_copy];



-- 2. Check if any [id] is duplicate using GROUP BY and HAVING. 

SELECT id
FROM [dbo].[pet_adoption_copy]
GROUP BY id
HAVING COUNT(*) > 1;


-- Check for duplicates in [name] + [primary breed]. 
SELECT [name], [breeds], [description]
FROM [dbo].[pet_adoption_copy]
GROUP BY [name], [breeds], [description]
HAVING COUNT(*) > 1 -- 9 Duplicates: 

-- 1. Buddy / Dachshund
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE ([name] = 'Buddy' AND [breeds] LIKE '%Dachshund%' AND [organization_id] = 'NE77')-- NOT a duplicate (different dogs in photos).

-- 2. Dora / Shepherd
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE ([name] = 'Dora' AND [breeds] LIKE '%Shepherd%') -- confirmed duplicate (same [organization_animal_id], same dog in photos)
-- Confirmed same dog is with Evergreen Animal Protective League EAPL (CO132) 
-- and Evergreen Animal Protective League EAPL - Westiminster Location (CO405).
-- Will keep the Evergreen Animal Protective League EAPL (CO132) location.

DELETE FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48549614;

--  3. Howie courtesy listing / Border Collie
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE ([name] = 'Howie courtesy listing' AND [breeds] LIKE '%Border Collie%') -- confirmed duplicate (same [organization_animal_id], same dog in photos)
-- Confirmed same dog is with Evergreen Animal Protective League EAPL (CO132) 
-- and Evergreen Animal Protective League EAPL - Westiminster Location (CO405).
-- Will keep the Evergreen Animal Protective League EAPL (CO132) location. 

DELETE FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48549586;

-- 4. Kolbi / Husky
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE ([name] = 'Kolbi' AND [breeds] LIKE '%Husky%') -- confirmed duplicate (same [organization_animal_id], same dog in photos)
-- Confirmed same dog is with Evergreen Animal Protective League EAPL (CO132) 
-- and Evergreen Animal Protective League EAPL - Westiminster Location (CO405).
-- Will keep the Evergreen Animal Protective League EAPL (CO132) location. 

DELETE FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48549615;

-- 5. Lulu (Best Dog Ever) / Terrier
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE ([name] = 'Lulu (Best Dog Ever)' AND [breeds] LIKE '%Terrier%') -- confirmed duplicate by url and phtos.
-- Date to adoption does not match.
-- Listed as "fostered in PA" (PA560) so will leave this row and delete the other (organization_id = NY393).

DELETE FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48553558;

-- 6. Mia (husky) / Husky
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE ([name] = 'Mia (husky)' AND [breeds] LIKE '%Husky%') -- confirmed duplicate (same [organization_animal_id], same dog in photos)
-- Confirmed same dog is with Evergreen Animal Protective League EAPL (CO132) 
-- and Evergreen Animal Protective League EAPL - Westiminster Location (CO405).
-- Will keep the Evergreen Animal Protective League EAPL (CO132) location. 

DELETE FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48549655;

-- 7. Sampson / Shih Tzu
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE ([name] = 'Sampson' AND [breeds] LIKE '%Shih Tzu%') -- confirmed duplicate (same [organization_animal_id], same dog in photos)
-- Confirmed same dog is with Evergreen Animal Protective League EAPL (CO132) 
-- and Evergreen Animal Protective League EAPL - Westiminster Location (CO405).
-- Will keep the Evergreen Animal Protective League EAPL (CO132) location. 

DELETE FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48549612;

-- 8. Senji / Shih Tzu
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE ([name] = 'Senji' AND [breeds] LIKE '%Shih Tzu%') -- confirmed duplicate (same [organization_animal_id], same dog in photos)
-- Confirmed same dog is with Evergreen Animal Protective League EAPL (CO132) 
-- and Evergreen Animal Protective League EAPL - Westiminster Location (CO405).
-- Will keep the Evergreen Animal Protective League EAPL (CO132) location. 

DELETE FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48549613;


-- 9. Zeus the Deuce / Husky
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE ([name] = 'Zeus the Deuce' AND [breeds] LIKE '%Husky%') -- confirmed duplicate (same [organization_animal_id], same dog in photos)
-- Confirmed same dog is with Evergreen Animal Protective League EAPL (CO132) 
-- and Evergreen Animal Protective League EAPL - Westiminster Location (CO405).
-- Will keep the Evergreen Animal Protective League EAPL (CO132) location. 

DELETE FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48549654;


-- 10. Keelie Lower Fee! -- doesn't show up in duplicate search because of a difference in one space in the name. 
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE ([name] LIKE 'Keelie%') -- confirmed duplicate (same dog in photos, same url).

DELETE FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48554653;

-- 11. 'Peanut Butter   (no apartments)' -- doesn't show up in duplicate search because of a difference in one space in the name. 
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE ([name] LIKE 'Peanut Butter%') -- confirmed duplicate (same dog in photos, same url).

DELETE FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48554946;

-- Check for any other duplicates using 
-- Check for duplicates in [organization_animal_id]. 
SELECT [organization_animal_id]
FROM [dbo].[pet_adoption_copy]
GROUP BY [organization_animal_id]
HAVING COUNT(*) > 1 -- 2 Duplicates: Can dismiss the first ('None'). Check the second 'Q-7/20'.

SELECT*
FROM [dbo].[pet_adoption_copy]
WHERE [organization_animal_id] = 'Q-7/20' -- Confirmed different dogs.

SELECT*
FROM [dbo].[pet_adoption_copy] --712 rows (10 duplicate rows removed). 

-- 4. Delete [type] as column (as it is a duplicate of [species])

ALTER TABLE [dbo].[pet_adoption_copy]
DROP COLUMN [type]

-- 5. Drop other columns we won't need/use: "organization_animal_id", "photos", "primary_photo_cropped", "videos", "distance", "_links"

ALTER TABLE [dbo].[pet_adoption_copy]
DROP COLUMN [photos], [organization_animal_id], [videos], [distance], [_links];

SELECT*
FROM [dbo].[pet_adoption_copy]

--6. Change coat "none" to "uknown" 

UPDATE [dbo].[pet_adoption_copy]
SET [coat] = REPLACE([coat], 'None', 'Unknown')
WHERE [coat] LIKE '%None%';

--7. Split up columns: [breeds], [colors], [attributes] (excluding "declawed" as this is a dataset about dogs only), [environment], and [contact]. 

--7.1A. [breeds]: Modify strings in [breeds] to match JSON format by changing the 'single quotes' to "double quotes".

UPDATE [dbo].[pet_adoption_copy]
SET breeds = REPLACE(breeds, '''', '"')
WHERE breeds LIKE '%''%';

-- 7.1B. Create new columns to table for the information split up from [breeds]. 

ALTER TABLE [dbo].[pet_adoption_copy]
ADD [primary breed] NVARCHAR(255),
    [secondary breed] NVARCHAR(255),
    [mixed breed] NVARCHAR(255),
    [breed unknown] NVARCHAR(255);


-- 7.1C. Split up information in [breeds] field using JSON_VALUE and populate newly created columns above.

UPDATE [dbo].[pet_adoption_copy]
SET 
    [primary breed] = JSON_VALUE([breeds], '$.primary'),
    [secondary breed] = JSON_VALUE([breeds], '$.secondary'),
    [mixed breed] = JSON_VALUE([breeds], '$.mixed'),
    [breed unknown] = JSON_VALUE([breeds], '$.unknown');

-- 7.1D. Drop [breeds] field from table. 

ALTER TABLE [dbo].[pet_adoption_copy]
DROP COLUMN [breeds];

SELECT* FROM [dbo].[pet_adoption_copy];

-- 7.2A. [colors]: Modify strings in [colors] to match JSON format by changing the 'single quotes' to "double quotes".

UPDATE [dbo].[pet_adoption_copy]
SET colors = REPLACE(colors, '''', '"')
WHERE colors LIKE '%''%';

-- 7.2B. Create new columns to table for the information split up from [colors]. 

ALTER TABLE [dbo].[pet_adoption_copy]
ADD [primary color] NVARCHAR(255),
    [secondary color] NVARCHAR(255),
    [tertiary color] NVARCHAR(255);

-- 7.2C. Split up information in [colors] field using JSON_VALUE and populate newly created columns above.

UPDATE [dbo].[pet_adoption_copy]
SET 
    [primary color] = JSON_VALUE([colors], '$.primary'),
    [secondary color] = JSON_VALUE([colors], '$.secondary'),
    [tertiary color] = JSON_VALUE([colors], '$.tertiary');

-- 7.2D. Drop [colors] field from table. 

ALTER TABLE [dbo].[pet_adoption_copy]
DROP COLUMN [colors];

SELECT* FROM [dbo].[pet_adoption_copy];

-- 7.3A. [attributes]: Modify strings in [attributes] to match JSON format by changing the 'single quotes' to "double quotes".

UPDATE [dbo].[pet_adoption_copy]
SET attributes = REPLACE(attributes, '''', '"')
WHERE attributes LIKE '%''%';

-- 7.3B. Create new columns in the table for the different data from [attributes]. 

ALTER TABLE [dbo].[pet_adoption_copy]
ADD [spayed_neutered] VARCHAR(10),
    [house_trained] VARCHAR(10),
    [special_needs] VARCHAR(10),
	[shots_current] VARCHAR(10);

-- 7.3C. Split up information in [attributes] field using JSON_VALUE and populate newly created columns above.

UPDATE [dbo].[pet_adoption_copy]
SET 
    [spayed_neutered] = JSON_VALUE([attributes], '$.spayed_neutered'),
    [house_trained] = JSON_VALUE([attributes], '$.house_trained'),
    [special_needs] = JSON_VALUE([attributes], '$.special_needs'),
	[shots_current] = JSON_VALUE([attributes],'$.shots_current');

-- 7.3D. Drop [attributes] field from table. 

ALTER TABLE [dbo].[pet_adoption_copy]
DROP COLUMN [attributes];

SELECT* FROM [dbo].[pet_adoption_copy];

-- 7.4A. [environment]: Modify strings in [environment] to match JSON format by changing the 'single quotes' to "double quotes".

UPDATE [dbo].[pet_adoption_copy]
SET environment = REPLACE(environment, '''', '"')
WHERE environment LIKE '%''%';

-- 7.4B. Create new columns in the table for the different data from [environment]. 

ALTER TABLE [dbo].[pet_adoption_copy]
ADD [environment_children] VARCHAR(10),
    [environment_dogs] VARCHAR(10),
    [environment_cats] VARCHAR(10);
	

-- 7.4C. Split up information in [environment] field using JSON_VALUE and populate newly created columns above.

UPDATE [dbo].[pet_adoption_copy]
SET 
    [environment_children] = JSON_VALUE([environment], '$.children'),
    [environment_dogs] = JSON_VALUE([environment], '$.dogs'),
    [environment_cats] = JSON_VALUE([environment], '$.cats');

-- 7.4D. Drop [environment] field from table. 

ALTER TABLE [dbo].[pet_adoption_copy]
DROP COLUMN [environment];

SELECT* FROM [dbo].[pet_adoption_copy];

-----------------------------------------------------------------
-- 7.5A. [primary_photo_cropped]: Modify strings in [primary_photo_cropped] to match JSON format by changing the 'single quotes' to "double quotes".

UPDATE [dbo].[pet_adoption_copy]
SET [primary_photo_cropped] = REPLACE([primary_photo_cropped], '''', '"')
WHERE contact LIKE '%''%';


-- 7.5B. Create a new column in the table for the full [primary_photo_cropped]. 

ALTER TABLE [dbo].[pet_adoption_copy]
ADD [full_primary_photo_cropped] NVARCHAR(max);

-- 7.5C. Split up information in the [primary_photo_cropped] field using JSON_VALUE and populate newly created columns above.

UPDATE [dbo].[pet_adoption_copy]
SET 
	  [full_primary_photo_cropped] = JSON_VALUE([primary_photo_cropped], '$.full')
	  WHERE [primary_photo_cropped] != 'None'

select* from [dbo].[pet_adoption_copy]


-- 7.5D. Drop [primary_photo_cropped] field from table. 

ALTER TABLE [dbo].[pet_adoption_copy]
DROP COLUMN [primary_photo_cropped];

SELECT* FROM [dbo].[pet_adoption_copy];

-- Fill in NULL values with 'None'.
UPDATE [dbo].[pet_adoption_copy]
SET [full_primary_photo_cropped] = 'None'
WHERE [full_primary_photo_cropped] IS NULL;

----------------------------------------------------------------------

-- 7.6A. [contact]: Modify strings in [contact] to match JSON format by changing the 'single quotes' to "double quotes".

UPDATE [dbo].[pet_adoption_copy]
SET contact = REPLACE(contact, '''', '"')
WHERE contact LIKE '%''%';


-- 7.6B. Create new columns in the table for the different data from [contact]. 

ALTER TABLE [dbo].[pet_adoption_copy]
ADD	[email] VARCHAR(255),
    [phone] VARCHAR(255),
    [address1] VARCHAR(255),
	[address2] VARCHAR(255),
	[city] VARCHAR(255),
	[state] VARCHAR(10),
	[postcode] VARCHAR(20),
	[country] VARCHAR(10);

-- 7.6C. Split up information in [contact] field using JSON_VALUE and populate newly created columns above.

UPDATE [dbo].[pet_adoption_copy]
SET 
    [email] = JSON_VALUE([contact], '$.email'),
    [phone] = JSON_VALUE([contact], '$.phone'),
    [address1] = JSON_VALUE([contact], '$.address.address1'),
	[address2] = JSON_VALUE([contact], '$.address.address2'),
	[city] = JSON_VALUE([contact], '$.address.city'),
	[state] = JSON_VALUE([contact], '$.address.state'),
	[postcode] = JSON_VALUE([contact], '$.address.postcode'),
	[country] = JSON_VALUE([contact], '$.address.country');


-- 7.6D. Drop [contact] field from table. 

ALTER TABLE [dbo].[pet_adoption_copy]
DROP COLUMN contact;

SELECT* FROM [dbo].[pet_adoption_copy]

-- 8. Check through listings to ensure each row represents just one. 

SELECT [url], [id], [organization_id], [name], [description], [full_primary_photo_cropped]
FROM [dbo].[pet_adoption_copy]
WHERE [name] LIKE '%pair%' OR 
	  [description] LIKE '%pair%' OR
	  [name] LIKE '%litter%' OR 
	  [description] LIKE '%litter%' OR
	  [name] LIKE '%pups%' OR 
	  [description] LIKE '%pups%' OR
	  [name] LIKE '%puppies%' OR 
	  [description] LIKE '%puppies%' -- 19 rows returned.
ORDER BY organization_id

-- id = 48554405. description LIKE 'Litter of 8.%' url shows one puppy. Looking at organization_id = NE 113
-- description = 'Litter of 8.' SHOWS 4 rows. ids = 48554588, 48554405, 48554559, 48554611.
-- Of 4 rows with description LIKE 'Litter of 8.%' All confirmed to be individual dogs. (19 rows returned - 4 vetted = 15 to check).

-- orgnaization_id = NE113 has two more listings, id = 48551132, 48551132. Both confirmed as individual dogs. (15 rows - 2 vetted = 13 to check).

SELECT [url], [id], [organization_id], [name], [description], [full_primary_photo_cropped]
FROM [dbo].[pet_adoption_copy]
WHERE ([name] LIKE '%pair%' OR 
	  [description] LIKE '%pair%' OR
	  [name] LIKE '%litter%' OR 
	  [description] LIKE '%litter%' OR
	  [name] LIKE '%pups%' OR 
	  [description] LIKE '%pups%' OR
	  [name] LIKE '%puppies%' OR 
	  [description] LIKE '%puppies%') AND
	  organization_id != 'NE113'-- 13 rows returned.
ORDER BY organization_id
-- Confirmed single dogs: id = 48550819, 48555494, 48551008, 48550719, 48550601, 48555527, 48550965 (13 rows - 7 confirmed singles = 6 rows to check)

SELECT [url], [id], [organization_id], [name], [description], [full_primary_photo_cropped]
FROM [dbo].[pet_adoption_copy]
WHERE ([name] LIKE '%pair%' OR 
	  [description] LIKE '%pair%' OR
	  [name] LIKE '%litter%' OR 
	  [description] LIKE '%litter%' OR
	  [name] LIKE '%pups%' OR 
	  [description] LIKE '%pups%' OR
	  [name] LIKE '%puppies%' OR 
	  [description] LIKE '%puppies%') AND
	  organization_id != 'NE113' AND
	  id != '48550819' AND id != '48555494' AND id != '48551008' AND 
	  id != '48550719' AND id != '48550601' AND id != '48555527' AND id != '48550965'; -- 6 rows returned.


-- NOT CLEAR IF id = 48549937 IS ONE LISTING OR MORE. CHECK FOR OTHER LISTINGS WITH SAME ORGANIZATION ID.
SELECT* FROM [dbo].[pet_adoption_copy]
--WHERE [organization_id] = 'IN328' -- ONE RESULT RETURNS, THEREFORE CAN ASSUME THAT THIS IS ONE LISTING FOR EIGHT PUPPIES. 
WHERE [organization_id] = 'IN40' -- ONE RESULT RETURNS, THEREFORE CAN CONFIRM THIS IS ONE LISTING FOR THREE DOGS.

-- A. id = 48553429 is one listing for two dogs. (+1)
-- B. id = 48550434 is one listing for four dogs: #Cosmo(Boy), #Mocha (Girl), #Romeo (Boy) & #Ripley (Boy) (+3)
-- C. id = 48551202 is one listing for two dogs (bonded pair). (+1)
-- D. id = 48549851 is one listing for three dogs. (+2)
-- E. id = 48551051 is one listing for two dogs. (+1)
-- F. id = 48549937 is one listing for eight dogs. (+7)
-- THERE SHOULD BE AN ADDITIONAL 15 ROWS ADDED TO THE TABLE. (712 ROWS + 15 ROWS ADDED = 727 ROWS TOTAL)

--------------------------------------------------------------------

-- 8A. id = 48553429 is one listing for two dogs. (+1)
-- Duplicate the row. 
INSERT INTO [dbo].[pet_adoption_copy]
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48553429

SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48553429 

-- Change [id] to create unique records. (Check if id = 48553430 is available.)
SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48553430; -- YES. NO OTHER RECORDS WITH THIS ID. 

WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48553429
)
UPDATE RankedDuplicates
SET [id] = 48553430
WHERE RowNum = 1;

SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48553429 OR id = 48553430; 

-- "The red one is a female and the black and tan one is a male." Change color and gender.

-- red female (to me she appears more yellow than red).
UPDATE [dbo].[pet_adoption_copy]
--SET [primary color] = REPLACE([primary color], 'Black', 'Yellow / Tan / Blond / Fawn')
--SET [secondary color] = REPLACE([secondary color], 'Red / Chestnut / Orange', 'White') -- she has a white spot on her chest.
SET [tertiary color] = REPLACE ([tertiary color], 'Yellow / Tan / Blond / Fawn', 'None')
WHERE [id] = 48553430;

--black and tan male.
UPDATE [dbo].[pet_adoption_copy]
--SET [gender] = REPLACE([gender], 'Female', 'Male')
--SET [secondary color] = REPLACE([secondary color], 'Red / Chestnut / Orange', 'Tan') 
SET [tertiary color] = REPLACE ([tertiary color], 'Yellow / Tan / Blond / Fawn', 'None')
WHERE [id] = 48553429;

-- Confirm changes:
SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48553429 OR id = 48553430; 
--------------------------------------------------------

-- 8B. id = 48550434 is one listing for four dogs: #Cosmo(Boy), #Mocha (Girl), #Romeo (Boy) & #Ripley (Boy) (+3)
-- Duplicate the row. 
INSERT INTO [dbo].[pet_adoption_copy]
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48550434 -- REPEAT TWICE TO CREATE FOUR ROWS.

SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48550434 

-- Change [id] to create unique records. (Check if id = 48550435, 48550436, 48550437 is available.)
SELECT * FROM [dbo].[pet_adoption_copy] 
--WHERE id = 48550435; -- YES. NO OTHER RECORDS WITH THIS ID. 
--WHERE id = 48550436; -- YES. NO OTHER RECORDS WITH THIS ID. 
--WHERE id = 48550437; -- NO. ONE OTHER RECORD WITH THIS ID. 
--WHERE id = 48550433; -- YES. NO OTHER RECORDS WITH THIS ID. 

-- Give each row a unique id.
WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48550434
)
UPDATE RankedDuplicates
SET [id] = 48550435
WHERE RowNum = 1;

SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48550434 OR id = 48550435; 

WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48550434
)
UPDATE RankedDuplicates
SET [id] = 48550436
WHERE RowNum = 1;

SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48550434 OR id = 48550435 OR id = 48550436; 

WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48550434
)
UPDATE RankedDuplicates
SET [id] = 48550433
WHERE RowNum = 1;

SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48550434 OR id = 48550435 OR id = 48550436 OR id = 48550433;

-- Change dog names (and gender) to those given in url: Cosmo(Boy), Mocha (Girl), Romeo (Boy) & Ripley (Boy). 
-- Update colors while we're here.

UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Rottweiler/Lab/Pit Pups', 'Cosmo')
--SET [primary color] = REPLACE([primary color], 'None', 'Black')
SET [secondary color] = REPLACE([secondary color], 'None', 'Tan')
WHERE [id] = '48550433';

UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Rottweiler/Lab/Pit Pups', 'Mocha')
--SET [gender] = REPLACE([gender], 'Male', 'Female')
--SET [primary color] = REPLACE([primary color], 'None', 'Black')
SET [secondary color] = REPLACE([secondary color], 'None', 'Tan')
WHERE [id] = '48550434';

UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Rottweiler/Lab/Pit Pups', 'Romeo')
--SET [primary color] = REPLACE([primary color], 'None', 'Black')
SET [secondary color] = REPLACE([secondary color], 'None', 'White')
WHERE [id] = '48550435';

UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Rottweiler/Lab/Pit Pups', 'Ripley')
--SET [primary color] = REPLACE([primary color], 'None', 'Black')
SET [secondary color] = REPLACE([secondary color], 'None', 'White')
WHERE [id] = '48550436';

-- Confirm changes.
SELECT [id], [name], [primary color], [secondary color] FROM [dbo].[pet_adoption_copy] 
WHERE id = 48550434 OR id = 48550435 OR id = 48550436 OR id = 48550433

SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48550434 OR id = 48550435 OR id = 48550436 OR id = 48550433
-----------------------------------------------------

-- 8C. id = 48551202 is one listing for two dogs (bonded pair). (+1)
-- Duplicate the row (Moonie and Sara (bonded pair))

INSERT INTO [dbo].[pet_adoption_copy]
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48551202;

SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48551202 

-- Change [id] make a unique record per dog.
-- Check if id = 48551203 is taken?
SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48551203 -- NOT TAKEN. CAN USE THIS ID.

WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48551202
)
UPDATE RankedDuplicates
SET [id] = 48551203
WHERE RowNum = 1;

-- Change dog name in 48551202 to Moonie and 48551203 to Sara. 
-- Update coat and color while we're here. 

UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Moonie & Sara (bonded pair)', 'Sara')
--SET [coat] = REPLACE([coat], 'Unknown', 'Short')
SET [primary color] = REPLACE([primary color], 'None', 'Brindle')
WHERE [id] = 48551203;


UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Moonie & Sara (bonded pair)', 'Moonie')
--SET [coat] = REPLACE([coat], 'Unknown', 'Short')
SET [primary color] = REPLACE([primary color], 'None', 'Brindle')
WHERE [id] = 48551202;

-- Ensure the changes are what we wanted.

SELECT* FROM [dbo].[pet_adoption_copy]
WHERE id = 48551202 OR id = 48551203;

-------------------------------------------------------------
-- 8D. id = 48549851 is one listing for three dogs. (+2)
-- This listing includes:
--                        one adult fawn and white female with medium coat.
--                        one fawn and white puppy and one black and white puppy with a short coat (assumed female, but not clear).

-- Duplicate id.
INSERT INTO [dbo].[pet_adoption_copy]
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48549851;

-- Change [id] make a unique record per dog.
-- Check if id = 48549852 is taken?
SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48549852 -- NOT TAKEN. CAN USE THIS ID.

WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48549851
)
UPDATE RankedDuplicates
SET [id] = 48549852
WHERE RowNum = 1;

-- Check changes have been made. 
SELECT* FROM [dbo].[pet_adoption_copy]
WHERE id = 48549851 OR id = 48549852

-- Duplicate new id. 
INSERT INTO [dbo].[pet_adoption_copy]
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48549852;

--SELECT* FROM [dbo].[pet_adoption_copy]
--WHERE id = 48549852

-- Change [id] make a unique record per dog.
-- Check if id = 48549853 is taken?
--SELECT * FROM [dbo].[pet_adoption_copy] 
--WHERE id = 48549853 -- TAKEN. CANNOT USE THIS ID.

-- Check if id = 48549850 is taken?
SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48549850 -- NOT TAKEN. CAN USE THIS ID.

WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48549852
)
UPDATE RankedDuplicates
SET [id] = 48549850
WHERE RowNum = 1;

-- Check for three rows with above ids.
SELECT * FROM [dbo].[pet_adoption_copy]
WHERE [name] = 'Loulou, Momo and Yoyo'

-- Change names, age, coat, and color: 
-- 48549850 / Loulou / Adult / Medium (coat) / Yellow (primary color) / White (secondary color). 

UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Loulou, Momo and Yoyo', 'Loulou')
--SET [age] = REPLACE([age], 'Baby', 'Adult')
--SET [coat] = REPLACE([coat], 'Unknown', 'Medium')
--SET [primary color] = REPLACE([primary color], 'None', 'Yellow')
SET [secondary color] = REPLACE([secondary color], 'None', 'White')
WHERE [id] = 48549850;

-- 48549851 / Momo  / Short (coat) / Yellow (primary color) / White (secondary color). 
UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Loulou, Momo and Yoyo', 'Momo')
--SET [coat] = REPLACE([coat], 'Unknown', 'Short')
--SET [primary color] = REPLACE([primary color], 'None', 'Yellow')
SET [secondary color] = REPLACE([secondary color], 'None', 'White')
WHERE [id] = 48549851;

-- 48549852 / Yoyo / Short (coat) / Black (primary color) / White (secondary color). 
UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Loulou, Momo and Yoyo', 'Yoyo')
--SET [coat] = REPLACE([coat], 'Unknown', 'Short')
--SET [primary color] = REPLACE([primary color], 'None', 'Black')
SET [secondary color] = REPLACE([secondary color], 'None', 'White')
WHERE [id] = 48549852;

SELECT* FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48549850 OR  [id] = 48549851 OR [id] = 48549852
----------------------------------------------------------------
-- 8E. id = 48551051 is one listing for two dogs. (+1)
-- FOREST AND LT DAN - BONDED PAIR 

-- Duplicate the row - 2.
INSERT INTO [dbo].[pet_adoption_copy]
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48551051;

-- Change [id] make a unique record per dog.
-- Check if id = 48551052 is taken.
SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48551052 -- NOT TAKEN. CAN USE THIS ID.

-- Change [id] make a unique record per dog rather than per listing 1.
WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48551051
)
UPDATE RankedDuplicates
SET [id] = 48551052
WHERE RowNum = 1;

-- Change dog name in 48551051 to Forest (bonded pair with Lt Dan) and 48551052 to Lt Dan (bonded Pair with Forest). 

UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Forest &amp; Lt Dan (bonded pair)', 'Forest (bonded pair with Lt Dan)')
--SET [coat] = REPLACE([coat], 'Unknown', 'Short')
SET [primary color] = REPLACE([primary color], 'None', 'Blond')
WHERE [id] = 48551051;

UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Forest &amp; Lt Dan (bonded pair)', 'Lt Dan (bonded pair with Forest)')
--SET [coat] = REPLACE([coat], 'Unknown', 'Short')
SET [primary color] = REPLACE([primary color], 'None', 'Blond')
WHERE [id] = 48551052;

-- Ensure the changes are what we wanted 1.

SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48551051 OR [id] = 48551052;

------------------------------------------------------------
-- 8F. id = 48549937 is one listing for eight dogs. (+7)
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48549937;

-- Duplicate twice to create 8 rows with information for id = 48549937. 
-- Check that there are 8 rows. 
INSERT INTO [dbo].[pet_adoption_copy]
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48549937; -- 8 rows.

-- Change [id] make a unique record per dog.
-- Check if id = 48549938, 48549939, 48549940, 48549941, 48549942, 48549943, 48549944 is taken.
SELECT * FROM [dbo].[pet_adoption_copy] 
--WHERE id = 48549938 -- NOT TAKEN. CAN USE THIS ID.
--WHERE id = 48549939 -- NOT TAKEN. CAN USE THIS ID.
--WHERE id = 48549940 -- NOT TAKEN. CAN USE THIS ID.
--WHERE id = 48549941 -- NOT TAKEN. CAN USE THIS ID.
--WHERE id = 48549942 -- NOT TAKEN. CAN USE THIS ID.
--WHERE id = 48549943 -- NOT TAKEN. CAN USE THIS ID.
WHERE id = 48549944 -- NOT TAKEN. CAN USE THIS ID.

-- Change [id] make a unique record per dog rather than per listing 1.
WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48549937
)
UPDATE RankedDuplicates
SET [id] = 48549938
WHERE RowNum = 1;

WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48549937
)
UPDATE RankedDuplicates
SET [id] = 48549939
WHERE RowNum = 1;

WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48549937
)
UPDATE RankedDuplicates
SET [id] = 48549940
WHERE RowNum = 1;

WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48549937
)
UPDATE RankedDuplicates
SET [id] = 48549941
WHERE RowNum = 1;

WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48549937
)
UPDATE RankedDuplicates
SET [id] = 48549942
WHERE RowNum = 1;

WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48549937
)
UPDATE RankedDuplicates
SET [id] = 48549943
WHERE RowNum = 1;

WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48549937
)
UPDATE RankedDuplicates
SET [id] = 48549944
WHERE RowNum = 1;

-- Check that desired changes have been made.
SELECT* FROM [dbo].[pet_adoption_copy]
WHERE [name] = 'MILO' AND [organization_id] = 'IN328'
ORDER BY [id];

-- ONLY MILO IS BRINDLE (ALL HIS SIBLINGS ARE BLACK) - CHANGE NAME AND PRIMARY COLOR FOR ALL SIBLINGS
UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'MILO', 'MILO Sibling 7') -- number siblings 1-7.
SET [primary color] = REPLACE([primary color], 'Brindle', 'Black')
--WHERE [id] = 48549938;
--WHERE [id] = 48549939;
--WHERE [id] = 48549940;
--WHERE [id] = 48549941;
--WHERE [id] = 48549942;
--WHERE [id] = 48549943;
WHERE [id] = 48549944;

SELECT [id], [name], [primary color]
FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48549938 OR [id] = 48549939 OR [id] = 48549940 OR 
      [id] = 48549941 OR [id] = 48549942 OR [id] = 48549943 OR 
	  [id] = 48549944 OR [id] = 48549937

-- CHECK TO SEE IF ALL ROWS HAVE BEEN ADDED AS PREDICTED. (712 ROWS + 15 ROWS ADDED = 728 ROWS TOTAL)
SELECT* FROM [dbo].[pet_adoption_copy] -- 727 Rows. 

-----------------------------------------------------------------------
-- 8 CONTINUED. CHECK FOR FURTHER DUPLICATES USING [name] LIKE '% and %' OR [name] LIKE '%&%'

SELECT [name]
FROM [dbo].[pet_adoption_copy]
WHERE [name] LIKE '% and %' OR [name] LIKE '%&%' -- 4 rows that could be two dogs rather than one.

SELECT [id], [name], [description], [url], [full_primary_photo_cropped]
FROM [dbo].[pet_adoption_copy]
WHERE [name] = 'Baxter and Roscoe' OR -- Confirmed in description. This is one listing for TWO dogs. (+1)
	  [name] = 'Ben and Jerry' OR -- Confirmed in description. This is one listing for TWO dogs. (+1)
	  [name] = 'Woody Guthrie &#34;Gus&#34;' OR -- Confirmed in description and photo. This is one listing for one dog.
	  [name] = 'Sulu&amp;Norris' -- Confirmed in description. This is one listing for TWO dogs. (+1)
	  -- 727 Rows + 3 New Rows = 730 Rows after adjustments. 

-- Duplicating rows WHERE name = 'Baxter and Roscoe',  'Ben and Jerry', and 'Sulu&amp;Norris'.

-- 8G. Duplicate the row (Baxter and Roscoe)
SELECT* FROM [dbo].[pet_adoption_copy]
WHERE [name] = 'Baxter and Roscoe';

INSERT INTO [dbo].[pet_adoption_copy]
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48553635;

SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48553635; 

-- Change [id] make a unique record per dog.
-- Check if id = 48553636 is taken?
SELECT * FROM [dbo].[pet_adoption_copy] 
--WHERE id = 48553636 -- TAKEN. CANNOT USE THIS ID.
WHERE id = 48553634 -- NOT TAKEN. CAN USE THIS ID.

WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48553635
)
UPDATE RankedDuplicates
SET [id] = 48553634
WHERE RowNum = 1;

-- Check that the two ids correspond to Baxter and Roscoe.
SELECT*
FROM [dbo].[pet_adoption_copy]
WHERE [name] = 'Baxter and Roscoe'; -- corresponds to id = 48553634 and 48553635.

-- Change dog name in 48553634 to Baxter and 48553635 to Roscoe. 
-- Update coat and color while we're here. 

UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Baxter and Roscoe', 'Baxter')
--SET [coat] = REPLACE([coat], 'Unknown', 'Short')
--SET [primary color] = REPLACE([primary color], 'None', 'White')
SET [secondary color] = REPLACE([secondary color], 'None', 'Black')
WHERE [id] = 48553634;

UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Baxter and Roscoe', 'Roscoe')
--SET [coat] = REPLACE([coat], 'Unknown', 'Medium')
--SET [primary color] = REPLACE([primary color], 'None', 'White')
SET [secondary color] = REPLACE([secondary color], 'None', 'Black')
WHERE [id] = 48553635;

-- Ensure the changes are what we wanted.

SELECT* FROM [dbo].[pet_adoption_copy]
WHERE id = 48553634 OR id = 48553635; -- YES. 

------------------------------------------------------------------------
-- 8H. Duplicate the row (Ben and Jerry)
SELECT* FROM [dbo].[pet_adoption_copy]
WHERE [name] = 'Ben and Jerry';  -- id = 48552877


INSERT INTO [dbo].[pet_adoption_copy]
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48552877;

SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48552877; 

-- Change [id] make a unique record per dog.
-- Check if id = 48552878 is taken?
SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48552878 -- NOT TAKEN. CAN USE THIS ID.

-- Setting a unique id for the first row.
WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48552877
)
UPDATE RankedDuplicates
SET [id] = 48552878
WHERE RowNum = 1;

-- Check that the two ids correspond to Ben and Jerry.
SELECT*
FROM [dbo].[pet_adoption_copy]
WHERE [name] = 'Ben and Jerry'; -- corresponds to id = 48552877 and 48552878.

-- Change dog name in 48552877 to Ben and 48552878 to Jerry. 
-- Update color for Ben. 

UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Ben and Jerry', 'Ben')
SET [primary color] = REPLACE([primary color], 'Black', 'Brown / Chocolate')
WHERE [id] = 48552877;

UPDATE [dbo].[pet_adoption_copy]
SET [name] = REPLACE([name], 'Ben and Jerry', 'Jerry')
WHERE [id] = 48552878;

-- Ensure the changes are what we wanted.

SELECT* FROM [dbo].[pet_adoption_copy]
WHERE id = 48552877 OR id = 48552878; -- YES.

-----------------------------------------------------------------------

-- 8I. Duplicate row for Sulu&amp;Norris.
SELECT* FROM [dbo].[pet_adoption_copy]
WHERE [name] = 'Sulu&amp;Norris';

INSERT INTO [dbo].[pet_adoption_copy]
SELECT *
FROM [dbo].[pet_adoption_copy]
WHERE [id] = 48552745;

SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48552745; 

-- Change [id] make a unique record per dog.
-- Check if id = 48552746 is taken?
SELECT * FROM [dbo].[pet_adoption_copy] 
WHERE id = 48552746 -- NOT TAKEN. CAN USE THIS ID.

WITH RankedDuplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM pet_adoption_copy
    WHERE [id] = 48552745
)
UPDATE RankedDuplicates
SET [id] = 48552746
WHERE RowNum = 1;

-- Check that the two ids correspond to Sulu&amp;Norris.
SELECT*
FROM [dbo].[pet_adoption_copy]
WHERE [name] = 'Sulu&amp;Norris'; -- Yes. Corresponds to id = 48552745 and 48552746.

-- Change dog name in 48552745 to Sulu and 48552746 to Norris. 
-- Update coat (Short) and colors (Sulu: cream / Norris: black). 

UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Sulu&amp;Norris', 'Sulu')
--SET [coat] = REPLACE([coat], 'Unknown', 'Short')
SET [primary color] = REPLACE([primary color], 'None', 'Cream')
WHERE [id] = 48552745;

UPDATE [dbo].[pet_adoption_copy]
--SET [name] = REPLACE([name], 'Sulu&amp;Norris', 'Norris')
--SET [coat] = REPLACE([coat], 'Unknown', 'Short')
SET [primary color] = REPLACE([primary color], 'None', 'Black')
WHERE [id] = 48552746;

-- Ensure the changes are what we wanted.

SELECT* FROM [dbo].[pet_adoption_copy]
WHERE id = 48552745 OR id = 48552746; -- YES.

-- Confirm that we no have 730 Rows as predicted. 
SELECT* FROM [dbo].[pet_adoption_copy]; --730 Rows. Check. 

------------------------------------------------------------------------

--9. Fill in NULL values for [names] if listed in [description].
SELECT [id], [name], [description] 
FROM [dbo].[pet_adoption_copy]
WHERE [name] is NULL

-- Two NULL values for names with names included in description. For id =  48549960, name = Fergie. For id = 48550688, name = Oliver.
UPDATE [dbo].[pet_adoption_copy]
SET [name] = 'Fergie'
WHERE [name] IS NULL AND [id] = 48549960;

UPDATE [dbo].[pet_adoption_copy]
SET [name] = 'Oliver'
WHERE [name] IS NULL AND [id] = 48550688;

-- Check to ensure names have been changed.
SELECT [id], [name], [description] 
FROM [dbo].[pet_adoption_copy]
--WHERE [name] is NULL
WHERE [id] = 48549960 OR [id] = 48550688

-- 10. Change [status_changed_at] and [published_at] fields from nvarchar to date.

SELECT [status_changed_at], [published_at] 
FROM [dbo].[pet_adoption_copy]

-- Create new columns in the table for [status_changed_at] and [published_at] information to be stored in Date format. 

ALTER TABLE [dbo].[pet_adoption_copy]
ADD	[status_changed_on_date] DATE,
    [published_on_date] DATE;

-- Check for new columns. 

SELECT [status_changed_at], [published_at], [status_changed_on_date],  [published_on_date] 
FROM [dbo].[pet_adoption_copy]

-- Fill in new columns with appropriate information, in date format. 

/* 
UPDATE your_table
SET your_date_column = CONVERT(DATE, your_nvarchar_column, 127);

The "127" is a style code that you pass to the CONVERT function 
in SQL Server to specify the format of the input string being converted. 
In this case, "127" is the style code for the ISO 8601 format, which 
includes both date and time components along with timezone information.
*/

UPDATE [dbo].[pet_adoption_copy]
SET [status_changed_on_date] = CONVERT(DATE, [status_changed_at], 127);

UPDATE [dbo].[pet_adoption_copy]
SET [published_on_date]  = CONVERT(DATE, [published_at], 127);

-- Drop [status_changed_at] and [published_at] columns. 

ALTER TABLE [dbo].[pet_adoption_copy]
DROP COLUMN [status_changed_at];

ALTER TABLE [dbo].[pet_adoption_copy]
DROP COLUMN [published_at];

SELECT * FROM [dbo].[pet_adoption_copy];

-- 11. Create column - Time_Listed_for_Adoption with [status_changed_at] minus [published_at] - change timedate, just to date.

ALTER TABLE [dbo].[pet_adoption_copy]
ADD	[days_listed_for_adoption] INT;

UPDATE [dbo].[pet_adoption_copy]
SET [days_listed_for_adoption] = DATEDIFF(DAY, [published_on_date], [status_changed_on_date]);

SELECT * FROM pet_adoption_copy

-- 12. Check all US states are listed.
SELECT DISTINCT[state]
FROM [dbo].[pet_adoption_copy] -- Lists 51 states, first one listed as AB (which is not a state abbreviation)?

SELECT * 
FROM [dbo].[pet_adoption_copy] 
WHERE [state] = 'AB'

SELECT*
FROM [dbo].[pet_adoption_copy] 
WHERE [country] != 'US' -- 2 rows listed id = 48553223 and id = 48555324 where country is CA.

/* 13. NOTE: The field [description] unfortunately has limited informaion. 
Unforuntately, this table was designed with (nvarchar(255),null) for descritpion (as well as most of the fields),
so that many of the descpritions are cut off and we are left with incomplete information for many of the dogs. 
Possible resolutions in future would be to (1) allow for more characters in descritpion, possibly even (nvarchar(max),null) 
as was done for the [photos] field. While it may be possible to find full descpritions for some of the dogs via the 
urls listed, doing so for all [descriptions] manually is beyond the scope of this project. For now data scraping is the same - 
and due to the lapse of time between the creation of the table and this project, some of the listings have been removed,
so even if we were to try to use datascraping or maually enter descriptions, there would still be a gap in the information available. */