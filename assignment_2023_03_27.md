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

## Atomicity:
This property ensures that each transaction is treated as a single, indivisible unit of work. It means that either all the changes in a transaction are committed to the database or none of them are.

## Consistency:
This property ensures that the database remains in a consistent state before and after the transaction. It means that the transaction must follow a set of rules and constraints to ensure data integrity.

## Isolation: 
This property ensures that transactions are processed independently of each other. It means that each transaction operates as if it is the only transaction being processed, and it is not affected by other transactions running concurrently.

## Durability: 
This property ensures that once a transaction is committed to the database, it remains permanently stored even if there is a system failure.

# 5. There are five records in a data base. There is an index file associated with this and it contains the values 1,3,2,5 and 4. Which one of the fields is the index built from?
After sorting the table by the Occupation column in ascending order, the original rows will get placed in the given sequence: 1, 3, 2, 5, 4. Therefore, it can be concluded that the index file is built from the *Occupation* column.