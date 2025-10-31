<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CSE 132B Project</title>

    <script>
        function add_Professor() {
            let container = document.getElementById('professorSS');
            let newList = document.createElement('input');
            let newLane = document.createElement('br');
            container.appendChild(newLane);


            newList.name = 'prof_name';
            newList.placeholder = 'Ex: John Smith...';
            newList.value = '';

            container.appendChild(newList);
        }
    </script>
    
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
            ResultSet rs = statement.executeQuery("SELECT * FROM Student_Graduate WHERE Type_S = 'PhD Candidate'");
    %>

    <%--

    =========================================== INSERTION CODE STARTS ==============================================

    --%>
    <form action="thesis_Insert.jsp" method="get">
        <div id="insert-form">

            <p>Please Enter Student ID (Only PhD Candidate!) Information:</p>

            <table id="first_layer">
                <tr id="insert1" class="insertion">
                    <th>Student ID</th>
                </tr>
                <tr>
                    <th><input value="" name="student_ID" placeholder="Ex: A15030649..."></th>
                </tr>
            </table>

            <br>
            <p style="margin-bottom: 0px; padding-bottom: 0px; border-bottom: 0px;"> 
                Please Enter Professor Name:
            </p>

            <p style="color:FireBrick; font-family: Lucida Handwriting; background-color: lightblue; margin-top: 0px; margin-bottom: 0px; font-size: 20px;">
                 Professor Name
            </p>

            <div id="professorSS">
                <input value="" name="prof_name" placeholder="Ex: John Smith...">
            </div>

            <button type="button" onclick="add_Professor()">Add Professor</button>


        </div>
        <br>
        <input value="INSERT INTO DATABASE" type="submit" name="action">

    


    </form>

    <%--

    ============================================ INSERTION CODE ENDS ================================================

    --%>


    <%-- 
        
        
        ================= Presentation Code Starts ===================== 
                            
                            
                            
    --%>

    <table id="display">
        <tr id="main_row">
            <th>StudentID</th>
            <th>Professor Names</th>
            <th style="background-color: orange;">Action</th>
        </tr>






    <%
        //Iterate Over the ResultSet
        while(rs.next() ) {
    %>

    <tr>
        <form action="thesis_Update.jsp" method="get">
            <% String number = rs.getString("Student_ID"); %>
            <%
                String studentG = "SELECT * FROM COMMITTEE WHERE Student_ID = ?";
                PreparedStatement studentG_s = conn.prepareStatement(studentG);

                studentG_s.setString(1, number);
                ResultSet studentG_rs = studentG_s.executeQuery();
            %>

            <input type="hidden" value="update" name="action">

            <td><%= number %></td>
            <input type="hidden" value="<%= number %>" name="ID">

            <td>
            
                <input size="80" value="<% 
                    while(studentG_rs.next()) {
                %><%=studentG_rs.getString("Prof_Name") + ", "%><%
                    }
                %>" name="prof_Name">
            
            </td>

            <td><input type="submit" value="Update"></td>
        </form>
        
        <form action="thesis_Delete.jsp" method="get">
            <input type="hidden" value="delete" name="action">
            <input type="hidden" value="<%= rs.getString("Student_ID") %>"
            name="deleteID">
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
