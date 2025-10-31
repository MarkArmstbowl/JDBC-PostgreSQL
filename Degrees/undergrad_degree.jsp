<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CSE 132B Project</title>
    <script>
        function add_Degree() {
            let container = document.getElementById('degree_undergrad');
            let newList = document.createElement('tr');

            newList.innerHTML = `
                    <th><input value="" name="department" placeholder="Ex: CSE..."></th>
                    <th><input value="" name="ldr" placeholder="Ex: 80..."></th>
                    <th><input value="" name="udr" placeholder="Ex: 75..."></th>
                    <th><input value="" name="edr" placeholder="Ex: 70..."></th>
                    <th><input value="" name="major" placeholder="Ex: 3.0..."></th>
                    <th><input value="" name="overall" placeholder="Ex: 2.0..."></th>
            `;

            container.appendChild(newList);
        }
    </script>
    
    <style>
        #display {
            border-collapse: collapse;
            width: 90%;
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
        #show td{
            text-align: center;
        }
    </style>
</head>




<body>
    <%-- Set the scripting language to java and --%>
    <%-- import the java.sql package --%>
    <%@ page language="java" import="java.sql.*" %>

    <jsp:include page="degree_sum.jsp"/>

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
            ResultSet rs = statement.executeQuery("SELECT * FROM Undergrad_Degree");
    %>


    <%--

    =========================================== INSERTION CODE STARTS ==============================================

    --%>


    <form action="undergrad_degree_Insert.jsp" method="get">
        <div id="insert-form">
            <p>Please Enter Bachelor Degree Information:</p>

            <table id="degree_undergrad">
                <tr id="insert1" class="insertion">
                    <th>Department</th>
                    <th>Lower Devision Units Requirement</th>
                    <th>Upper Devision Units Requirement</th>
                    <th>Elective Units Requirement</th>
                    <th>Minimum Major GPA Requirement</th>
                    <th>Minimum Overall GPA Requirement</th>
                </tr>
                <tr>
                    <th><input value="" name="department" placeholder="Ex: CSE..."></th>
                    <th><input value="" name="ldr" placeholder="Ex: 80..."></th>
                    <th><input value="" name="udr" placeholder="Ex: 75..."></th>
                    <th><input value="" name="edr" placeholder="Ex: 70..."></th>
                    <th><input value="" name="major" placeholder="Ex: 3.0..."></th>
                    <th><input value="" name="overall" placeholder="Ex: 2.0..."></th>
                </tr>
            </table>

            <button type="button"  onclick="add_Degree()">Add Bachelor Degree</button>
        </div>

        <br>
        <input value="INSERT INTO DATABASE" type="submit" name="action">

        
    </form>


    <%--

    =========================================== INSERTION CODE ENDS ==============================================

    --%>

    <table id="display">
        <tr id="main_row">
            <th>Department</th>
            <th>Lower Devision Units Requirement</th>
            <th>Upper Devision Units Requirement</th>
            <th>Elective Units Requirement</th>
            <th>Minimum Major GPA Requirement</th>
            <th>Minimum Overall GPA Requirement</th>
            
            <th style="background-color: orange;">Action</th>
        </tr>

        <%-- 
        
        
        ======================================== Presentation Code Starts ============================================ 
                            
                            
                            
        --%>

        <%
            //Iterate Over the ResultSet
            while(rs.next() ) {
        %>

        <tr id="show">
            <form action="undergrad_degree_Update.jsp" method="get">
            <input type="hidden" value="update" name="action">
            

            <td><%= rs.getString("Department") %></td>
            <input type="hidden" value="<%= rs.getString("Department") %>" name="Depart">

            <td><input value="<%=rs.getString("LowerD")%>" name="LowerD"></td>
            <td><input value="<%=rs.getString("UpperD")%>" name="UpperD"></td>
            <td><input value="<%=rs.getString("ElectiveD")%>" name="ElectiveD"></td>
            <td><input value="<%=rs.getString("MajorGPA")%>" name="Major"></td>
            <td><input value="<%=rs.getString("OverallGPA")%>" name="Overall"></td>

            <td><input type="submit" value="Update"></td>
        </form>

            


            <%--

            =========================================== DELETION CODE STARTS ==============================================

            --%>



            <form action="undergrad_degree_Delete.jsp" method="get">
                <input type="hidden" value="delete" name="action">
                <input type="hidden" value="<%=rs.getString("Department")%>" name="delete_depart">
                <td><input id="delete_button" type="submit" value="Delete"></td>
            </form>


            <%--

            =========================================== DELETION CODE ENDS ==============================================

            --%>


        </tr>


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