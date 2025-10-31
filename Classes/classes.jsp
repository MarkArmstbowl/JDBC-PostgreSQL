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
            font-size: 0.7rem;
        }

        #show td{
            text-align: center;
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

        #insert2 th{
            margin-right:2px;
        }
        
        
    </style>
</head>




<body>
    <%-- Set the scripting language to java and --%>
    <%-- import the java.sql package --%>
    <%@ page language="java" import="java.sql.*" %>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.text.*" %>
    <%@ page import="javax.servlet.*" %>
    <%@ page import="javax.servlet.http.*" %>
    <%@ page import="java.util.*" %>
    <%@ page import="java.util.ArrayList" %>

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
            ResultSet rs = statement.executeQuery("SELECT * FROM CLASSES");
    %>





    <%--

    =========================================== INSERTION CODE STARTS ==============================================

    --%>
    <form action="classes_Insert.jsp" method="get">
        <div id="insert-form">
            <p>Please Enter Classes Information:</p>

            <table id="first_layer">
                <tr id="insert1" class="insertion">
                    <th>Course</th>
                    <th>Enrollment Limit</th>
                    <th>Quarter</th>
                    <th>Year</th>
                    <th>Title</th>
                </tr>
                <tr>
                    <th style="border: none;"><input value="" name="name" placeholder="Ex: CSE 132B..."></th>
                    <th style="border: none;"><input value="" name="enrollment" placeholder="Ex: 10..."></th>
                    <th style="border: none;"><input value="" name="quarter" placeholder="Ex: SPRING.."></th>
                    <th style="border: none;"><input value="" name="year" placeholder="Ex: 2018..."></th>
                    <th style="border: none;"><input value="" name="title" placeholder="Ex: DB System Applications..."></th>
                </tr>
            </table>


            <br>
            <p> Please Enter Section Information:</p>
            <table  id="sections-for-classes">
                <tr id="insert2" class="insertion">
                    <th>Section ID</th>
                    <th>Meeting Type</th>
                    <th>Mandatory</th>
                    <th>Days</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Building</th>
                    <th>Room</th>
                    <th>Instuctor</th>
                </tr>
               

                <tr>
                    <th><input value="" name="sectionID" placeholder="Ex: 40307..."></th>
                    <th id="meeting-for-classes"><input value="" name="meeting_type" placeholder="Ex: LE or DI..."><button type="button" onclick="add_meeting(this)">+</button></th>

                    <th><input value="" name="mandatory" placeholder="Ex: Yes or No..."></th>
                    <th><input value="" name="days" placeholder="Ex: MW...TTh.."></th>
                    <th><input value="" name="start_time" placeholder="Ex: 11:00 AM"></th>
                    <th><input value="" name="end_time" placeholder="Ex: 05:00 PM"></th>
                    <th><input value="" name="building" placeholder="Ex: WLH..."></th>
                    <th><input value="" name="room" placeholder="Ex: M2203.."></th>
                    <th><input value="" name="instructor" placeholder="Ex: John Smith"></th>
                </tr>
                 
            </table> 


        

            <p>Please Enter Review Sessions(If any) Information:</p>
            <table id="reviews-for-classes">
                <tr id="insert3" class="insertion">
                    <th>Dates</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Building</th>
                    <th>Room</th>
                </tr>
                <tr id="reviews-table">
                    <th><input value="" name="review-dates" placeholder="Ex: 05/14/2024..."></th>
                    <th><input value="" name="review_start_time" placeholder="Ex: 11:00 AM"></th>
                    <th><input value="" name="review_end_time" placeholder="Ex: 05:00 PM"></th>
                    <th><input value="" name="review-building" placeholder="Ex: WLH..."></th>
                    <th><input value="" name="review-room" placeholder="Ex: M2203..."></th>
                </tr>
            </table> 
            <button type="button"  onclick="add_Review()">Add Review Session</button>
            



            <p>Please Enter Final Exam Information:</p>
            <table id="finals-for-classes">
                <tr id="insert4" class="insertion">
                    <th>Dates</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Building</th>
                    <th>Room</th>
                </tr>
                <tr id="finals-table">
                    <th><input value="" name="final-dates" placeholder="Ex: 05/14/2024..."></th>
                    <th><input value="" name="final_start_time" placeholder="Ex: 11:00 AM"></th>
                    <th><input value="" name="final_end_time" placeholder="Ex: 05:00 PM"></th>
                    <th><input value="" name="final-building" placeholder="Ex: WLH..."></th>
                    <th><input value="" name="final-room" placeholder="Ex: M2203..."></th>  
                </tr>
            </table>

        
        </div>
        <br><br>
        
        <input value="INSERT INTO DATABASE" type="submit" name="action">
    </form>

    
        
        

    <%

    %>



    <%--

    ============================================ INSERTION CODE ENDS ================================================

    --%>



    



    <table id="display">
        <tr id="main_row">
            <th style="width:3%;">Section ID</th>
            <th style="width:3%;">Course</th>
            <th style="width:10%;">Meeting Type</th>
            <th style="width:10%;">Mandatory</th>
            <th style="width:3%;">Days</th>
            <th style="width:25%;">Start Time</th>
            <th style="width:25%;">End Time</th>
            <th style="width:5%;">Building</th>
            <th style="width:3%;">Room</th>
            <th style="width:15%;">Review Sessions</th>
            <th style="width:15%;">Final Exam</th>
            <th style="width:5%;";>Instructor</th>
            <th style="width:3%;">Enrollment Limit</th>
            <th style="width:3%;">Quarter</th>
            <th style="width:3%;">Year</th>
            <th style="width:11%;">Title</th>
            <th style="background-color: orange; width:10%;">Action</th>
        </tr>

    


    <%-- 
        
        
        ======================================== Presentation Code Starts ============================================ 
                            
                            
                            
    --%>
    <%
    //Iterate Over the ResultSet
    while(rs.next() ) {
    %>

    <tr id="show">
        <form action="classes_Update.jsp" method="get">
        <input type="hidden" value="update" name="action">

        <% 
            String number = rs.getString("Section_ID");
        %>
        <td><%= number %></td>
        <input type="hidden" value="<%= number %>" name="hiddenSID">
        
        <%
            String offering = "SELECT * FROM OFFERING WHERE Section_ID = ?";
            PreparedStatement offering_s = conn.prepareStatement(offering);

            offering_s.setString(1, number);
            ResultSet offering_rs = offering_s.executeQuery();
        %>  
        <td>
            <% if(offering_rs.next()) {%> 
                <input size="8" value="<%=offering_rs.getString("Course_ID")%>" name="Number">
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
                    <input size="3" value="<%=meeting_rs.getString("Type_M")%>" name="Type" readonly><br>
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
                    <input size="3" value="<%=mandatory_rs.getString("Mandatory")%>" name="Mandatory"><br>
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
                    <input size="6" value="<%=days_rs.getString("Days_C")%>" name="Day"><br>
                <% } %>
            
        </td>
        <%
            days_s.close();
            days_rs.close();
        %>




        <%
            String time = "SELECT * FROM CLASSES_SECTIONS WHERE Section_ID = ?";
            PreparedStatement time_s = conn.prepareStatement(time);

            ArrayList<String> ends = new ArrayList<String>();

            time_s.setString(1, number);
            ResultSet time_rs = time_s.executeQuery();
        %>  
        <td style="font-weight: normal; font-size: 12px;">
            
                <% while(time_rs.next()) {%>
                    <% 
                        SimpleDateFormat inputFormat = new SimpleDateFormat("HH:mm:ss");
                        SimpleDateFormat outputFormat = new SimpleDateFormat("hh:mm a");

                        String start = time_rs.getString("Start_Time");

                        java.util.Date startTime = inputFormat.parse(start);
                        String sTime = outputFormat.format(startTime);

                        String end = time_rs.getString("End_Time");

                        java.util.Date endTime = inputFormat.parse(end);
                        String eTime = outputFormat.format(endTime);
                        ends.add(eTime);
                    %>
                    <input size="7" value="<%= sTime %>" name="Start_time">
                    <br>
                <% } %>
            
        </td>
        <%
            time_s.close();
            time_rs.close();
        %>  

        <td style="font-weight: normal; font-size: 12px;">
            
                <% for (String end : ends) {%>
                    <input size="7" value="<%= end %>" name="End_time">
                    <br>
                <% } %>         
        </td>


        <%
            String building = "SELECT * FROM CLASSES_SECTIONS WHERE Section_ID = ?";
            PreparedStatement building_s = conn.prepareStatement(building);
            building_s.setString(1, number);
            ResultSet building_rs = building_s.executeQuery();
        %>  
        <td>
            <% while(building_rs.next()) { %>
                <input size="5" value="<%=building_rs.getString("Building")%>" name="Building"><br>
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
                <input size="4" value="<%=room_rs.getString("Room")%>" name="Room"><br>
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

                String review_b = review_rs.getString("Building");
                String review_r = review_rs.getString("Room");


                SimpleDateFormat inputFormat = new SimpleDateFormat("HH:mm:ss");
                SimpleDateFormat outputFormat = new SimpleDateFormat("hh:mm a");

                String start = review_rs.getString("Start_Time");
                String end = review_rs.getString("End_Time");

                java.util.Date startTime = inputFormat.parse(start);
                String sTime = outputFormat.format(startTime);

                java.util.Date endTime = inputFormat.parse(end);
                String eTime = outputFormat.format(endTime);
            %>
                <input size="30" value="<%=review_d + ", " + sTime + " ~ " + eTime + ", " +review_b + ", " + review_r %>" name="Review" readonly><br>
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

                SimpleDateFormat inputFormat = new SimpleDateFormat("HH:mm:ss");
                SimpleDateFormat outputFormat = new SimpleDateFormat("hh:mm a");

                String start = final_rs.getString("Start_Time");
                String end = final_rs.getString("End_Time");

                java.util.Date startTime = inputFormat.parse(start);
                String sTime = outputFormat.format(startTime);

                java.util.Date endTime = inputFormat.parse(end);
                String eTime = outputFormat.format(endTime);


                String final_t1 = final_rs.getString("End_Time");
                String final_b = final_rs.getString("Building");
                String final_r = final_rs.getString("Room");
            %>
            <input size="30" value="<%= final_d + ", " + sTime + " ~ " + eTime + ", " + final_b + ", " + final_r %>" name="Final" readonly>
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
                <input size="10" value="<%= instor_rs.getString("Instructor") %>" name="Instructor">
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
                <input size="3" value="<%= enroll_insert_rs.getString("Enroll_Limit") %>" name="Limit">
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
            
                <input size="6" value="<%= term_rs.getString("Term") %>" name="Term">
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
                <input size="5" value="<%= yeari_rs.getString("Year_C") %>" name="Year">
            <% } %>
            
        </td>
        <%
            yeari_s.close();
            yeari_rs.close();
        %>


        <%
            String titlei = "SELECT * FROM OFFERING WHERE Section_ID = ?";
            PreparedStatement titlei_s = conn.prepareStatement(titlei);
            titlei_s.setString(1, number);
            ResultSet titlei_rs = titlei_s.executeQuery();
        %>  
        <td>
            <% if (titlei_rs.next()) { %>
                <input size="15" value="<%= titlei_rs.getString("Title") %>" name="Title">
            <% } %>
        </td>
        <%
            titlei_s.close();
            titlei_rs.close();
        %>
        <td><input type="submit" value="Update"></td>
        </form>


        <%--

        =========================================== DELETION CODE STARTS ==============================================

        --%>



        <form action="classes_Delete.jsp" method="get">
            <input type="hidden" value="delete" name="action">
            <input type="hidden" value="<%=rs.getString("Section_ID")%>" name="delete_num">
            <td><input id="delete_button" type="submit" value="Delete"></td>
        </form>


        <%--

        =========================================== DELETION CODE ENDS ==============================================

        --%>


    </tr>

    


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