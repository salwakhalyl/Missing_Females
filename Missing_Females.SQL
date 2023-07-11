--I-Check the columns name and data types :

SELECT *
FROM Portfolio.dbo.Missing_Females

--II-Change the Date column type from Datetime to Date, and update the table :

SELECT CAST([Date] AS date)
FROM Portfolio.dbo.Missing_Females

ALTER TABLE Portfolio.dbo.Missing_Females
ADD Date_of_disappearance date

UPDATE Portfolio.dbo.Missing_Females
SET Date_of_disappearance = CAST([Date] AS date)

--III- Breaking out the Location column into individual columns (City and State) :

SELECT *
FROM Portfolio.dbo.Missing_Females

ALTER TABLE Portfolio.dbo.Missing_Females
ADD City NVARCHAR(200) , [State] NVARCHAR(200)

UPDATE Portfolio.dbo.Missing_Females
SET City = PARSENAME(REPLACE(Location, ',' , '.') , 2),
    State = PARSENAME(REPLACE(Location, ',' , '.') , 1)

--IV- Change the states names to a two-letter state :


SELECT Distinct [State]
FROM Portfolio.dbo.Missing_Females
 

UPDATE Portfolio.dbo.Missing_Females
SET [State] = REPLACE([State], ' ', '')

-------We notice first that there's 6 states are named 'USA', let's modify them

SELECT *
FROM Portfolio.dbo.Missing_Females
WHERE [State]='USA'

UPDATE Portfolio.dbo.Missing_Females
SET [State]=CASE WHEN [State]='USA' THEN City
                 ELSE [State]
				 END



UPDATE Portfolio.dbo.Missing_Females
SET [State]=CASE WHEN [State]='Alaska' THEN 'AK'
                 WHEN [State]='Arkansas' THEN 'AR'
				 WHEN [State]='Aruba' THEN 'ABW'
				 WHEN [State]='ARB' THEN 'ABW'
				 WHEN [State]='Colorado' THEN 'CO'
				 WHEN [State]='Connecticut' THEN 'CT'
				 WHEN [State]='Idaho' THEN 'ID'
				 WHEN [State]='Indiana' THEN 'IN'
				 WHEN [State]='Kansas' THEN 'KS'
				 WHEN [State]='Michigan' THEN 'MI'
				 WHEN [State]='Missouri' THEN 'MO'
				 WHEN [State]='Nebraska' THEN 'NE'
				 WHEN [State]='Nevada' THEN 'NV'
				 WHEN [State]='NewMexico' THEN 'NM'
				 WHEN [State]='NorthDakota' THEN 'ND'
				 WHEN [State]='Ohio' THEN 'OH'
				 WHEN [State]='Oklahoma' THEN 'OK'
				 WHEN [State]='Oregon' THEN 'OR'
				 WHEN [State]='Pennsylvania' THEN 'PA'
				 WHEN [State]='SouthDakota' THEN 'SD'
				 WHEN [State]='Utah' THEN 'UT'
				 WHEN [State]='Wyoming' THEN 'WY'
				 WHEN [State]='Alaska' THEN 'AK'
			     Else [State]
			END

SELECT DISTINCT [State]
FROM Portfolio.dbo.Missing_Females

 
 
 --V- Remove all Non-US states

------- Mexico, UK(united kingdom), SK(Saskatchewan in Canada), MB(Manitoba in Canada),ABW( Aruba in southern Caribbean Sea)

DELETE FROM Portfolio.dbo.Missing_Females
WHERE  [State]='UK' 

DELETE FROM Portfolio.dbo.Missing_Females
WHERE [State]='SK' 

DELETE FROM Portfolio.dbo.Missing_Females
WHERE [State]='MB' 

DELETE FROM Portfolio.dbo.Missing_Females
WHERE [State]='ABW'


--VI- Lest's delete rows with null cities


DELETE FROM Portfolio.dbo.Missing_Females
WHERE City IS NULL


--VII- Let's group Races into 9 categorizes :
----1-African American / Black
----2-Caucasian / White
----3-Hispanic / Latina
----4-American Indian / Alaska Native
----5-Asian
----6-Biracial (Asian and white)
----7-Indigenous
----8-Native American (specifically Cherokee Nation)
----9-Multiple (indicating a mix of different races)

SELECT DISTINCT Race
FROM Portfolio.dbo.Missing_Females

UPDATE Portfolio.dbo.Missing_Females
SET Race = CASE WHEN Race = 'Hispanic' OR Race = 'Hispanic / Latina' OR Race = 'Hispanic/Latina' OR Race = 'Latina' THEN 'Hispanic / Latina'
                WHEN Race = 'Caucasian' OR Race = 'Caucasian / White' OR Race = 'Caucasian/White' OR Race = 'White' OR Race = 'White / Caucasian' OR Race = 'White/Caucasian' THEN 'Caucasian / White'
				WHEN Race = 'African American / Black' OR Race = 'Black' OR Race = 'Black / African American' OR Race = 'Black/African American'  THEN 'African American / Black'
				WHEN Race = 'American Indian / Alaska Native' OR Race = 'American Indian/Alaska Native' THEN 'American Indian / Alaska Native'
				WHEN Race = 'Asian'  THEN 'Asian'
				WHEN Race = 'Asian, White/Caucasian' OR Race = 'Biracial (Asian and white)' THEN 'Biracial (Asian and white)'
				WHEN Race = 'Native American'  THEN 'Native American'
				WHEN Race = 'African American / Black, Caucasian / White' OR Race = 'African American / Black, Hispanic / Latina' OR Race = 'American Indian / Native American (Cherokee Nation) ; Caucasian / White' OR Race = 'Caucasian / White (Lebanese)'OR Race = 'Caucasian / White ; Hispanic / Latina'OR Race = 'Caucasian / White ; Native American / American Indian'OR Race = 'Latina, Native American' OR Race = 'Multiple' OR Race = 'Native American ; Caucasian / White' THEN 'Multiple (indicating a mix of different races)'

                ELSE Race
				END


--VII- Let's change height unit to inches

SELECT Height
FROM Portfolio.dbo.Missing_Females


------- Let's trim the Height column first
UPDATE Portfolio.dbo.Missing_Females
SET Height = TRIM(Height)
------- we notice that certain heighs contains the letter A and Â , let's remove them 
UPDATE Portfolio.dbo.Missing_Females
SET Height = REPLACE(Height,'Â', '')
------- we notice also that there's 4 rows with NULL values and 1 row with invalid text, let's delete them
DELETE FROM Portfolio.dbo.Missing_Females
WHERE Height IS NULL
DELETE FROM Portfolio.dbo.Missing_Females
WHERE Height LIKE '%/'



--VIII-Delete unused columns


ALTER TABLE Portfolio.dbo.Missing_Females
DROP COLUMN [Nicknames / Aliases], [Date],[Location], [Description], [Links], 






























