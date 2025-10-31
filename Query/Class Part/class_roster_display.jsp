<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CSE 132B Project</title>
    <script src="../../script.js"></script>

    <style>

        #displayss {
            margin-left: auto;
            margin-right: auto;
            margin-top: 3%;
            width: 50%;
            border-collapse: collapse;
        }

        #displayss td {
            font-size: 12px;
            font-weight: normal;
            font-family: Helvetica;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }

        #search {
            border: none;
        }

        #main_row th {
            background-color: yellow;
            font-size: 0.7rem;
        }

        #show td{
            text-align: center;
        }


    </style>

    
</head>




<body>

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

    <jsp:include page="../../index.html" />

    <%
        String action = request.getParameter("action");

        if (action != null && action.equals("Search")) {
            conn.setAutoCommit(false);

            boolean isCurrent = false;
            String students = "";

            if (request.getParameter("term").equals("SPRING") && request.getParameter("year").equals("2018")){
                isCurrent = true;
            }

            if (isCurrent == true){
                students = "SELECT * FROM STUDENT WHERE Student_ID IN " +
                "(SELECT Student_ID FROM ENROLL WHERE Section_ID = ?)";
            } else{
                students = "SELECT * FROM STUDENT WHERE Student_ID IN " +
                "(SELECT Student_ID FROM TAKEN WHERE Section_ID = ?)";
            }

            PreparedStatement student_display = conn.prepareStatement(students);

            student_display.setString(1, request.getParameter("sectionID"));

            ResultSet student_display_rs = student_display.executeQuery();

            conn.commit();
            conn.setAutoCommit(true);

            String course = request.getParameter("courseID");
            String term   = request.getParameter("term");
            String year   = request.getParameter("year");
            String title   = request.getParameter("title");
            String section = request.getParameter("sectionID");
    %>
    <p style="text-align: center;">Students Who Takes <%=course%> <%=title%> Section <%=section%> in <%=term + " " + year%></p>

    <table id="displayss">
        <tr id="main_row">
            <th style="width:10%;">Student ID</th>
            <th style="width:10%;">SSN</th>
            <th style="width:10%;">First Name</th>
            <th style="width:10%;">Middle Name</th>
            <th style="width:10%">Last Name</th>
            <th style="width:10%">Enroll Stats</th>
            <th style="width:10%">Residential Stats</th>
            <th style="width: 5%;">Unit Option</th>
            <th style="width: 5%;">Grade Option</th>

        </tr>

        <%
            while(student_display_rs.next() ) {
        %>

        <tr>
            <td><%=student_display_rs.getString("Student_ID")%></td>
            <td><%=student_display_rs.getString("SSN")%></td>
            <td><%=student_display_rs.getString("First_Name")%></td>
            <td><%=student_display_rs.getString("Middle_Name")%></td>
            <td><%=student_display_rs.getString("Last_Name")%></td>
            <td><%=student_display_rs.getString("Enroll")%></td>
            <td><%=student_display_rs.getString("Res")%></td>
            <%
                String unit_option_str = "";
                if (isCurrent == true){
                    unit_option_str = "SELECT Unit, Grade_Option FROM ENROLL WHERE Section_ID = ? AND Student_ID = ?";
                } else{
                    unit_option_str = "SELECT Unit, Grade_Option FROM TAKEN WHERE Section_ID = ? AND Student_ID = ?";
                }

                PreparedStatement units_options = conn.prepareStatement(unit_option_str);

                units_options.setString(1, request.getParameter("sectionID"));
                units_options.setString(2, student_display_rs.getString("Student_ID"));

                ResultSet units_rs = units_options.executeQuery();
                if(units_rs.next()) {
            %>
            
                <td><%=units_rs.getString("Unit")%></td>
                <td><%=units_rs.getString("Grade_Option")%></td>

            <%}%>

        </tr>

        <%
            units_options.close();
            units_rs.close();
            }
        %>

    </table>


    
    <%
        student_display.close();
        student_display_rs.close();
        }
    %>


        


    

    <%-- Close Statement Code --%>
    <%
            // Close the ResultSet
            //student_display_rs.close();

            // Close the Statement
            //student_display.close();

            // Close the Connection
            conn.close();

        } catch (SQLException sqle) {
            out.println(sqle.getMessage());
            } catch (Exception e) {
            out.println(e.getMessage());
            }
    %>

</body>
</html>