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

                String ID = request.getParameter("student_ID");

                String s = "SELECT * FROM STUDENT_GRADUATE WHERE Student_ID = ? AND Type_S = ?";
                PreparedStatement check_s = conn.prepareStatement(s);

                check_s.setString(1, ID);
                check_s.setString(2, "PhD Candidate");
                ResultSet check_rs = check_s.executeQuery();

                if (check_rs.next()){

                    PreparedStatement pstmt = conn.prepareStatement(
                    ("INSERT INTO Committee VALUES (?, ?)"));

                    String[] professor_Array = request.getParameterValues("prof_name");

                    for(int i = 0; i < professor_Array.length; i++) {
                        pstmt.setString(1, ID);
                        pstmt.setString(2, professor_Array[i]);
                        pstmt.executeUpdate();
                    }
                    pstmt.close();
                }
                check_s.close();
                check_rs.close();

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