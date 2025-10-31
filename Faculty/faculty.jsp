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
            ResultSet rs = statement.executeQuery("SELECT * FROM FACULTY");
    %>

    <table>
        <tr id="main_row">
            <th>Name</th>
            <th>Title</th>
            <th>Department</th>
            <th style="background-color: orange;">Action</th>
        </tr>




        <%--

            =================== INSERTION PART =============================

        --%>

        <tr id="insert_row">
            <form action="faculty_Insert.jsp" method="get">
            <input type="hidden" value="insert" name="action">
            <th><input value="" name="Name" placeholder="Ex: John..."></th>
            <th><input value="" name="Title" placeholder="Ex: Lecturer..."></th>
            <th><input value="" name="Department" placeholder="Ex: CSE..."></th>
            <th><input type="submit" name="action" value="Insert" style="width: 60px;"></th>
            </form>
        </tr>



    <%-- 
        
        
        ================= Presentation Code Starts ===================== 
                            
                            
                            
    --%>

    <%
        //Iterate Over the ResultSet
        while(rs.next() ) {
            String name = rs.getString("Name");
    %>

    <tr>
        <form action="faculty_Update.jsp" method="get">
            <%-- Get the CourseNumber, which is a string --%>
            <input type="hidden" value="update" name="action">
            <td><%= name %></td>
            <input type="hidden" value="<%= name %>" name="hiddenName">


            <%-- Get the Title --%>
            <td><input value="<%= rs.getString("Title") %>" name="Title"></td>

            <%-- Get the Department --%>
            <td><input value="<%= rs.getString("Department") %>" name="Department"></td>

            <td><input type="submit" value="Update"></td>
        </form>
        
        <form action="faculty_Delete.jsp" method="get">
            <input type="hidden" value="delete" name="action">
            <input type="hidden" value="<%= rs.getString("Name") %>"
            name="Name">
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
