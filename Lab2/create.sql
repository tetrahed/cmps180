--Lab 2

/*
The following attributes cannot be null:
In Stocks:  stockName
In Trades:  price
In Trades:  volume

The following must be unique for the specified table:
In Exchanges:  the attribute exchangeName
In Stocks:  the attribute stockName
In Customers:  the 2 attributes custName and address
*/

DROP SCHEMA Lab2 CASCADE;
CREATE SCHEMA Lab2;

CREATE TABLE Exchanges
(
    exchangeID CHAR(6) PRIMARY KEY,
    exchangeName VARCHAR(30),
    address VARCHAR(30),
    UNIQUE(exchangeName)
);

CREATE TABLE Stocks
(
    exchangeID CHAR(6),
    symbol CHAR(4),
    stockName VARCHAR(30) NOT NULL,
    address VARCHAR(30),
    PRIMARY KEY(exchangeID, symbol),
    UNIQUE(stockName)
);

CREATE TABLE Customers
(
    customerID INTEGER,
    custName VARCHAR(30),
    address VARCHAR(30),
    category CHAR(1),
    isValidCustomer BOOLEAN,
    PRIMARY KEY(customerID),
    UNIQUE(custName, address)
);

CREATE TABLE Trades
(
    exchangeID CHAR(6),
    symbol CHAR(4),
    tradeTS TIMESTAMP,
    buyerID INTEGER,
    sellerID INTEGER,
    price DECIMAL(7,2) NOT NULL,
    volume INTEGER NOT NULL,
    PRIMARY KEY(exchangeID, symbol, tradeTS)
);

CREATE TABLE Quotes
(
    exchangeID CHAR(6),
    symbol CHAR(4),
    quoteTS TIMESTAMP,
    price DECIMAL(7,2),
    PRIMARY KEY(exchangeID, symbol, quoteTS)
);
