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
                "UPDATE enroll SET UNIT = ?, Grade_Option = ? WHERE Student_ID = ? AND Course_Num = ? AND Section_ID = ?");

                update_stmt.setInt(1, Integer.parseInt(request.getParameter("Unit").trim()));
                update_stmt.setString(2, request.getParameter("Grade_Option"));
                update_stmt.setString(3, request.getParameter("ID"));
                update_stmt.setString(4, request.getParameter("Number"));
                update_stmt.setString(5, request.getParameter("S_ID"));
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
            response.sendRedirect("enroll.jsp");
        %>