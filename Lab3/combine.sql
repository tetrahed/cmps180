--make queries
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE Customers
    SET custName = nC.custName, address = nC.address, isValidCustomer = true
    FROM NewCustomers nC
    WHERE Customers.customerID = nC.customerID;

INSERT INTO Customers (customerID, custName, address)
    SELECT nC.customerID, nC.custName, nC.address
    FROM NewCustomers nC
    WHERE nC.customerID NOT IN (SELECT customerID FROM Customers);

COMMIT;
