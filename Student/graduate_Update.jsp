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

        PreparedStatement delete_history = conn.prepareStatement(
                "DELETE FROM STUDENT_DEGREE_HISTORY WHERE Student_ID = ?");

        delete_history.setString(1, request.getParameter("hiddenID"));
                
        delete_history.executeUpdate();
        delete_history.close();

        PreparedStatement students = conn.prepareStatement(
        ("UPDATE STUDENT SET SSN = ?, First_Name = ?, Middle_Name = ?, Last_Name = ?, Enroll = ?, Res = ? WHERE Student_ID = ?"));

        PreparedStatement graduates = conn.prepareStatement(
        ("UPDATE STUDENT_GRADUATE SET Type_S = ?, Department = ? WHERE Student_ID = ?"));

        students.setString(1, request.getParameter("SSN"));
        students.setString(2, request.getParameter("First"));
        students.setString(3, request.getParameter("Middle"));
        students.setString(4, request.getParameter("Last"));
        students.setString(5, request.getParameter("Enroll"));
        students.setString(6, request.getParameter("Res"));
        students.setString(7, request.getParameter("hiddenID"));

        students.executeUpdate();
        students.close();

        if (request.getParameterValues("Degree") != null){
            PreparedStatement studentDH = conn.prepareStatement(
                ("INSERT INTO STUDENT_DEGREE_HISTORY VALUES (?, ?, ?)"));
        
            String[] histories = request.getParameterValues("Degree");

            for(int i = 0; i < histories.length; i++) {
                String[] elements = histories[i].split(",");
                studentDH.setString(1, request.getParameter("hiddenID"));
                studentDH.setString(2, elements[0].trim());
                studentDH.setString(3, elements[1].trim());
                studentDH.executeUpdate();
            }
            studentDH.close();
        }

        graduates.setString(1, request.getParameter("Type"));
        graduates.setString(2, request.getParameter("Department"));
        graduates.setString(3, request.getParameter("hiddenID"));
        graduates.executeUpdate();
        graduates.close();

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
    response.sendRedirect("graduate.jsp");
%>