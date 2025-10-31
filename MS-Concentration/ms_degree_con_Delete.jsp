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

            if (action != null && action.equals("delete")) {
                conn.setAutoCommit(false);

                PreparedStatement delete_stmt = conn.prepareStatement(
                "DELETE FROM Concentration_Courses WHERE Department = ? AND Concentration = ?");

                
                delete_stmt.setString(1, request.getParameter("delete_depart"));
                delete_stmt.setString(2, request.getParameter("delete_con"));
                
            
                delete_stmt.executeUpdate();
                delete_stmt.close();

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