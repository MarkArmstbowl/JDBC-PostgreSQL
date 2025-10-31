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

                PreparedStatement student = conn.prepareStatement(
                "DELETE FROM STUDENT WHERE Student_ID = ?");

                student.setString(1, request.getParameter("delete_num"));
                
                student.executeUpdate();
                student.close();

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
    response.sendRedirect("fiveyear.jsp");
%>