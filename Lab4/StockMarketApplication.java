import java.sql.*;
import java.util.*;

/**
 * The class implements methods of the StockMarket database interface.
 *
 * All methods of the class receive a Connection object through which all
 * communication to the database should be performed. Note: the
 * Connection object should not be closed by any method.
 *
 * Also, no method should throw any exceptions. In particular, in case
 * an error occurs in the database, then the method should print an
 * error message and call System.exit(-1);
 */

public class StockMarketApplication
{

    private Connection connection;

    /*
     * Constructor
     */
    public StockMarketApplication(Connection connection)
    {
        this.connection = connection;
    }

    public Connection getConnection()
    {
        return connection;
    }

    /**
     * Takes as argument an integer called numDifferentStocksSold.
     * Returns the customerID for each customer in Customers that has been the seller of at least
     * numDifferentStocksSold different stocks in Trades.
     * If numDifferentStocksSold is not positive, that's an error.
     */

    public List<Integer> getCustomersWhoSoldManyStocks(int numDifferentStocksSold)
    {
        List<Integer> result = new ArrayList<Integer>();

            if(numDifferentStocksSold <= 0)
            {
                System.out.println("Error on numDifferentStocksSold");
            }
            else
            {
                try
                {
                    String query = "SELECT c.customerID FROM Customers c, Trades t, Stocks s WHERE c.customerID = t.sellerID AND s.exchangeID = t.exchangeID
                    AND s.symbol = t.symbol GROUP BY c.customerID HAVING COUNT(*) >=" + numDifferentStocksSold;

                    PreparedStatement stat1 = connection.prepareStatement(query);
                    ResultSet stat2 = stat1.executeQuery();

                    while(stat2.next())
                    {
                        int customerID = stat2.getInt(1);
                        System.out.println(customerID);
                        result.add(customerID);
                    }
                }

                catch(SQLException se)
                {
                    System.out.println(se.toString());
                }
            }
            return result;
    }


    /**
     * The updateQuotesForBrexit method has one string argument, theExchangeID, which is the exchangeID
     * for an exchange. updateQuotesForBrexit should update price in Quotes for every quote that has
     * that exchangedID, multiplying price by 0.87.
     * updateQuotesForBrexit should return the number of quotes whose prices were updated.
     */

    public int updateQuotesForBrexit(String theExchangeID)
    {
        // your code here; return 0 appears for now to allow this skeleton to compile.
        //return 0;
        int affectedRows = 0;
        try
        {
            String query = "UPDATE Quotes SET price = price*0.87 WHERE exchangeID = '" + theExchangeID + "'";
            PreparedStatement stat1 = connection.prepareStatement(query);
            affectedRows = stat1.executeUpdate();
        }

        catch(SQLException se)
        {
            System.out.println(se.toString());
        }
        return affectedRows;
    }


    /**
     * rewardBestBuyers has two integer parameters, theSellerID and theCount.  It invokes a stored
     * function rewardBuyersFunction that you will need to implement and store in the database
     * according to the description in Section 5.  rewardBuyersFunction should have the same two
     * parameters, theSellerID and theCount.
     *
     * Trades has a volume attribute.  rewardBuyersFunction will increase the volume for some trades
     * whose sellerID is theSellerID; Section 5 explains which trade volumes should be increased,
     * and how much they should be increased.  The rewardBestBuyers method should return the same
     * integer result as the rewardBuyersFunction stored function.
     *
     * The rewardBestBuyers method must only invoke the stored function rewardBuyersFunction, which
     * does all of the assignment work; do not implement the rewardBestBuyers method using a bunch of
     * SQL statements through JDBC.  However, rewardBestBuyers should check to see whether theCount
     * is greater than 0, and report an error if it’s not.
     */

    public int rewardBestBuyers (int theSellerID, int theCount)
    {
        // There's nothing special about the name storedFunctionResult
        int storedFunctionResult = 0;

        // your code here
        if (theCount <= 0)
        {
            System.out.println("theCount is negative or 0!");
        }
        else
        {
            try
            {
                PreparedStatement statement = connection.prepareStatement("SELECT rewardBuyersFunction(" + theSellerID + ", " + theCount + ")");
                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next())
                {
                    storedFunctionResult = resultSet.getInt(1);
                }

                resultSet.close();
                statement.close();
            }

            catch (SQLException se)
            {
                System.out.println(se.toString());
            }
        }

        // end of your code
        return storedFunctionResult;

    }

};
