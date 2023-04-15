# 1. Create a trigger to fill up the full_name column in the dependents table while

```sql
CREATE TRIGGER Trigger_dependents
ON dependents
AFTER INSERT
AS
BEGIN
   UPDATE d
   SET d.full_name = CONCAT(i.first_name, ' ', i.last_name)
   FROM dependents d
   INNER JOIN inserted i ON
   d.departmnet_id = i.departmnet_id;
END;
```

# 2. Create a trigger that stores the transaction records of each insert, update and delete operations performed on the locations table into locations_info table.

```sql
CREATE TRIGGER locations_trigger
ON locations
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF (EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted))
    BEGIN
        INSERT INTO locations_info (operation, location_id,
        street_address,city, state_province, postal_code)
        SELECT 'UPDATE', d.location_id, d.street_address,
        d.city, d.state_province, d.postal_code
        FROM deleted d
        INNER JOIN inserted i ON d.location_id =
        i.location_id;
    END
    ELSE IF (EXISTS(SELECT * FROM inserted))
    BEGIN
        INSERT INTO locations_info (operation, location_id,
        street_address, city, state_province, postal_code)
        SELECT 'INSERT', i.location_id, i.street_address,
        i.city, i.state_province, i.postal_code
        FROM inserted i;
    END
    ELSE IF (EXISTS(SELECT * FROM deleted))
    BEGIN
        INSERT INTO locations_info (operation, location_id,
        street_address, city, state_province, postal_code)
        SELECT 'DELETE', d.location_id, street_address,
        d.city, d.state_province, d.postal_code
        FROM deleted d;
    END
END;
```
# 3. For the following tables create a view named employee_information with employee first name, last name, salary, department name, city, postal code insert only those records whose postal code length is less than 5.

```sql
CREATE VIEW employee_information AS
SELECT e.first_name, e.last_name, e.salary, d.department_name, l.city, l.postal_code
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
WHERE LEN(l.postal_code) < 5;
```

# 4. Explain ACID properties with an example.
   
ACID is an acronym that stands for **Atomicity, Consistency, Isolation, and Durability.**

Suppose a bank transfer operation from Account A to Account B involves the following steps:

*Deduct the transfer amount from Account A <br>
Add the transfer amount to Account B* <br>

The ACID properties ensure that the transfer operation is processed reliably, even in the face of system failures or concurrent transactions. Here's how each property applies:

## Atomicity:
The entire transfer operation is treated as a single, indivisible unit of work. If any part of the operation fails, the entire transaction is rolled back and neither account is affected.
## Consistency: 
The transfer operation ensures that the total balance of all accounts remains unchanged. If the transfer operation succeeds, the total balance of all accounts remains the same as before the transfer.
## Isolation: 
The transfer operation is isolated from other concurrent transactions. If multiple transfer operations are happening simultaneously, each transaction sees a consistent view of the data, and the final outcome is the same as if the transactions had occurred serially.
## Durability: 
The result of the transfer operation is permanently stored in the database, even in the face of system failures such as power outages or hardware failures. Once the transfer operation has been committed, it remains committed even if the system crashes.

# 5. There are five records in a data base. There is an index file associated with this and it contains the values 1,3,2,5 and 4. Which one of the fields is the index built from?
After sorting the table by the Occupation column in ascending order, the original rows will get placed in the given sequence: 1, 3, 2, 5, 4. Therefore, it can be concluded that the index file is built from the *Occupation* column.