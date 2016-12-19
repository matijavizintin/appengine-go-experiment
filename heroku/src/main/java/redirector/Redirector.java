package redirector;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
        // TODO: 19/12/2016 read from database
        int idx = random.nextInt(Urls.ENDPOINTS.length) + 1;
        if (idx == Urls.ENDPOINTS.length) {
            return null;
        }
        return Urls.ENDPOINTS[idx];

    }
}
