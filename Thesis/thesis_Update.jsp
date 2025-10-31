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

                PreparedStatement delete_stmt = conn.prepareStatement(
                "DELETE FROM Committee WHERE Student_ID = ?");

                delete_stmt.setString(1, request.getParameter("ID"));
                delete_stmt.executeUpdate();
                delete_stmt.close();

                PreparedStatement pstmt = conn.prepareStatement(("INSERT INTO Committee VALUES (?, ?)"));
    
                String professor_Array = request.getParameter("prof_Name");

                String[] professor = professor_Array.split(",");
                
                for (String unit : professor) {
                    pstmt.setString(1, request.getParameter("ID"));
                    pstmt.setString(2, unit.trim());
                    pstmt.executeUpdate();
                }
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
            response.sendRedirect("thesis.jsp");
        %>