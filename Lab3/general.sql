--add general constraints
ALTER TABLE Quotes
ADD CONSTRAINT price CHECK (price >0);

ALTER TABLE Trades
ADD CONSTRAINT positive_cost CHECK ( price * volume >0);

ALTER TABLE Trades
ADD CONSTRAINT nameOfBuyerAndSeller CHECK (buyerID != sellerID);

ALTER TABLE Customers
ADD CONSTRAINT categoryAndCustomer CHECK (category != 'H' OR isValidCustomer = true);
