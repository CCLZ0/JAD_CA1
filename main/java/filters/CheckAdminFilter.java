package filters;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import models.User;

@WebFilter("/admin/*")
public class CheckAdminFilter implements Filter {

    public void init(FilterConfig fConfig) throws ServletException {
        // Initialization code, if needed
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession();
        User user = (User) session.getAttribute("user");

        // Log the user object
        System.out.println("CheckAdminFilter: user = " + user);

        if (user == null) {
            // Redirect to login if the user is not logged in
            System.out.println("CheckAdminFilter: User is not logged in. Redirecting to login page.");
            httpResponse.getWriter().println("<script>alert('You need to log in first!'); window.location='../login/login.jsp';</script>");
            return;
        }

        // Check if the user is an admin
        boolean isAdmin = "admin".equals(user.getRole());
        System.out.println("CheckAdminFilter: isAdmin = " + isAdmin);
        if (!isAdmin) {
            System.out.println("CheckAdminFilter: User is not an admin. Redirecting to user index page.");
            httpResponse.getWriter().println("<script>alert('You do not have permission to access the admin dashboard.'); window.location='../user/index.jsp';</script>");
            return;
        }

        // If the user is an admin, proceed with the request
        System.out.println("CheckAdminFilter: User is an admin. Proceeding with the request.");
        chain.doFilter(request, response);
    }

    public void destroy() {
        // Cleanup code, if needed
    }
}