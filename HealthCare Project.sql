-- Showing Distint Values on The Table on healthcare

SELECT DISTINCT
    PatientID, Name, Age, BloodType, BillingAmount
FROM
    healthcare
ORDER BY Age;

-- Creating a Functions for Age on health care Table

 DELIMiTER $$
    CREATE FUNCTION AgeCategory (
    Age char(30))
    returns varchar(35)
    deterministic
    begin
    if Age > 55
    then return ('Older Adult');
    elseif Age < 55
    then return ('Yonger Adult');
    else return ('Adolescents');
    end if;
    end $$

SELECT healthcare.AgeCategory('80');

-- Creating, Insert, Delete and Update triggers on my table

-- ALTER TABLE

ALTER TABLE healthcare
ADD COLUMN BillingAmountUpgrade INT AFTER BillingAmount;

SELECT 
    *
FROM
    healthcare;
     
-- Updating Table

UPDATE healthcare 
SET 
    BillingAmountUpgrade = BillingAmount * 0.1;
  
-- Creating Triggers

CREATE 
    TRIGGER  BillingAmountUpgrade
 BEFORE UPDATE ON healthcare FOR EACH ROW 
    SET new . BillingAmount = new.BillingAmount * 0.2;
    
SHOW TRIGGERS;

-- Updating PatientID 5 Age on healthcare table

UPDATE healthcare 
SET 
    Age = 15
WHERE
    PatientID = 5;

-- Creating a stored procedures

Delimiter //
Create Procedure 
updateSalesbyId(IN porderid Int,
	in pnewsales Decimal(10,2))
    Begin
		Update superstore
        set sales = pnewsales
        where OrderId= porderid;
        End //
Delimiter ;


-- Adding a new field to the table and populating data into it.

ALTER TABLE medications 
ADD COLUMN CardNo INT AFTER PatientID;

UPDATE medications
SET CardNo = PatientID + 1;

-- Changing The Name On My Field

ALTER TABLE caregiver
RENAME column Doctor TO Physician;

-- Creating a New User in my Database

CREATE USER 'evans' identified by '8324';

show grants for evans;

-- GRANTING SELECT|INSERT|ALTER Privilages to evans

GRANT SELECT, INSERT, ALTER on healthcare.* to evans; 

-- Revoking All Privileges

REVOKE SELECT, INSERT, ALTER ON  healthcare.* FROM evans;

-- Backing up and Restoring my healthcare database

show databases;

-- BACKUP -- mysqldump -u root -p healthcare > healthcare_backup.sql

-- RESTORE -- mysql -u root -p project < healthcare_backup.sql
