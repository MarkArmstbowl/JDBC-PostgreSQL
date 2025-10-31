<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CSE 132B Project</title>
    
    
    <style>
        #display {
            border-collapse: collapse;
            margin: 0 auto;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }

        #main_row th {
            background-color: yellow;
        }

        #insert_row th{
            border: none;
        }
        
        #delete_button:hover {
            background-color: red;
        }
     
        .insertion {
            background-color: lightblue;
            font-size: 12px; 
            height:15px;
        }
        .insertion th{
            padding: 5px;
        }

        #first_layer th{
            padding: 5px;
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

    <jsp:include page="../index.html"/>

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

    <%-- Create Statement Code --%>
    <%
            // Create the statement
            Statement statement = conn.createStatement();

            // Use the statement to SELECT the Course attributes
            // FROM the Course table.
            ResultSet rs = statement.executeQuery("SELECT DISTINCT Course_ID, Term, Year_C, Title FROM OFFERING WHERE Term = 'SPRING' AND Year_C = 2018");
    %>


    


    <table id="display">
        <tr id="main_row">
            <th>Course</th>
            <th>Term</th>
            <th>Year</th>
            <th>Title</th>
            <th style="background-color: orange;">Action</th>
        </tr>

        <%-- 
        
        
        ======================================== Presentation Code Starts ============================================ 
                            
                            
                            
        --%>

        <%
            //Iterate Over the ResultSet
            while(rs.next() ) {
        %>

        <form action="enroll_form.jsp" method="get">
            <tr id="show">
                <td><%= rs.getString("Course_ID") %></td>
                <input type="hidden" value="<%= rs.getString("Course_ID") %>" name="courseIDCL">
                <td><%= rs.getString("Term") %></td>
                <input type="hidden" value="<%= rs.getString("Term") %>" name="termCL">
                <td><%= rs.getString("Year_C") %></td>
                <input type="hidden" value="<%= rs.getString("Year_C") %>" name="yearCL">
                <td><%= rs.getString("Title") %></td>
                <input type="hidden" value="<%= rs.getString("Title") %>" name="title">
                <td><input type="submit" value="Take"></td>
            </tr>
        </form>


        <%-- 
        
        
        ======================================== Presentation Code Ends ============================================ 
                            
                            
                            
        --%>


        <%
            }
        %>

    </table>


    <%-- Close Statement Code --%>
    <%     
            // Close the ResultSet
            rs.close();

            // Close the Statement
            statement.close();

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