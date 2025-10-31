<%-- Set the scripting language to java and --%>
<%-- import the java.sql package --%>
<%@ page language="java" import="java.sql.*" %>

<%-- Connectivity Code --%> 
<%
    try {
        // Load PostGres Driver class file
        Class.forName("org.postgresql.Driver");

        // Make a connection to the Postgres datasource
        Connection conn = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5432/cse132b",
            "postgres", "HXN06MONKEY"
        );
%>

<%
    String action = request.getParameter("action");

    if (action != null && action.equals("INSERT INTO DATABASE")) {
        conn.setAutoCommit(false);

        PreparedStatement stmt = conn.prepareStatement(
        ("INSERT INTO Concentration_Courses VALUES (?, ?, ?)"));

        String courses = request.getParameter("courses");
        String[] course = courses.split(",");
        
        for (String unit : course) {
            stmt.setString(1, request.getParameter("department"));
            stmt.setString(2, request.getParameter("concentration"));
            stmt.setString(3, unit.trim());
            stmt.executeUpdate();
        }
        stmt.close();


        
        conn.commit();
        conn.setAutoCommit(true);
    }    
%>



        <%-- Close Statement Code --%>
        <%
                // Close the ResultSet
                //rs.close();
    
                // Close the Statement
                //statement.close();
    
                // Close the Connection
                conn.close();
    
            } catch (SQLException sqle) {
                out.println(sqle.getMessage());
                } catch (Exception e) {
                out.println(e.getMessage());
                }
            response.sendRedirect("ms_degree_con.jsp");
        %>