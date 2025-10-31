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
            ResultSet rs = statement.executeQuery("SELECT * FROM Probation");
    %>

    <table>
        <tr id="main_row">
            <th>StudentID</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Reason</th>
            <th style="background-color: orange;">Action</th>
        </tr>




        <%--

            =================== INSERTION PART =============================

        --%>

        <tr id="insert_row">
            <form action="probation_Insert.jsp" method="get">
            <input type="hidden" value="insert" name="action">
            <th><input value="" name="insertID" placeholder="Ex: A14823194..."></th>
            <th><input value="" name="insertStart" placeholder="Ex: Spring 2015..."></th>
            <th><input value="" name="insertEnd" placeholder="Ex: Spring 2016..."></th>
            <th><input value="" name="insertReason" placeholder="Ex: Reason1..."></th>
            <th><input type="submit" name="action" value="Insert" style="width: 60px;"></th>
            </form>
        </tr>



    <%-- 
        
        
        ================= Presentation Code Starts ===================== 
                            
                            
                            
    --%>

    <%
        //Iterate Over the ResultSet
        while(rs.next() ) {
    %>

    <tr>
        <form action="probation_Update.jsp" method="get">
            <%-- Get the CourseNumber, which is a string --%>
            <input type="hidden" value="update" name="action">
            <td><%= rs.getString("Student_ID") %></td>
            <input type="hidden" value="<%= rs.getString("Student_ID") %>" name="ID">

            <td><%= rs.getString("Start_date") %></td>
            <input type="hidden" value="<%= rs.getString("Start_date") %>" name="Start">

            <td><input value="<%= rs.getString("End_date") %>" name="End"></td>
            <td><input value="<%= rs.getString("Reason") %>" name="Reason"></td>


            <td><input type="submit" value="Update"></td>
        </form>
        
        <form action="probation_Delete.jsp" method="get">
            <input type="hidden" value="delete" name="action">
            <input type="hidden" value="<%= rs.getString("Student_ID") %>"
            name="deleteID">
            <input type="hidden" value="<%= rs.getString("Start_date") %>"
            name="deleteStart">
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
