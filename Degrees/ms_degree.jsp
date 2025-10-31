<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CSE 132B Project</title>
    <script>
        function add_Degree() {
            let container = document.getElementById('ms_degree');
            let newList = document.createElement('tr');

            newList.innerHTML = `
                    <th><input value="" name="department" placeholder="Ex: CSE..."></th>
                    <th><input value="" name="concentration" placeholder="Ex: Database..."></th>
                    <th><input value="" name="lowUnit" placeholder="Ex: 30..."></th>
                    <th><input value="" name="upUnit" placeholder="Ex: 40..."></th>
                    <th><input value="" name="elecUnit" placeholder="Ex: 50..."></th>
                    <th><input value="" name="conUnit" placeholder="Ex: 20..."></th>
                    <th><input value="" name="gpa" placeholder="Ex: 3.0..."></th>
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
            ResultSet rs = statement.executeQuery("SELECT * FROM MS_Degree");
    %>

    


    <%--

    =========================================== INSERTION CODE STARTS ==============================================

    --%>


    <form action="ms_degree_Insert.jsp" method="get">
        <div id="insert-form">
            <p>Please Enter MS Degree Information:</p>

            <table id="ms_degree">
                <tr id="insert1" class="insertion">
                    <th>Department</th>
                    <th>Concentration</th>
                    <th>Lower Division Units Requirement</th>
                    <th>Upper Division Units Requirement</th>
                    <th>Technical Elective Units Requirement</th>
                    <th>Concentration Units Requirement</th>
                    <th>Minimum GPA Requirement</th>
                </tr>
                <tr>
                    <th><input value="" name="department" placeholder="Ex: CSE..."></th>
                    <th><input value="" name="concentration" placeholder="Ex: Database..."></th>
                    <th><input value="" name="lowUnit" placeholder="Ex: 30..."></th>
                    <th><input value="" name="upUnit" placeholder="Ex: 40..."></th>
                    <th><input value="" name="elecUnit" placeholder="Ex: 50..."></th>
                    <th><input value="" name="conUnit" placeholder="Ex: 20..."></th>
                    <th><input value="" name="gpa" placeholder="Ex: 3.0..."></th>
                </tr>
            </table>

            <button type="button"  onclick="add_Degree()">Add MS Degree</button>
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
            <th>Concentration</th>
            <th>Lower Division Units Requirement</th>
            <th>Upper Division Units Requirement</th>
            <th>Technical Elective Units Requirement</th>
            <th>Concentration Units Requirement</th>
            <th>Minimum GPA Requirement</th>
            
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
            <form action="ms_degree_Update.jsp" method="get">
            <input type="hidden" value="update" name="action">
            
            <td><%= rs.getString("Department") %></td>
            <input type="hidden" value="<%= rs.getString("Department") %>" name="Department">

            <td><%= rs.getString("Concentration") %></td>
            <input type="hidden" value="<%= rs.getString("Concentration") %>" name="Concentration">

            <td><input value="<%=rs.getString("LowerD")%>" name="lowerD"></td>
            <td><input value="<%=rs.getString("UpperD")%>" name="upperD"></td>
            <td><input value="<%=rs.getString("ElectiveD")%>" name="electiveD"></td>
            <td><input value="<%=rs.getString("ConUnits")%>" name="con"></td>
            <td><input value="<%=rs.getString("GPA")%>" name="GPA"></td>

            <td><input type="submit" value="Update"></td>
        </form>

            


            <%--

            =========================================== DELETION CODE STARTS ==============================================

            --%>



            <form action="ms_degree_Delete.jsp" method="get">
                <input type="hidden" value="delete" name="action">
                <input type="hidden" value="<%=rs.getString("Department")%>" name="delete_depart">
                <input type="hidden" value="<%=rs.getString("Concentration")%>" name="delete_con">
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