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
            width: 100%;
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
    <%@ page language="java" import="java.sql.*" %>


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
        conn.setAutoCommit(false);

        String action = request.getParameter("action");

        if (action != null && action.equals("Search")) {

            PreparedStatement s_enroll = conn.prepareStatement(
                ("SELECT * FROM ENROLL WHERE Student_ID = ?"));

            s_enroll.setString(1, request.getParameter("s_id_info"));

            ResultSet s_enroll_rs = s_enroll.executeQuery();

            conn.commit();
            conn.setAutoCommit(true);

    %>

    <p style="text-align: center;">All Classes That Student <%=request.getParameter("s_id_info")%> Takes in Current Quarter SPRING 2018</p>

    <div>
        <table id="display">
            <tr id="main_row">
                <th style="width:4%;">Section ID</th>
                <th style="width:5%;">Course</th>
                <th style="width:3%;">Meeting Type</th>
                <th style="width:3%">Mandatory</th>
                <th style="width:3%">Days</th>
                <th style="width:10%">Time</th>
                <th style="width:5%">Building</th>
                <th style="width:3%">Room</th>
                <th style="width:15%">Review Sessions</th>
                <th style="width:15%">Final Exam</th>
                <th style="width:5%";>Instructor</th>
                <th style="width:3%;">Enrollment Limit</th>
                <th style="width:3%;">Quarter</th>
                <th style="width:3%;">Year</th>
                <th style="width:3%;">Units</th>
                <th style="width:10%">Title</th>
            </tr>

            <%
                while(s_enroll_rs.next() ) {
                    String number = s_enroll_rs.getString("Section_ID");
            %>


            <tr>
                <td><%= number %></td>

                <%
                    String offering = "SELECT * FROM OFFERING WHERE Section_ID = ?";
                    PreparedStatement offering_s = conn.prepareStatement(offering);

                    offering_s.setString(1, number);
                    ResultSet offering_rs = offering_s.executeQuery();
                %>  
                <td>
                    <% if(offering_rs.next()) {%> 
                     <%=offering_rs.getString("Course_ID")%>
                    <% } %>
                </td>
                <%
                    offering_s.close();
                    offering_rs.close();
                %>


                <%
                    String meeting = "SELECT * FROM CLASSES_SECTIONS WHERE Section_ID = ?";
                    PreparedStatement meeting_s = conn.prepareStatement(meeting);
        
                    meeting_s.setString(1, number);
                    ResultSet meeting_rs = meeting_s.executeQuery();
                %>  
                <td>
                    
                        <% while(meeting_rs.next()) {%>
                            <%=meeting_rs.getString("Type_M")%><br>
                        <% } %>
                    
                </td>
                <%
                    meeting_s.close();
                    meeting_rs.close();
                %>

                <%
                    String mandatory = "SELECT * FROM CLASSES_SECTIONS WHERE Section_ID = ?";
                    PreparedStatement mandatory_s = conn.prepareStatement(mandatory);
        
                    mandatory_s.setString(1, number);
                    ResultSet mandatory_rs = mandatory_s.executeQuery();
                %>  
                <td>
                    
                        <% while(mandatory_rs.next()) {%>
                            <%=mandatory_rs.getString("Mandatory")%><br>
                        <% } %>
                    
                </td>
                <%
                    mandatory_s.close();
                    mandatory_rs.close();
                %>

                <%
                    String days = "SELECT * FROM CLASSES_SECTIONS WHERE Section_ID = ?";
                    PreparedStatement days_s = conn.prepareStatement(days);
        
                    days_s.setString(1, number);
                    ResultSet days_rs = days_s.executeQuery();
                %>  
                <td>
                    
                        <% while(days_rs.next()) {%>
                            <%=days_rs.getString("Days_C")%><br>
                        <% } %>
                    
                </td>
                <%
                    days_s.close();
                    days_rs.close();
                %>



                <%
                    String time = "SELECT * FROM CLASSES_SECTIONS WHERE Section_ID = ?";
                    PreparedStatement time_s = conn.prepareStatement(time);
        
                    time_s.setString(1, number);
                    ResultSet time_rs = time_s.executeQuery();
                %>  
                <td>
                    
                        <% while(time_rs.next()) {%>
                            <%=time_rs.getString("Start_Time") + "-" + time_rs.getString("End_Time")%><br>
                        <% } %>
                    
                </td>
                <%
                    time_s.close();
                    time_rs.close();
                %>

                <%
                    String building = "SELECT * FROM CLASSES_SECTIONS WHERE Section_ID = ?";
                    PreparedStatement building_s = conn.prepareStatement(building);
                    building_s.setString(1, number);
                    ResultSet building_rs = building_s.executeQuery();
                %>  
                <td>
                    <% while(building_rs.next()) { %>
                        <%=building_rs.getString("Building")%><br>
                    <% } %>
                </td>
                <%
                    building_s.close();
                    building_rs.close();
                %>


                <%
                    String room = "SELECT * FROM CLASSES_SECTIONS WHERE Section_ID = ?";
                    PreparedStatement room_s = conn.prepareStatement(room);
                    room_s.setString(1, number);
                    ResultSet room_rs = room_s.executeQuery();
                %>  
                <td>
                    <% while(room_rs.next()) { %>
                        <%=room_rs.getString("Room")%><br>
                    <% } %>
                </td>
                <%
                    room_s.close();
                    room_rs.close();
                %>


                <%
                    String review = "SELECT * FROM REVIEW WHERE Section_ID = ?";
                    PreparedStatement review_s = conn.prepareStatement(review);
                    review_s.setString(1, number);
                    ResultSet review_rs = review_s.executeQuery();
                %>  
                <td>
                    <% while(review_rs.next()) { %>
                    <% 
                        String review_d = review_rs.getString("Dates");
                        String review_t = review_rs.getString("Time_C");
                        String review_b = review_rs.getString("Building");
                        String review_r = review_rs.getString("Room");
                    %>
                        <%=review_d + ", " + review_t + ", " + review_b + ", " + review_r %><br>
                    <% } %>
                </td>
                <%
                    review_s.close();
                    review_rs.close();
                %>


                <%
                    String final2 = "SELECT * FROM Exam WHERE Section_ID = ?";
                    PreparedStatement final_s = conn.prepareStatement(final2);
                    final_s.setString(1, number);
                    ResultSet final_rs = final_s.executeQuery();
                    
                %>  
                <td>
                    <% if (final_rs.next()) { %>
                    <% 
                        String final_d = final_rs.getString("Dates");
                        String final_t = final_rs.getString("Time_C");
                        String final_b = final_rs.getString("Building");
                        String final_r = final_rs.getString("Room");
                    %>
                    <%= final_d + ", " + final_t + ", " + final_b + ", " + final_r %>
                    <% } %>
                </td>
                <%
                    final_s.close();
                    final_rs.close();
                %>


                <%
                    String instor = "SELECT * FROM CLASSES_SECTIONS WHERE Section_ID = ?";
                    PreparedStatement instor_s = conn.prepareStatement(instor);
                    instor_s.setString(1, number);
                    ResultSet instor_rs = instor_s.executeQuery();
                %>  
                <td>
                    <% if (instor_rs.next()) { %>
                        <%= instor_rs.getString("Instructor") %>
                    <% } %>
                </td>
                <%
                    instor_s.close();
                    instor_rs.close();
                %>


                <%
                    String enroll_insert = "SELECT * FROM CLASSES WHERE Section_ID = ?";
                    PreparedStatement enroll_insert_s = conn.prepareStatement(enroll_insert);
                    enroll_insert_s.setString(1, number);
                    ResultSet enroll_insert_rs = enroll_insert_s.executeQuery();
                %>  
                <td>
                    <% if (enroll_insert_rs.next()) { %>
                        <%= enroll_insert_rs.getString("Enroll_Limit") %>
                    <% } %>
                </td>
                <%
                    enroll_insert_s.close();
                    enroll_insert_rs.close();
                %>


                <%
                    String term = "SELECT * FROM OFFERING WHERE Section_ID = ?";
                    PreparedStatement term_s = conn.prepareStatement(term);
                    term_s.setString(1, number);
                    ResultSet term_rs = term_s.executeQuery();
                %>  
                <td>
                    <% if (term_rs.next()) { %>
                    
                        <%= term_rs.getString("Term") %>
                    <% } %>
                </td>
                <%
                    term_s.close();
                    term_rs.close();
                %>


                <%
                    String yeari = "SELECT * FROM OFFERING WHERE Section_ID = ?";
                    PreparedStatement yeari_s = conn.prepareStatement(yeari);
                    yeari_s.setString(1, number);
                    ResultSet yeari_rs = yeari_s.executeQuery();
                %>  
                <td>
                    <% if (yeari_rs.next()) { %>
                        <%= yeari_rs.getString("Year_C") %>
                    <% } %>
                    
                </td>
                <%
                    yeari_s.close();
                    yeari_rs.close();
                %>


                <%
                    PreparedStatement s1_enroll = conn.prepareStatement(
                        ("SELECT * FROM ENROLL WHERE Student_ID = ? AND Section_ID = ?"));
            
                    s1_enroll.setString(1, request.getParameter("s_id_info"));
                    s1_enroll.setString(2, number);
            
                    ResultSet s1_enroll_rs = s1_enroll.executeQuery();
                %>  
                <td>
                    <% if (s1_enroll_rs.next()) { %>
                    
                        <%= s1_enroll_rs.getString("Unit") %>
                    <% } %>
                </td>
                <%
                    s1_enroll.close();
                    s1_enroll_rs.close();
                %>


                <%
                    String titlei = "SELECT * FROM OFFERING WHERE Section_ID = ?";
                    PreparedStatement titlei_s = conn.prepareStatement(titlei);
                    titlei_s.setString(1, number);
                    ResultSet titlei_rs = titlei_s.executeQuery();
                %>  
                <td>
                    <% if (titlei_rs.next()) { %>
                        <%= titlei_rs.getString("Title") %>
                    <% } %>
                </td>
                <%
                    titlei_s.close();
                    titlei_rs.close();
                %>



            </tr>

            
            <%
                }
            %>
        </table>
    </div>

    <%
            s_enroll_rs.close();
            s_enroll.close();
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