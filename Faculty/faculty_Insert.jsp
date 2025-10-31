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

            if (action != null && action.equals("insert")) {
                conn.setAutoCommit(false);

                PreparedStatement fstmt = conn.prepareStatement(
                ("INSERT INTO FACULTY VALUES (?, ?, ?)"));

                
                fstmt.setString(1, request.getParameter("Name"));
                fstmt.setString(2, request.getParameter("Title"));
                fstmt.setString(3, request.getParameter("Department"));

                fstmt.executeUpdate();

                fstmt.close();

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
            response.sendRedirect("faculty.jsp");
        %>