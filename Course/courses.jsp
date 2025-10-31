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
            ResultSet rs = statement.executeQuery("SELECT * FROM COURSES");
    %>

    <table>
        <tr id="main_row">
            <th>Numbers</th>
            <th>Department</th>
            <th>Pre-Requisites</th>
            <th>Units</th>
            <th>Grade Options</th>
            <th>Lab Required?</th>
            <th>Co-Requisite Courses</th>
            <th>Consent Of Instructor</th>
            <th>Old Course Number</th>
            <th>Category</th>
            <th style="background-color: orange;">Action</th>
        </tr>




        <%--

            =================== INSERTION PART =============================

        --%>

        <tr id="insert_row">
            <form action="courses_ProcessInsert.jsp" method="get">
            <input type="hidden" value="insert" name="action">
            <th><input value="" name="numbers" placeholder="Ex: CSE 101..."></th>
            <th><input value="" name="department" placeholder="Ex: CSE..."></th>
            <th><input value="" name="preRequisites" placeholder="Ex: CSE 101..."></th>
            <th><input value="" name="units" placeholder="Ex: 7, 8..."></th>
            <th><input value="" name="grades" placeholder="Ex: Letter, S/U.."></th>
            <th><input value="" name="lab" placeholder="Ex: Yes or No"></th>
            <th><input value="" name="coreq" placeholder="Ex: CSE 10, CSE 100.."></th>
            <th><input value="" name="consent" placeholder="Ex: Yes or No"></th>
            <th><input value="" name="previous" placeholder="Ex: CSE 132.."></th>
            <th><input value="" name="cate" placeholder="Ex: Upper, Elective.."></th>
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
        <form action="courses_Update.jsp" method="get">
            <%-- Get the CourseNumber, which is a string --%>
            <% 
                String number = rs.getString("Numbers");
            %>
            <input type="hidden" value="update" name="action">
            
            <td><%= number %></td>
            
            <input type="hidden" value="<%= number %>" name="hiddenNum">


            <%-- Get the Department --%>
            <td><input value="<%= rs.getString("Department") %>" name="Department"></td>


            <%
                String prereq_q = "SELECT Prerequisites FROM COURSE_PREREQ WHERE Course_ID = ?";
                PreparedStatement prereq_s = conn.prepareStatement(prereq_q);

                prereq_s.setString(1, number);
                ResultSet prereq_rs = prereq_s.executeQuery(); 
            %>


            <td>
                <input value="<% 
                        while(prereq_rs.next()) {
                    %><%=prereq_rs.getString("Prerequisites") + ", "%><%
                    }
                %>" name="Prerequisites">

                <% 
                    prereq_rs.close();
                    prereq_s.close(); 
                %>
            </td>




            <%
                String units_q = "SELECT Units FROM COURSE_UNITS WHERE Course_ID = ?";
                PreparedStatement units_s = conn.prepareStatement(units_q);

                units_s.setString(1, number);
                ResultSet units_rs = units_s.executeQuery(); 
            %>


            <td>
                <input value="<% 
                    while(units_rs.next()) {
                %><%=units_rs.getString("Units") + ", "%><%
                    }
                %>" name="Units">

                <% 
                    units_rs.close();
                    units_s.close(); 
                %>

            </td>



            <%
                String grades_q = "SELECT Grades FROM GRADE_OPTIONS WHERE Course_ID = ?";
                PreparedStatement grades_s = conn.prepareStatement(grades_q);

                grades_s.setString(1, number);
                ResultSet grades_rs = grades_s.executeQuery(); 
            %>


            <td>
                <input value="<% 
                    while(grades_rs.next()) {
                %><%=grades_rs.getString("Grades") + ", "%><%
                    }
                %>" name="Grades">

                <% 
                    grades_rs.close();
                    grades_s.close(); 
                %>
            </td>



            <%-- Get the Lab Requirement --%>
            <td><input value="<%= rs.getString("LabReq") %>" name="LabReq"></td>





            <%
                String coreq_q = "SELECT Coreq_ID FROM COURSE_COREQ WHERE Course_ID = ?";
                PreparedStatement coreq_s = conn.prepareStatement(coreq_q);

                coreq_s.setString(1, number);
                ResultSet coreq_rs = coreq_s.executeQuery(); 
            %>


            <td>
                <input value="<% 
                    while(coreq_rs.next()) {
                %><%=coreq_rs.getString("COREQ_ID") + ", "%><%
                    }
                %>" name="COREQ_ID">

                <% 
                    coreq_rs.close();
                    coreq_s.close(); 
                %>
            </td>



            <%-- Get the Consent of Instrutor --%>
            <td><input value="<%= rs.getString("Consent") %>" name="Consent"></td>





            <%
                String previous_q = "SELECT OLD_NUMBERS FROM COURSE_OLDNUM WHERE Course_ID = ?";
                PreparedStatement previous_s = conn.prepareStatement(previous_q);

                previous_s.setString(1, number);
                ResultSet previous_rs = previous_s.executeQuery(); 
            %>


            <td>
                <input value="<% 
                    while(previous_rs.next()) {
                %><%=previous_rs.getString("OLD_NUMBERS") + ", "%><%
                    }
                %>" name="OLD_NUMBERS">

                <% 
                    previous_rs.close();
                    previous_s.close(); 
                %>
            </td>

            <%
                String categories = "SELECT CATEGORY FROM COURSE_CATEGORY WHERE Course_ID = ?";
                PreparedStatement categories_s = conn.prepareStatement(categories);

                categories_s.setString(1, number);
                ResultSet categories_rs = categories_s.executeQuery(); 
            %>


            <td>
                <input value="<% 
                    while(categories_rs.next()) {
                %><%=categories_rs.getString("CATEGORY") + ", "%><%
                    }
                %>" name="CATEGORY">

                <% 
                    categories_rs.close();
                    categories_s.close(); 
                %>
            </td>

            <td><input type="submit" value="Update"></td>
        </form>
        
        <form action="courses_Delete.jsp" method="get">
            <input type="hidden" value="delete" name="action">
            <input type="hidden" value="<%= rs.getString("Numbers") %>"
            name="Numbers">
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
