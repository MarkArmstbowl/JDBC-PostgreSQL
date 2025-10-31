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

            PreparedStatement offering = conn.prepareStatement(
                ("SELECT * FROM OFFERING WHERE Title = ? AND Term = ? AND Year_C = ?"));

            offering.setString(1, request.getParameter("title"));
            offering.setString(2, request.getParameter("quarter"));
            offering.setInt(3, Integer.parseInt(request.getParameter("year")));

            ResultSet offering_rs = offering.executeQuery();

            conn.commit();
            conn.setAutoCommit(true);

        

    %>

    <table id="displayss">
        <tr id="main_row">
            <th style="width:3%;">Section ID</th>
            <th style="width:3%;">Course</th>
            <th style="width:3%;">Quarter</th>
            <th style="width:3%;">Year</th>
            <th style="width:11%">Title</th>
            <th style="background-color: orange; width:5%;">Action</th>
        </tr>

        <%
            while(offering_rs.next() ) {
        %>

        <tr>
            <form action="class_roster_display.jsp" method="get">
                <td>
                    <%=offering_rs.getString("Section_ID") %>
                    <input name="sectionID" type="hidden" value="<%=offering_rs.getString("Section_ID") %>">
                </td>
                <td>
                    <%=offering_rs.getString("Course_ID") %>
                    <input name="courseID" type="hidden" value="<%=offering_rs.getString("Course_ID") %>">
                </td>
                <td>
                    <%=offering_rs.getString("Term") %>
                    <input name="term" type="hidden" value="<%=offering_rs.getString("Term") %>">
                </td>
                <td>
                    <%=offering_rs.getString("Year_C") %>
                    <input name="year" type="hidden" value="<%=offering_rs.getString("Year_C") %>">
                </td>
                <td>
                    <%=offering_rs.getString("Title") %>
                    <input name="title" type="hidden" value="<%=offering_rs.getString("Title") %>">
                </td>
                <td><input type="submit" value="Search" name="action">  </td>
            </form>

        </tr>

        <%
            }
        %>

    </table>


    
    <%
        offering.close();
        offering_rs.close();
        }
    %>


        


    

    <%-- Close Statement Code --%>
    <%
            // Close the ResultSet
            //student_rs.close();

            // Close the Statement
            //student.close();

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