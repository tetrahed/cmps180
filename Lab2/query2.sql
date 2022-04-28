SELECT s.stockName AS Name, s.symbol
FROM Stocks s, Exchanges e
WHERE e.exchangeName != 'NASDAQ Stock Exchange' AND s.exchangeID = e.exchangeID
