package random;

import database.Database;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Clock;
import java.util.UUID;

/**
 * Created by matijav on 19/12/2016.
 */
public class Random extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setStatus(HttpServletResponse.SC_OK);

        String uuid = UUID.randomUUID().toString();

        Connection c = Database.getConnection();
        try (PreparedStatement ps = c.prepareStatement("INSERT INTO record (source, generated, timestamp) VALUES (?, ?, ?)")) {
            ps.setString(1, req.getRemoteHost());
            ps.setString(2, uuid);
            ps.setTimestamp(3, new Timestamp(Clock.systemUTC().millis()));

            ps.executeUpdate();
        } catch (SQLException e) {
            log("Exception while inserting record into database.", e);
        }
        Database.putConnection(c);

        resp.getWriter().write(uuid);
    }
}
