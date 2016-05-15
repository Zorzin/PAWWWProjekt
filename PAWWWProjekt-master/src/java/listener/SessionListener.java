/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listener;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;

/**
 * Web application lifecycle listener.
 *
 * @author marcin
 */
public class SessionListener implements HttpSessionAttributeListener {

    private int totalSessionCount = 0;
    private int currentSessionCount = 0;
    private int maxSessionCount = 0;
    private ServletContext context = null;

    @Override
    public void attributeAdded(HttpSessionBindingEvent event) {
        totalSessionCount++;
        currentSessionCount++;

        if (currentSessionCount > maxSessionCount) {
            maxSessionCount = currentSessionCount;
        }
        if (context == null) {
            storeInServletContext(event);
        }
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent event) {
            currentSessionCount--;
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent event) {

    }

    /**
     * The total number of sessions created.
     *
     * @return
     */
    public int getTotalSessionCount() {
        return (totalSessionCount);
    }

    /**
     * The number of sessions currently in memory.
     *
     * @return
     */
    public int getCurrentSessionCount() {
        return (currentSessionCount);
    }

    /**
     * The largest number of sessions ever in memory at any one time.
     *
     * @return
     */
    public int getMaxSessionCount() {
        return (maxSessionCount);
    }

    // Register self in the servlet context so that
    // servlets and JSP pages can access the session counts.
    private void storeInServletContext(HttpSessionEvent event) {
        HttpSession session = event.getSession();
        context = session.getServletContext();
        context.setAttribute("sessionCounter", this);

    }
}
