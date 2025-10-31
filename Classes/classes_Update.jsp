<%-- Set the scripting language to java and --%>
<%-- import the java.sql package --%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.*" %>

<%-- Connectivity Code --%> 
<%
    Connection conn = null;
    boolean stop = false;
    try {
        // Load PostGres Driver class file
        Class.forName("org.postgresql.Driver");

        // Make a connection to the Postgres datasource
        conn = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5432/cse132b",
            "postgres", "HXN06MONKEY"
        );
%>

<%
            String action = request.getParameter("action");
            SimpleDateFormat sdf = new SimpleDateFormat("hh:mm a");

            if (action != null && action.equals("update")) {
                conn.setAutoCommit(false);

                PreparedStatement classes = conn.prepareStatement(
                ("UPDATE CLASSES SET Enroll_Limit = ? WHERE Section_ID = ?"));

                PreparedStatement offers = conn.prepareStatement(
                ("UPDATE OFFERING SET Course_ID = ?, Term = ?, Year_C = ?, Title = ? WHERE Section_ID = ?"));

                classes.setInt(1, Integer.parseInt(request.getParameter("Limit")));
                classes.setString(2, request.getParameter("hiddenSID"));
                classes.executeUpdate();

                classes.close();

                if (request.getParameter("Number") != null){
                    offers.setString(1, request.getParameter("Number"));
                    offers.setString(2, request.getParameter("Term"));
                    offers.setInt(3, Integer.parseInt(request.getParameter("Year")));
                    offers.setString(4, request.getParameter("Title"));
                    offers.setString(5, request.getParameter("hiddenSID"));
                    offers.executeUpdate();

                    offers.close();
                }

                PreparedStatement sections = conn.prepareStatement(
                    ("UPDATE CLASSES_SECTIONS SET Mandatory = ?, Days_C = ?, Start_Time = ?, End_Time = ?, Building = ?, Room = ?, Instructor = ? WHERE Section_ID = ? AND Type_M = ?"));
                
                String[] meeting = request.getParameterValues("Type");
                String[] mandatory = request.getParameterValues("Mandatory");
                String[] days = request.getParameterValues("Day");
                String[] time = request.getParameterValues("Start_time");
                String[] time1 = request.getParameterValues("End_time");
                String[] building = request.getParameterValues("Building");
                String[] room = request.getParameterValues("Room");

                for(int i = 0; i < meeting.length; i++) {
                    sections.setString(1, mandatory[i]);
                    sections.setString(2, days[i]);
                    java.util.Date parsedStartTime = sdf.parse(time[i]);
                    Time sqlStartTime = new Time(parsedStartTime.getTime());

                    java.util.Date parsedEndTime = sdf.parse(time1[i]);
                    Time sqlEndTime = new Time(parsedEndTime.getTime());

                    sections.setTime(3, sqlStartTime);
                    sections.setTime(4, sqlEndTime);

                    sections.setString(5, building[i]);
                    sections.setString(6, room[i]);
                    sections.setString(7, request.getParameter("Instructor"));
                    sections.setString(8, request.getParameter("hiddenSID"));
                    sections.setString(9, meeting[i]);
                    sections.executeUpdate();
                }

                sections.close();



                conn.commit();
                conn.setAutoCommit(true);
            }
        %>

        <%-- Close Statement Code --%>
        <%
                // Close the ResultSet
                //rs.close();
    
                // Close the Statement
                //statement.close();
    
                // Close the Connection
    
            } catch (SQLException sqle) {
                conn.rollback();
                stop = true;
                out.println(sqle.getMessage());
             } catch (Exception e) {
                conn.rollback();
                stop=true;
                out.println(e.getMessage());
            } finally {
                conn.close();
                if(!stop){
                    response.sendRedirect("classes.jsp");
                }
            }
        %>