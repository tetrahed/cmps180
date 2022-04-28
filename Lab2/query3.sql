SELECT DISTINCT s.exchangeID, s.stockName
FROM Stocks s, Quotes q
WHERE q.exchangeID = s. exchangeID AND q.price < 314.15 AND q.symbol = s.symbol
