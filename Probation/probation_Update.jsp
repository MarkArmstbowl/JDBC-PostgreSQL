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

            if (action != null && action.equals("update")) {
                conn.setAutoCommit(false);

                PreparedStatement update_stmt = conn.prepareStatement(
                "UPDATE PROBATION SET End_date = ?, Reason = ? WHERE Student_ID = ? AND Start_date = ?");

                update_stmt.setString(1, request.getParameter("End"));
                update_stmt.setString(2, request.getParameter("Reason"));
                update_stmt.setString(3, request.getParameter("ID"));
                update_stmt.setString(4, request.getParameter("Start"));
                update_stmt.executeUpdate();

                update_stmt.close();

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
            response.sendRedirect("probation.jsp");
        %>