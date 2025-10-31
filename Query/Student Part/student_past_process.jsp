<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CSE 132B Project</title>
    <script src="../../script.js"></script>

    <style>

        #display {
            border-collapse: collapse;
            width: 40%;
            margin: 0 auto;
            margin-top: 20px;
        }

        #display td {
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

            PreparedStatement past = conn.prepareStatement(
                "SELECT term, year FROM taken WHERE student_id = ? GROUP BY term, year ORDER BY year, term");
            
            past.setString(1, request.getParameter("s_id_info"));

            ResultSet past_rs = past.executeQuery();

            double termGPA = 0.00;
            double numC = 0.00;
            double numT = 0.00;
            double totalGPA = 0.00;

    %>

    <p style="text-align: center;">All Classes Student <%=request.getParameter("s_id_info")%> Has Taken</p>

    <div>
        <table id="display">
            <tr id="main_row">
                <th style="width:10%;">Quarter</th>
                <th style="width:5%;">Section ID</th>
                <th style="width:5%;">Course</th>
                <th style="width:3%">Grade</th>
                <th style="width:3%">Unit</th>
                <th style="width:5%">GPA</th>
            </tr>

            <%
                while(past_rs.next() ) {
                    String year = past_rs.getString("Year");
                    String term = past_rs.getString("Term");
                    ArrayList<String> termGrade = new ArrayList<>();
                    ArrayList<Double> termUnit = new ArrayList<>();
                    termGPA = 0.00;
                    numC = 0.00;
            %>


            <tr>
                <td><%= term + " " + year %></td>

                <%
                    PreparedStatement sID = conn.prepareStatement(
                        "SELECT * FROM TAKEN WHERE Student_ID = ? AND Term = ? AND Year = ?");
                    
        
                    sID.setString(1, request.getParameter("s_id_info"));
                    sID.setString(2, term);
                    sID.setInt(3, Integer.parseInt(year));
        
                    ResultSet sID_rs = sID.executeQuery();
                %>  
                <td>
                    
                        <% while(sID_rs.next()) {%>
                            <%=sID_rs.getString("Section_ID")%><br>
                        <% } %>
                    
                </td>
                <%
                    sID.close();
                    sID_rs.close();
                %>


                <%
                    PreparedStatement course = conn.prepareStatement(
                        "SELECT * FROM TAKEN WHERE Student_ID = ? AND Term = ? AND Year = ?");
                    
        
                    course.setString(1, request.getParameter("s_id_info"));
                    course.setString(2, term);
                    course.setInt(3, Integer.parseInt(year));
        
                    ResultSet course_rs = course.executeQuery();
                %>  
                <td>
                    
                        <% while(course_rs.next()) {%>
                            <%=course_rs.getString("Course_Num")%><br>
                        <% } %>
                    
                </td>
                <%
                    course.close();
                    course_rs.close();
                %>



                <%
                    PreparedStatement grade = conn.prepareStatement(
                        "SELECT * FROM TAKEN WHERE Student_ID = ? AND Term = ? AND Year = ?");
                    
        
                    grade.setString(1, request.getParameter("s_id_info"));
                    grade.setString(2, term);
                    grade.setInt(3, Integer.parseInt(year));
        
                    ResultSet grade_rs = grade.executeQuery();
                %>  
                <td>
                    
                        <% while(grade_rs.next()) {
                            termGrade.add(grade_rs.getString("Grade").trim());
                            
                        %>
                            <%=grade_rs.getString("Grade")%><br>
                        <% } %>
                    
                </td>
                <%
                    grade.close();
                    grade_rs.close();
                %>


                <%
                    PreparedStatement unit = conn.prepareStatement(
                        "SELECT * FROM TAKEN WHERE Student_ID = ? AND Term = ? AND Year = ?");
                    
        
                    unit.setString(1, request.getParameter("s_id_info"));
                    unit.setString(2, term);
                    unit.setInt(3, Integer.parseInt(year));
        
                    ResultSet unit_rs = unit.executeQuery();
                %>  
                <td>
                    
                        <% while(unit_rs.next()) {
                            termUnit.add(Double.parseDouble(unit_rs.getString("Unit")));
                        %>
                            <%=unit_rs.getString("Unit")%><br>

                        <% } %>


                    
                </td>

                <%
                    unit_rs.close();
                    unit_rs.close();
                %>

                <td>
                    <%
                        for (int i = 0; i < termGrade.size(); i++) {
                            if( !(termGrade.get(i).equals("IN") || termGrade.get(i).equals("S/U"))) {

                                PreparedStatement gpa = conn.prepareStatement(
                                    "SELECT * FROM GRADE_CONVERSION WHERE LETTER_GRADE = ?");
                                
                    
                                gpa.setString(1, termGrade.get(i));
                    
                                ResultSet gpa_rs = gpa.executeQuery();

                                while(gpa_rs.next()) {
                                    termGPA += Double.parseDouble(gpa_rs.getString("NUMBER_GRADE")) * termUnit.get(i);
                                }

                                
                                gpa_rs.close();
                                gpa.close();
                            }
                        }
                    %>

                    <%
                        for (int i = 0; i < termUnit.size(); i++) {
                            if( !(termGrade.get(i).equals("IN") || termGrade.get(i).equals("S/U"))) {
                                numC += termUnit.get(i);
                            }
                        }
                        totalGPA += termGPA;
                        numT += numC;
                    %>

                    <%= String.format("%.3f", termGPA / numC)%>

                </td>




            </tr>

            
            <%
                }
            %>

            <%
                past_rs.close();
                past.close();
            %>
        </table>
    </div>

    <p style="text-align: center; color:cadetblue;">Cumulatvie GPA is: <%= String.format("%.3f", totalGPA / numT)%></p>



    <%
        }
    %>



    <%-- 
        
        
    ======================================== Presentation Code Ends ============================================ 
                        
                        
                        
    --%>



    

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