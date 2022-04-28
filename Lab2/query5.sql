SELECT DISTINCT t.exchangeID, s.stockName, buyers.custName AS buyerName, sellers.custName AS sellerName
FROM Trades t, Stocks s, Customers sellers, Customers buyers
WHERE t.buyerID = buyers.customerID AND t.sellerID = sellers.customerID AND t.exchangeID = s.exchangeID  AND s.symbol = t.symbol AND t.tradeTS < TIMESTAMP '2018-01-01 12:00:00' 
