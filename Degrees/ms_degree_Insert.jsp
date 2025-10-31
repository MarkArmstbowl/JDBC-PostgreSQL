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
        ("INSERT INTO MS_Degree VALUES (?, ?, ?, ?, ?, ?, ?)"));

        String[] depart = request.getParameterValues("department");
        String[] concentration = request.getParameterValues("concentration");
        String[] low_unit_s = request.getParameterValues("lowUnit");
        String[] up_unit_s = request.getParameterValues("upUnit");
        String[] elec_unit_s = request.getParameterValues("elecUnit");
        String[] con_unit_s = request.getParameterValues("conUnit");
        String[] gpa_s = request.getParameterValues("gpa");

        int[] low_unit = new int[low_unit_s.length];
        int[] up_unit = new int[up_unit_s.length];
        int[] elec_unit = new int[elec_unit_s.length];
        int[] con_unit = new int[con_unit_s.length];
        float[] gpa = new float[gpa_s.length];

        for (int i = 0; i < low_unit_s.length; i++) {
            low_unit[i] = Integer.parseInt(low_unit_s[i].trim());
        }
        for (int i = 0; i < up_unit_s.length; i++) {
            up_unit[i] = Integer.parseInt(up_unit_s[i].trim());
        }
        for (int i = 0; i < elec_unit_s.length; i++) {
            elec_unit[i] = Integer.parseInt(elec_unit_s[i].trim());
        }
        for (int i = 0; i < con_unit_s.length; i++) {
            con_unit[i] = Integer.parseInt(con_unit_s[i].trim());
        }
        for (int i = 0; i < gpa_s.length; i++) {
            gpa[i] = Float.parseFloat(gpa_s[i].trim());
        }

        for(int i = 0; i < depart.length; i++) {
            degrees.setString(1, depart[i]);
            degrees.setString(2, concentration[i]);
            degrees.setInt(3, low_unit[i]);
            degrees.setInt(4, up_unit[i]);
            degrees.setInt(5, elec_unit[i]);
            degrees.setInt(6, con_unit[i]);
            degrees.setFloat(7, gpa[i]);
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
    response.sendRedirect("ms_degree.jsp");
%>