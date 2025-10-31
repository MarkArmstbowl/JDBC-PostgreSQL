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

                PreparedStatement fstmt = conn.prepareStatement(
                ("INSERT INTO TAKEN VALUES (?, ?, ?, ?, ?, ?, ?, ?)"));

                
                fstmt.setString(1, request.getParameter("insert_student_ID"));
                fstmt.setString(2, request.getParameter("insert_courseID"));
                fstmt.setString(3, request.getParameter("insert_section"));
                fstmt.setString(4, request.getParameter("insert_term"));
                fstmt.setInt(5, Integer.parseInt(request.getParameter("insert_year")));
                fstmt.setString(6, request.getParameter("grade_Insert"));
                fstmt.setString(7, request.getParameter("insert_grade_option"));
                fstmt.setInt(8, Integer.parseInt(request.getParameter("insert_unit")));

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
            response.sendRedirect("taken.jsp");
        %>