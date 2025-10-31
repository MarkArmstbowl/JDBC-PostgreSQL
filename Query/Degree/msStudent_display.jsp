<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CSE 132B Project</title>
    <script src="../script.js"></script>

    <style>

        #display {
            border-collapse: collapse;
            margin-top: 3%;
            width: 70%;
            margin: 0 auto;
            margin-top: 20px;
        }

        #display td {
            text-align: center;
            font-size: 12px;
            font-weight: normal;
            font-family: Helvetica;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }

        #main_row th {
            background-color: yellow;
            font-size: 0.7rem;
        }



    </style>
    
</head>




<body>

    <%-- Set the scripting language to java and --%>
    <%-- import the java.sql package --%>
    <%@ page language="java" import="java.sql.*, java.util.ArrayList" %>


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

    <jsp:include page="../../index.html" />




    <%-- 
        
        
        ======================================== Presentation Code Starts ============================================ 
                            
                            
                            
    --%>

    <%

        String action = request.getParameter("action");

        if (action != null && action.equals("Search")) {

            String sid = request.getParameter("s_id_info");
            String dep = request.getParameter("dep_info");

            String degree = "SELECT * FROM MS_Degree WHERE DEPARTMENT = ?";
            
            PreparedStatement degree_s = conn.prepareStatement(degree);
            degree_s.setString(1, dep);
            ResultSet degree_rs = degree_s.executeQuery();

            String finished = "";
            ArrayList<String> unfinished = new ArrayList<String>();

            while (degree_rs.next()){
                String concentration = degree_rs.getString("Concentration");
                int unit_required = degree_rs.getInt("ConUnits");
                double gpa_required = Double.parseDouble(degree_rs.getString("GPA"));
                int unit_finished = 0;
                int gpa_unit_finished = 0;
                double total_units = 0.0;
                String courses_offer = concentration;
                courses_offer += ": ";

                String Con_courses = "SELECT Course_ID FROM Concentration_Courses WHERE Department = ? AND Concentration = ?";
                PreparedStatement Con_courses_s = conn.prepareStatement(Con_courses);
                Con_courses_s.setString(1, dep);
                Con_courses_s.setString(2, concentration);

                ResultSet Con_courses_rs = Con_courses_s.executeQuery();
                
                while (Con_courses_rs.next()){
                    String CourseNum = Con_courses_rs.getString("Course_ID");
                    PreparedStatement taken_s = conn.prepareStatement("SELECT Grade, Grade_Option, Unit FROM TAKEN WHERE Course_Num = ? AND Student_ID = ?");
                    taken_s.setString(1, CourseNum);
                    taken_s.setString(2, sid); 

                    ResultSet taken_rs = taken_s.executeQuery();
                    if (taken_rs.next()){
                        unit_finished += taken_rs.getInt("Unit");
                        PreparedStatement gpa_s = conn.prepareStatement("SELECT NUMBER_GRADE FROM GRADE_CONVERSION WHERE LETTER_GRADE = ?");
                        gpa_s.setString(1, taken_rs.getString("Grade"));
                        ResultSet gpa_rs = gpa_s.executeQuery();
                        if (gpa_rs.next()){
                            gpa_unit_finished += taken_rs.getInt("Unit");
                            total_units += taken_rs.getInt("Unit") * Double.parseDouble(gpa_rs.getString("NUMBER_GRADE"));
                        }
                        gpa_s.close();
                        gpa_rs.close();
                    }else{
                        courses_offer += CourseNum;
                        courses_offer += "(";
                        PreparedStatement offering_s = conn.prepareStatement("SELECT TERM, YEAR_C FROM OFFERING WHERE Course_ID = ? AND ((YEAR_C > 2018) OR (YEAR_C = 2018 AND TERM = 'FALL')) ORDER BY YEAR_C, TERM DESC");
                        offering_s.setString(1, CourseNum);
                        ResultSet offering_rs = offering_s.executeQuery();
                        if (offering_rs.next()){
                            courses_offer += offering_rs.getString("TERM");
                            courses_offer += " ";
                            courses_offer += offering_rs.getString("YEAR_C");            
                        }
                        courses_offer += "), ";
                        offering_s.close();
                        offering_rs.close();
                    }
                    taken_s.close();
                    taken_rs.close();
                }

                unfinished.add(courses_offer);

                double gpa = total_units / gpa_unit_finished;
                if (unit_finished >= unit_required && gpa >= gpa_required){
                    finished += concentration;
                    finished += ", ";
                }
                Con_courses_s.close();
                Con_courses_rs.close();
            }
            
            degree_s.close();
            degree_rs.close();
        
    %>

    <p style="text-align: center;"> Student <%= sid %> Degree Progress for MS in <%= dep %></p>

    <div>
        <table id="display">
            <tr id="main_row">
                <th style="width:3%;">Student ID</th>
                <th style="width:3%;">Degree Department</th>
                <th style="width:5%;">Completed Concentrations</th>
                <th style="width:20%;">In Progress Concentrations & Courses Next Time Offering</th>
            </tr>

            <tr>
                <td><%= sid %></td>
                <td><%= dep %></td>
                <td><%= finished %></td>
                <td>
                    
                        <% for(String course : unfinished) {%>
                            <%= course %><br>
                        <% } %>
                    
                </td>
            </tr>

        </table>
    </div>

    <%
        }
    %>


    <%-- 
        
        
    ======================================== Presentation Code Ends ============================================ 
                        
                        
                        
    --%>



    

    <%-- Close Statement Code --%>
    <%
            // Close the ResultSet

            // Close the Statement

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