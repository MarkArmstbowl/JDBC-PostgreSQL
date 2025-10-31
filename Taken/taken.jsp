<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CSE 132B Project</title>
    
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
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
    </style>
</head>




<body>
    <%-- Set the scripting language to java and --%>
    <%-- import the java.sql package --%>
    <%@ page language="java" import="java.sql.*" %>

    <jsp:include page="../index.html" />


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
            ResultSet rs = statement.executeQuery("SELECT * FROM TAKEN");
    %>

    <table>
        <tr id="main_row">
            <th>StudentID</th>
            <th>Course Number</th>
            <th>Section ID</th>
            <th>Term</th>
            <th>Year</th>
            <th>Grade Option</th>
            <th>Grade</th>
            <th>Unit</th>
            <th style="background-color: orange;">Action</th>
        </tr>





    <%-- 
        
        
        ================= Presentation Code Starts ===================== 
                            
                            
                            
    --%>

    <%
        //Iterate Over the ResultSet
        while(rs.next() ) {
    %>

    <tr>
        <form action="taken_Update.jsp" method="get">
            <%-- Get the CourseNumber, which is a string --%>
            <input type="hidden" value="update" name="action">
            <td><%= rs.getString("Student_ID") %></td>
            <input type="hidden" value="<%= rs.getString("Student_ID") %>" name="ID">

            <td><%= rs.getString("Course_Num") %></td>
            <input type="hidden" value="<%= rs.getString("Course_Num") %>" name="Number">

            <td><%= rs.getString("Section_ID") %></td>
            <input type="hidden" value="<%= rs.getString("Section_ID") %>" name="S_ID">

            <td><%= rs.getString("Term") %></td>
            <input type="hidden" value="<%= rs.getString("Term") %>" name="Term">

            <td><%= rs.getString("Year") %></td>
            <input type="hidden" value="<%= rs.getString("Year") %>" name="Year">

            <td><%= rs.getString("Grade_Option") %></td>
            <input type="hidden" value="<%= rs.getString("Grade_Option") %>" name="Grade_Option">

            <td><input value="<%= rs.getString("Grade") %>" name="Grade"></td>

            <td><%= rs.getString("Unit") %></td>
            <input type="hidden" value="<%= rs.getString("Unit") %>" name="Unit">


            <td><input type="submit" value="Update"></td>
        </form>
        
        <form action="taken_Delete.jsp" method="get">
            <input type="hidden" value="delete" name="action">
            <input type="hidden" value="<%= rs.getString("Student_ID") %>"
            name="deleteID">
            <input type="hidden" value="<%= rs.getString("Course_Num") %>"
            name="deleteNumber">
            <input type="hidden" value="<%= rs.getString("Section_ID") %>"
            name="deleteS_ID">
            <td><input id="delete_button" type="submit" value="Delete"></td>
        </form>

    </tr>

    <%
        }
    %>



    <%-- 
    
    
    =================== Presentation Code End ==============================



    --%>





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
