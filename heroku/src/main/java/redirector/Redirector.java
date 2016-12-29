package redirector;


import database.Database;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
        Connection c = Database.getConnection();
        try (Statement s = c.createStatement();
             ResultSet rs = s.executeQuery("SELECT url FROM redirect")) {
            while (rs.next()) {
                endpoints.add(rs.getString("url"));
            }
        } catch (SQLException e) {
            log("Error reading from database.", e);
            return null;
        }
        Database.putConnection(c);

        int idx = random.nextInt(endpoints.size()) + 1;
        if (idx == endpoints.size()) {
            return null;
        }
        return endpoints.get(idx);

    }
}
