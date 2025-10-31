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

        PreparedStatement degrees = conn.prepareStatement(
        ("INSERT INTO UnderGrad_Degree VALUES (?, ?, ?, ?, ?, ?)"));

        String[] depart = request.getParameterValues("department");
        String[] ldr_s = request.getParameterValues("ldr");
        String[] udr_s = request.getParameterValues("udr");
        String[] edr_s = request.getParameterValues("edr");
        String[] major_s = request.getParameterValues("major");
        String[] overall_s = request.getParameterValues("overall");

        int[] ldr = new int[ldr_s.length];
        int[] udr = new int[udr_s.length];
        int[] edr = new int[edr_s.length];
        float[] major = new float[major_s.length];
        float[] overall = new float[overall_s.length];

        for (int i = 0; i < ldr_s.length; i++) {
            ldr[i] = Integer.parseInt(ldr_s[i].trim());
        }
        for (int i = 0; i < udr_s.length; i++) {
            udr[i] = Integer.parseInt(udr_s[i].trim());
        }
        for (int i = 0; i < edr_s.length; i++) {
            edr[i] = Integer.parseInt(edr_s[i].trim());
        }
        for (int i = 0; i < major_s.length; i++) {
            major[i] = Float.parseFloat(major_s[i].trim());
        }
        for (int i = 0; i < overall_s.length; i++) {
            overall[i] = Float.parseFloat(overall_s[i].trim());
        }

        for(int i = 0; i < depart.length; i++) {
            degrees.setString(1, depart[i]);
            degrees.setInt(2, ldr[i]);
            degrees.setInt(3, udr[i]);
            degrees.setInt(4, edr[i]);
            degrees.setFloat(5, major[i]);
            degrees.setFloat(6, overall[i]);
            degrees.executeUpdate();
        }
        degrees.close();




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