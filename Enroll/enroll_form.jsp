<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CSE 132B Project</title>
    
    
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
            //Statement statement = conn.createStatement();

            
    %>


    <%--

    =========================================== INSERTION CODE STARTS ==============================================

    --%>
    <form action="enroll_Insert.jsp" method="get">
        <div id="insert-form">
            <p>Please Enter Student ID and Select Sections & Grade Option & Units:</p>

            <%
                conn.setAutoCommit(false);

                PreparedStatement offering = conn.prepareStatement(
                    ("SELECT * FROM OFFERING WHERE Course_ID = ? AND Year_C = ? AND Term = ?"));

                PreparedStatement units = conn.prepareStatement(
                    ("SELECT * FROM COURSE_UNITS WHERE Course_ID = ?"));
                
                PreparedStatement grades = conn.prepareStatement(
                    ("SELECT * FROM GRADE_OPTIONS WHERE Course_ID = ?"));

                offering.setString(1, request.getParameter("courseIDCL"));
                offering.setInt(2, Integer.parseInt(request.getParameter("yearCL")));
                offering.setString(3, request.getParameter("termCL"));

                units.setString(1, request.getParameter("courseIDCL"));
                grades.setString(1, request.getParameter("courseIDCL"));

                ResultSet offering_rs = offering.executeQuery();
                ResultSet units_rs = units.executeQuery();
                ResultSet grades_rs = grades.executeQuery();

                conn.commit();
                conn.setAutoCommit(true);

            %>

            <table id="first_layer">
                <tr id="insert1" class="insertion">
                    <th>StudentID</th>
                    <th>Course Number</th>
                    <th>Section ID</th>
                    <th>Grade Option</th>
                    <th>Unit</th>
                </tr>
                <tr>
                    <th><input value="" name="insert_student_ID" placeholder="Ex: A15030649..."></th>
                    <th>
                        <%=request.getParameter("courseIDCL")%>
                        <input type="hidden" name="insert_courseID" value="<%=request.getParameter("courseIDCL")%>" >
                    </th>

                    <th>
                        <select id="sectionSelect">
                            <option></option>
                            <% while(offering_rs.next()) {%>
                                <option><%=offering_rs.getString("Section_ID")%></option>
                            <% } %>
                        </select>

                        <%
                            offering.close();
                            offering_rs.close();
                        %>
                    </th>

                    <input id="section_result" type="hidden" name="insert_section">


                    <script>
                        var select = document.getElementById("sectionSelect");
                        
                        select.addEventListener("change", function() {
                            
                            var selectedValue = select.value;
                            
                            var result = document.getElementById("section_result");
                            result.value = selectedValue;
                        });
                    </script>

                    <th>
                        <select id="gradeSelect">
                            <option></option>
                            <% while(grades_rs.next()) {%>
                                <option><%=grades_rs.getString("Grades")%></option>
                            <% } %>
                        </select>

                        <%
                            grades.close();
                            grades_rs.close();
                        %>
                    </th>

                    <input id="grade_result" type="hidden" name="insert_grade">


                    <script>
                        var select2 = document.getElementById("gradeSelect");
                        
                        select2.addEventListener("change", function() {
                            
                            var selectedValue = select2.value;
                            
                            var result = document.getElementById("grade_result");
                            result.value = selectedValue;
                        });
                    </script>


                    <th>
                        <select id="unitsSelect">
                            <option></option>
                            <% while(units_rs.next()) {%>
                                <option><%=units_rs.getString("Units")%></option>
                            <% } %>
                        </select>

                        <%
                            units_rs.close();
                            units_rs.close();
                        %>
                    </th>

                    <input type="hidden" value="<%=request.getParameter("termCL")%>" name="insert_term">
                    <input type="hidden" value="<%=request.getParameter("yearCL")%>" name="insert_year">

                    <input id="units_result" type="hidden" name="insert_units">

                    <script>
                        var select1 = document.getElementById("unitsSelect");
                        
                        select1.addEventListener("change", function() {
                            
                            var selectedValue = select1.value;
                            
                            var result = document.getElementById("units_result");
                            result.value = selectedValue;
                        });
                    </script>
                    
                </tr>
            </table>
        </div>
        <br>
        <input value="INSERT INTO DATABASE" type="submit" name="action">

        
    </form>


    <%--

    =========================================== INSERTION CODE ENDS ==============================================

    --%>


    

        <%-- 
        
        
        ======================================== Presentation Code Ends ============================================ 
                            
                            
                            
        --%>



    </table>


    <%-- Close Statement Code --%>
    <%     
            // Close the ResultSet
            //rs.close();

            // Close the Statement
            //statement.close();

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
