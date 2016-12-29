package database;

import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Stack;

/**
 * Created by matijav on 29/12/2016.
 */
public class Database {
    public static final String ENV_HEROKU_POSTGRESQL_GRAY_URL = "HEROKU_POSTGRESQL_GRAY_URL";

    private static final int CONNECTION_POOL_SIZE = 18;
    private static Stack<Connection> connectionsPool = new Stack<>();

    static {
        for (int i = 0; i < CONNECTION_POOL_SIZE; i++) {
            try {
                String dbUrl = System.getenv("JDBC_DATABASE_URL");
                Connection connection = DriverManager.getConnection(dbUrl);
                connectionsPool.push(connection);
            } catch (SQLException e) {
                System.err.println(e);
            }

            try {
                Thread.sleep(10);
            } catch (InterruptedException e) {
                // pass
            }
        }
    }

    // TODO: 28/12/2016 cache database connections
    public static synchronized Connection getConnection() {
        if (connectionsPool.empty()) {
            throw new NoMoreConnectionsException();
        }

        return connectionsPool.pop();
    }

    public static synchronized void putConnection(Connection connection) {
        connectionsPool.push(connection);
    }


    public static Connection getConnection(String databaseUrl) throws URISyntaxException, SQLException {
        return DriverManager.getConnection(databaseUrl);
    }
}
