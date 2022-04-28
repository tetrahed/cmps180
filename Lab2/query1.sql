SELECT c.customerID, c.custName, c.address
FROM Customers c
WHERE c.isValidCustomer = TRUE AND c.custName LIKE '%FAKE%'
