/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Web application lifecycle listener.
 *
 * @author marcin
 */
public class ContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String history = sce.
                getServletContext().getInitParameter("debug");
        ServletContext context = sce.getServletContext();
        context.setAttribute("debug", history);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
