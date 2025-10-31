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

        PreparedStatement stmt = conn.prepareStatement(
        ("UPDATE UnderGrad_Degree SET LowerD = ?, UpperD = ?, ElectiveD = ?, MajorGPA = ?, OverallGPA = ? WHERE Department = ?"));

        stmt.setInt(1, Integer.parseInt(request.getParameter("LowerD").trim()));
        stmt.setInt(2, Integer.parseInt(request.getParameter("UpperD").trim()));
        stmt.setInt(3, Integer.parseInt(request.getParameter("ElectiveD").trim()));
        stmt.setFloat(4, Float.parseFloat(request.getParameter("Major").trim()));
        stmt.setFloat(5, Float.parseFloat(request.getParameter("Overall").trim()));
        stmt.setString(6, request.getParameter("Depart"));
        stmt.executeUpdate();
        stmt.close();
        
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
    response.sendRedirect("undergrad_degree.jsp");
%>