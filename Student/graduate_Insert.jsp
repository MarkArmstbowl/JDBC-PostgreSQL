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

        PreparedStatement students = conn.prepareStatement(
        ("INSERT INTO STUDENT VALUES (?, ?, ?, ?, ?, ?, ?)"));

        PreparedStatement studentDH = conn.prepareStatement(
        ("INSERT INTO STUDENT_DEGREE_HISTORY VALUES (?, ?, ?)"));

        PreparedStatement graduate = conn.prepareStatement(
        ("INSERT INTO STUDENT_GRADUATE VALUES (?, ?, ?)"));

        students.setString(1, request.getParameter("student_ID"));
        students.setString(2, request.getParameter("ssn"));
        students.setString(3, request.getParameter("firstn"));
        students.setString(4, request.getParameter("middlen"));
        students.setString(5, request.getParameter("lastn"));
        students.setString(6, request.getParameter("enrollS"));
        students.setString(7, request.getParameter("resS"));

        students.executeUpdate();
        students.close();



        String[] universityName = request.getParameterValues("university");
        String[] degreeName = request.getParameterValues("degreeName");

        for(int i = 0; i < universityName.length; i++) {
            if (universityName[i].length() > 0 && degreeName[i].length() > 0){
                studentDH.setString(1, request.getParameter("student_ID"));
                studentDH.setString(2, universityName[i]);
                studentDH.setString(3, degreeName[i]);
                studentDH.executeUpdate();
            }
        }
        studentDH.close();

        graduate.setString(1, request.getParameter("student_ID"));
        graduate.setString(2, request.getParameter("type"));
        graduate.setString(3, request.getParameter("department"));
        graduate.executeUpdate();
        graduate.close();


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