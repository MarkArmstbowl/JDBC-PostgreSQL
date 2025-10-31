<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CSE 132B Project</title>
    
    <script>
        function add_Major() {
            let container = document.getElementById('majorSS');
            let newList = document.createElement('input');

            newList.name = 'majorS';
            newList.placeholder = 'Ex: Computer Science...';
            newList.value = '';
            newList.style.marginRight = '5px';

            container.appendChild(newList);
        }
        function add_Minor() {
            let container = document.getElementById('minorSS');
            let newList = document.createElement('input');

            newList.name = 'minorS';
            newList.placeholder = 'Ex: Economic...';
            newList.value = '';
            newList.style.marginRight = '5px';

            container.appendChild(newList);
        }
        function add_Degree() {
            let container = document.getElementById('degree-for-student');
            let newList = document.createElement('tr');

            newList.innerHTML = `
                <th><input value="" name="university" placeholder="Ex: UC Berkely..."></th>
                <th><input value="" name="degreeName" placeholder="Ex: CSE Bachelor..."></th>
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

    <jsp:include page="students.jsp"/>


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
            ResultSet rs = statement.executeQuery("select Student_ID from Student_Graduate where Type_S = '5 Year Undergrad/MS';");
    %>

    <%--

    =========================================== INSERTION CODE STARTS ==============================================

    --%>
    <form action="fiveyear_Insert.jsp" method="get">
        <div id="insert-form">

            <p>Please Enter Basic Information:</p>

            <table id="first_layer">
                <tr id="insert1" class="insertion">
                    <th>Student ID</th>
                    <th>SSN</th>
                    <th>Type</th>
                    <th>Department</th>
                    <th>First Name</th>
                    <th>Middle Name</th>
                    <th>Last Name</th>
                    <th>College</th>
                    <th>Enroll Status</th>
                    <th>Residency Status</th>
                </tr>
                <tr>
                    <th><input value="" name="student_ID" placeholder="Ex: A15030649..."></th>
                    <th><input value="" name="ssn" placeholder="Ex: 502894271..."></th>
                    <th style="font-size: 13px; padding: 8px;">
                        5 Year Undergrad/MS<input type="hidden" value="5 Year Undergrad/MS" name="type" placeholder="Ex: MS...">
                    </th>
                    <th><input value="" name="department" placeholder="Ex: CSE..."></th>
                    <th><input value="" name="firstn" placeholder="Ex: John..."></th>
                    <th><input value="" name="middlen" placeholder="Ex: Mike..."></th>
                    <th><input value="" name="lastn" placeholder="Ex: Smith..."></th>
                    <th><input value="" name="college" placeholder="Ex: Sixth..."></th>
                    <th><input value="" name="enrollS" placeholder="Ex: Enrolled..."></th>
                    <th><input value="" name="resS" placeholder="Ex: California Resident..."></th>
                </tr>
            </table>

            <br>
            <p style="margin-bottom: 0px; padding-bottom: 0px; border-bottom: 0px;"> 
                Please Major/Minor Information:
            </p>

            <p style="color:FireBrick; font-family: Lucida Handwriting; background-color: lightblue; margin-top: 0px; margin-bottom: 0px; font-size: 20px;">
                 Major 
            </p>

            <div id="majorSS">
                <input value="" name="majorS" placeholder="Ex: Computer Science...">
            </div>

            <button type="button" onclick="add_Major()">Add Major</button>

            <br><br>

            <p style="color:DarkSlateGray; font-family: Lucida Handwriting; background-color: lightblue; margin-top: 0px; margin-bottom: 0px; font-size: 20px;">
                Minor 
           </p>

           <div id="minorSS">
               <input value="" name="minorS" placeholder="Ex: Enconomic...">
           </div>

           <button type="button" onclick="add_Minor()">Add Minor</button>

           <br>

           <p> Please Enter Degree History:</p>

            <table id="degree-for-student">
                <tr id="insert3" class="insertion">
                    <th>University</th>
                    <th>Degree Name</th>
                </tr>
                <tr>
                    <th><input value="" name="university" placeholder="Ex: UC Berkely"></th>
                    <th><input value="" name="degreeName" placeholder="Ex: CSE Bachelor..."></th>
                </tr>
            </table> 
            <button type="button"  onclick="add_Degree()">Add Degree</button>


        </div>
        <br>
        <input value="INSERT INTO DATABASE" type="submit" name="action">

    


    </form>

    <%--

    ============================================ INSERTION CODE ENDS ================================================

    --%>



    <table id="display">
        <tr id="main_row">
            <th style="width: 8%;">Student ID</th>
            <th>SSN</th>
            <th>Type</th>
            <th>Department</th>
            <th>First Name</th>
            <th>Middle Name</th>
            <th>Last Name</th>
            <th>College</th>
            <th>Major</th>
            <th>Minor</th>
            <th>Degree History</th>
            <th>Enroll Status</th>
            <th>Res Status</th>
            <th style="background-color: orange;">Action</th>
        </tr>

        <%-- 
        
        
        ======================================== Presentation Code Starts ============================================ 
                            
                            
                            
        --%>

        <%
            //Iterate Over the ResultSet
            while(rs.next() ) {
                String number = rs.getString("Student_ID");
        %>
        <tr id="show">
            <form action="fiveyear_Update.jsp" method="get">
            <input type="hidden" value="update" name="action">
            <td><%= number %></td>
            <input type="hidden" value="<%= number %>" name="hiddenID">

            <%
                String studentG = "SELECT * FROM STUDENT WHERE Student_ID = ?";
                PreparedStatement studentG_s = conn.prepareStatement(studentG);

                studentG_s.setString(1, number);
                ResultSet studentG_rs = studentG_s.executeQuery();
                studentG_rs.next();
            %>

            <td><input size="8" value="<%=studentG_rs.getString("SSN")%>" name="SSN"></td>

            <%
                String type = "SELECT * FROM STUDENT_GRADUATE WHERE Student_ID = ?";
                PreparedStatement type_s = conn.prepareStatement(type);

                type_s.setString(1, number);
                ResultSet type_rs = type_s.executeQuery();
            %>
            <td>
                <% while(type_rs.next()) { %>
                    <%= type_rs.getString("Type_S") %>
                    <input type="hidden" value="<%= type_rs.getString("Type_S") %>" name="Type"><br>
                <% } %>
            </td>

            <%
                type_s.close();
                type_rs.close();
            %>


            <%
                String departG = "SELECT * FROM STUDENT_GRADUATE WHERE Student_ID = ?";
                PreparedStatement departG_s = conn.prepareStatement(departG);

                departG_s.setString(1, number);
                ResultSet departG_rs = departG_s.executeQuery();
            %>
            <td>
                <% while(departG_rs.next()) { %>
                    <input size="10" value="<%= departG_rs.getString("Department") %>" name="Department"><br>
                <% } %>
            </td>

            <%
                departG_s.close();
                departG_rs.close();
            %>


            <td><input size="7" value="<%=studentG_rs.getString("First_Name")%>" name="First"></td>
            <td><input size="7" value="<%=studentG_rs.getString("Middle_Name")%>" name="Middle"></td>
            <td><input size="7" value="<%=studentG_rs.getString("Last_Name")%>" name="Last"></td>

            <%
                String college = "SELECT * FROM STUDENT_UNDERGRAD WHERE Student_ID = ?";
                PreparedStatement college_s = conn.prepareStatement(college);

                college_s.setString(1, number);
                ResultSet college_rs = college_s.executeQuery();
                
            %>
            <td>
            
                <% while(college_rs.next()) {%>
                    <input size="6" value="<%=college_rs.getString("College")%>" name="College"><br>
                <% } %>
            
            </td>

            <%
                college_s.close();
                college_rs.close();
            %>


            <%
                String majorss = "SELECT * FROM STUDENT_UNDER_MAJOR WHERE Student_ID = ?";
                PreparedStatement majorss_s = conn.prepareStatement(majorss);

                majorss_s.setString(1, number);
                ResultSet majorss_rs = majorss_s.executeQuery();
            %>
            <td>
                <% while(majorss_rs.next()) { %>
                    <input size="15" value="<%= majorss_rs.getString("Major") %>" name="Major"><br>
                <% } %>
            </td>

            <%
                majorss_s.close();
                majorss_rs.close();
            %>


            <%
                String minorss = "SELECT * FROM STUDENT_UNDER_MINOR WHERE Student_ID = ?";
                PreparedStatement minorss_s = conn.prepareStatement(minorss);

                minorss_s.setString(1, number);
                ResultSet minorss_rs = minorss_s.executeQuery();
            %>
            <td>
                <% while(minorss_rs.next()) { %>
                    <input size="15" value="<%= minorss_rs.getString("Minor") %>" name="Minor"><br>
                <% } %>
            </td>

            <%
                minorss_s.close();
                minorss_rs.close();
            %>


            <%
                String student_degree = "SELECT * FROM STUDENT_DEGREE_HISTORY WHERE Student_ID = ?";
                PreparedStatement student_degree_s = conn.prepareStatement(student_degree);
            
                student_degree_s.setString(1, number);
                ResultSet student_degree_rs = student_degree_s.executeQuery();
            %>

            <td>
                <% while(student_degree_rs.next()) { %>
                    <% 
                        String university_n = student_degree_rs.getString("University");
                        String degree_name_n = student_degree_rs.getString("Degree_Name");
                    %>
                    <input size="20" value="<%= university_n + ", " + degree_name_n%>" name="Degree"><br>
                <% } %>
            </td>

            <%
                student_degree_s.close();
                student_degree_rs.close();
            %>

            <td><input size="6" value="<%=studentG_rs.getString("Enroll")%>" name="Enroll"></td>
            <td><input size="18"value="<%=studentG_rs.getString("Res")%>" name="Res"></td>
            <td><input type="submit" value="Update"></td>
        </form>
            <%--

            =========================================== DELETION CODE STARTS ==============================================

            --%>



            <form action="fiveyear_Delete.jsp" method="get">
                <input type="hidden" value="delete" name="action">
                <input type="hidden" value="<%=rs.getString("Student_ID")%>" name="delete_num">
                <td><input id="delete_button" type="submit" value="Delete"></td>
            </form>


            <%--

            =========================================== DELETION CODE ENDS ==============================================

            --%>

        </tr>

        <%
            studentG_s.close();
            studentG_rs.close();
        %>

        <%
            }
        %>
        <%-- 
        
        
        ======================================== Presentation Code Ends ============================================ 
                            
                            
                            
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