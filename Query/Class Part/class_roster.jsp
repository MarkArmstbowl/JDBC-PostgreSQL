<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CSE 132B Project</title>
    <script src="../../script.js"></script>

    <style>

        #displayss {
            width: 30%;
            margin-left: auto;
            margin-right: auto;
            margin-top: 3%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
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

    <table id="displayss">
        <tr id="main_row">
            <th style="width:11%;">Title</th>
            <th style="width:3%;">Quarter</th>
            <th style="width:3%">Year</th>
            <th style="background-color: orange; width:5%">Action</th>
        </tr>

        <form action="class_roster_list.jsp" method="get">
            <tr>
                <td><input name="title" placeholder="Ex: DB System..."></td>
                <td><input name="quarter" placeholder="Ex: SPRING.."></td>
                <td><input name="year" placeholder="Ex: 2018..."></td>
                <td><input type="submit" value="Search" name="action"></td>
            </tr>
        </form>

    </table>


        


    

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