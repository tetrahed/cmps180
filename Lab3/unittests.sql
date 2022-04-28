--unit tests
INSERT INTO Trades(buyerID)
    SELECT c.custName
    FROM Customers c;

INSERT INTO Trades(sellerID)
    SELECT c.custName
    FROM Customers c;

INSERT INTO Trades(exchangeID,symbol)
    SELECT s.stockName, s.address
    FROM Stocks s;

INSERT INTO Quotes(exchangeID,symbol)
    SELECT s.stockName, s.address
    FROM Stocks s;

--general constraints test
UPDATE Quotes
    SET price = 3;

UPDATE Quotes
    SET price = -1;



UPDATE Trades
    SET price = 4, volume = 3;

UPDATE Trades
    SET price = -5, volume = 0;



UPDATE Trades
    SET buyerID = 3, sellerID = 3;

UPDATE Trades
    SET buyerID = 2, sellerID = 3;



UPDATE Customers
    SET category = 'H', isValidCustomer = TRUE;

UPDATE Customers
    SET category = 'C', isValidCustomer = TRUE;
