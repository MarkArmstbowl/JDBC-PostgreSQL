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

                PreparedStatement pstmt = conn.prepareStatement(
                ("INSERT INTO PROBATION VALUES (?, ?, ?, ?)"));

                
                pstmt.setString(1, request.getParameter("insertID"));
                pstmt.setString(2, request.getParameter("insertStart"));
                pstmt.setString(3, request.getParameter("insertEnd"));
                pstmt.setString(4, request.getParameter("insertReason"));

                pstmt.executeUpdate();
                pstmt.close();

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