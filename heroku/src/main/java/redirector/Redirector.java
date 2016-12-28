package redirector;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * Created by matijav on 18/12/2016.
 */
public class Redirector extends HttpServlet {
    private static final Random random = new Random(System.currentTimeMillis());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String endpoint = calculateRedirectUrl();
        if (endpoint == null) {
            resp.setStatus(HttpServletResponse.SC_OK);
            return;
        }

        resp.sendRedirect(endpoint);
    }

    private String calculateRedirectUrl() {
        List<String> endpoints = new ArrayList<>();
        try (Connection c = getConnection();
             Statement s = c.createStatement();
             ResultSet rs = s.executeQuery("SELECT url FROM redirect")) {
            while (rs.next()) {
                endpoints.add(rs.getString("url"));
            }
        } catch (URISyntaxException | SQLException e) {
            log("Error reading from database.", e);
            return null;
        }

        int idx = random.nextInt(endpoints.size()) + 1;
        if (idx == endpoints.size()) {
            return null;
        }
        return endpoints.get(idx);

    }

    // TODO: 28/12/2016 cache database connections
    private static Connection getConnection() throws URISyntaxException, SQLException {
        String dbUrl = System.getenv("JDBC_DATABASE_URL");
        return DriverManager.getConnection(dbUrl);
    }
}
