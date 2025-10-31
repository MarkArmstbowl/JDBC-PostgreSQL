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
        PreparedStatement delete_major = conn.prepareStatement(
                "DELETE FROM STUDENT_UNDER_MAJOR WHERE Student_ID = ?");
        PreparedStatement delete_minor = conn.prepareStatement(
                "DELETE FROM STUDENT_UNDER_MINOR WHERE Student_ID = ?");

        delete_history.setString(1, request.getParameter("hiddenID"));
        delete_major.setString(1, request.getParameter("hiddenID"));
        delete_minor.setString(1, request.getParameter("hiddenID"));
        
        delete_history.executeUpdate();
        delete_major.executeUpdate();
        delete_minor.executeUpdate();
        
        delete_history.close();
        delete_major.close();
        delete_minor.close();

       
        PreparedStatement students = conn.prepareStatement(
        ("UPDATE STUDENT SET SSN = ?, First_Name = ?, Middle_Name = ?, Last_Name = ?, Enroll = ?, Res = ? WHERE Student_ID = ?"));

        PreparedStatement undergrads = conn.prepareStatement(
        ("UPDATE STUDENT_UNDERGRAD SET College = ? WHERE Student_ID = ?"));

        PreparedStatement majors = conn.prepareStatement(
        ("INSERT INTO STUDENT_UNDER_MAJOR VALUES (?, ?)"));

        PreparedStatement minors = conn.prepareStatement(
        ("INSERT INTO STUDENT_UNDER_MINOR VALUES (?, ?)"));

        students.setString(1, request.getParameter("SSN"));
        students.setString(2, request.getParameter("First"));
        students.setString(3, request.getParameter("Middle"));
        students.setString(4, request.getParameter("Last"));
        students.setString(5, request.getParameter("Enroll"));
        students.setString(6, request.getParameter("Res"));
        students.setString(7, request.getParameter("hiddenID"));

        students.executeUpdate();
        students.close();

        undergrads.setString(1, request.getParameter("College"));
        undergrads.setString(2, request.getParameter("hiddenID"));
        undergrads.executeUpdate();
        undergrads.close();

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
        
        String[] majorS = request.getParameterValues("Major");

        for(int i = 0; i < majorS.length; i++) {
            majors.setString(1, request.getParameter("hiddenID"));
            majors.setString(2, majorS[i]);
            majors.executeUpdate();
        }
        majors.close();

        String[] minorS = request.getParameterValues("Minor");

        for(int i = 0; i < minorS.length; i++) {
            minors.setString(1, request.getParameter("hiddenID"));
            minors.setString(2, minorS[i]);
            minors.executeUpdate();
        }
        minors.close();
        

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
    response.sendRedirect("undergrad.jsp");
%>