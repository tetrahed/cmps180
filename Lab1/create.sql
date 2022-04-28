--Lab 1

CREATE TABLE Exchanges (
    exchangeID CHAR(6) PRIMARY KEY,
    exchangeName VARCHAR(30),
    address VARCHAR(30)
);

CREATE TABLE Stocks (
    exchangeID CHAR(6),
    symbol CHAR(4),
    stockName VARCHAR(30),
    address VARCHAR(30),
    PRIMARY KEY(exchangeID, symbol)
);

CREATE TABLE Customers (
    customerID INTEGER,
    custName VARCHAR(30),
    address VARCHAR(30),
    category CHAR(1),
    isValidCustomer BOOLEAN,
    PRIMARY KEY(customerID)
);

CREATE TABLE Trades (
    exchangeID CHAR(6),
    symbol CHAR(4),
    tradeTS TIMESTAMP,
    buyerID INTEGER,
    sellerID INTEGER,
    price DECIMAL(7,2),
    volume INTEGER,
    PRIMARY KEY(exchangeID, symbol, tradeTS)
);

CREATE TABLE Quotes (
    exchangeID CHAR(6),
    symbol CHAR(4),
    quoteTS TIMESTAMP,
    price DECIMAL(7,2),
    PRIMARY KEY(exchangeID, symbol, quoteTS)
);
