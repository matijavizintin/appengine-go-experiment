import org.eclipse.jetty.server.Handler;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.handler.HandlerCollection;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.ServletHolder;
import random.Random;
import redirector.Redirector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by matijav on 18/12/2016.
 */
public class Router {

    public static void main(String[] args) throws Exception {
        Server server = new Server(Integer.valueOf(System.getenv("PORT")));

        ServletContextHandler redirector = new ServletContextHandler(ServletContextHandler.SESSIONS);
        redirector.setContextPath("/redirect");
        redirector.addServlet(new ServletHolder(new Redirector()), "/*");

        ServletContextHandler random = new ServletContextHandler(ServletContextHandler.SESSIONS);
        random.setContextPath("/random");
        random.addServlet(new ServletHolder(new Random()), "/*");

        ServletContextHandler root = new ServletContextHandler(ServletContextHandler.SESSIONS);
        root.setContextPath("/");
        root.addServlet(new ServletHolder(new HttpServlet() {
            @Override
            protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                resp.setContentType("text/html");
                resp.setStatus(HttpServletResponse.SC_OK);

                resp.getWriter().println("Hello");
            }
        }), "/*");

        HandlerCollection handlerCollection = new HandlerCollection();
        handlerCollection.setHandlers(new Handler[]{
                redirector,
                random,
                root,
        });

        server.setHandler(handlerCollection);

        server.start();
        server.join();
    }
}
