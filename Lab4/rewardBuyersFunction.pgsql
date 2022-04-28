CREATE OR REPLACE FUNCTION rewardBuyersFunction (theSellerID INTEGER, theCount INTEGER) RETURNS INTEGER AS $$
        DECLARE totalNumberTradesIncreased INTEGER := 0;
        DECLARE rowsAffected INTEGER;
        DECLARE theBuyer INTEGER;
        DECLARE theSeller INTEGER;
        DECLARE theTotalCost INTEGER;
        DECLARE theBuyerCategory CHAR(1);
        DECLARE tradeChanged INTEGER := 0;
        DECLARE data CURSOR FOR SELECT buyerID, sellerID, totalCost, category as buyerCategory FROM BuyerSellerTotalCost, Customers WHERE sellerID = theSellerID AND buyerID = customerID ORDER BY totalCost DESC;
        
    BEGIN     
        OPEN data;
            WHILE tradeChanged < theCount LOOP
                FETCH data INTO theBuyer, theSeller, theTotalCost, theBuyerCategory;
                EXIT WHEN NOT FOUND;
                IF theBuyerCategory = 'H' THEN
                    UPDATE Trades SET volume = volume + 50 WHERE buyerID = theBuyer AND sellerID = theSeller;
                ELSEIF theBuyerCategory = 'M' THEN
                    UPDATE Trades SET volume = volume + 20 WHERE buyerID = theBuyer AND sellerID = theSeller;
                ELSEIF theBuyerCategory = 'L' THEN
                    UPDATE Trades SET volume = volume + 5 WHERE buyerID = theBuyer AND sellerID = theSeller;
                ELSE
                    UPDATE Trades SET volume = volume + 1 WHERE buyerID = theBuyer AND sellerID = theSeller;
                END IF;
                GET DIAGNOSTICS rowsAffected = ROW_COUNT;
                tradeChanged := tradeChanged + 1;
                totalNumberTradesIncreased := totalNumberTradesIncreased + rowsAffected;
            END LOOP;
        CLOSE data;
        RETURN totalNumberTradesIncreased;
    END;
$$ LANGUAGE plpgsql;