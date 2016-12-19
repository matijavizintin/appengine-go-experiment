import org.eclipse.jetty.server.Handler;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.handler.HandlerCollection;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.ServletHolder;
import random.Random;
import redirector.Redirector;

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

        HandlerCollection handlerCollection = new HandlerCollection();
        handlerCollection.setHandlers(new Handler[]{
                redirector,
                random,
        });

        server.setHandler(handlerCollection);

        server.start();
        server.join();
    }
}
