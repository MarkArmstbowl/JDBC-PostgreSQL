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

    if (action != null && action.equals("INSERT INTO DATABASE")) {
        conn.setAutoCommit(false);

        PreparedStatement cs = conn.prepareStatement(
        ("INSERT INTO CLASSES VALUES (?, ?)"));

        PreparedStatement offers = conn.prepareStatement(
        ("INSERT INTO OFFERING VALUES (?, ?, ?, ?, ?)"));

        PreparedStatement sections = conn.prepareStatement(
        ("INSERT INTO CLASSES_SECTIONS VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"));

        PreparedStatement reviews = conn.prepareStatement(
        ("INSERT INTO REVIEW VALUES (?, ?, ?, ?, ?, ?)"));

        PreparedStatement exams = conn.prepareStatement(
        ("INSERT INTO EXAM VALUES (?, ?, ?, ?, ?, ?)"));



        cs.setString(1, request.getParameter("sectionID"));
        cs.setInt(2, Integer.parseInt(request.getParameter("enrollment")));
        cs.executeUpdate();

        cs.close();



        
        offers.setString(1, request.getParameter("sectionID"));
        offers.setString(2, request.getParameter("name"));
        offers.setString(3, request.getParameter("quarter"));
        offers.setInt(4, Integer.parseInt(request.getParameter("year")));
        offers.setString(5, request.getParameter("title"));
        offers.executeUpdate();

        offers.close();




        String[] meeting = request.getParameterValues("meeting_type");
        String[] mandatory = request.getParameterValues("mandatory");
        String[] days = request.getParameterValues("days");
        String[] time = request.getParameterValues("start_time");
        String[] time1 = request.getParameterValues("end_time");
        String[] building = request.getParameterValues("building");
        String[] room = request.getParameterValues("room");
        

        

        for(int i = 0; i < meeting.length; i++) {
            sections.setString(1, request.getParameter("sectionID"));
            sections.setString(2, meeting[i]);
            sections.setString(3, mandatory[i]);
            sections.setString(4, days[i]);

            java.util.Date parsedStartTime = sdf.parse(time[i]);
            Time sqlStartTime = new Time(parsedStartTime.getTime());

            java.util.Date parsedEndTime = sdf.parse(time1[i]);
            Time sqlEndTime = new Time(parsedEndTime.getTime());

            sections.setTime(5, sqlStartTime);
            sections.setTime(6, sqlEndTime);

            sections.setString(7, building[i]);
            sections.setString(8, room[i]);
            sections.setString(9, request.getParameter("instructor"));
            sections.executeUpdate();
        }

        sections.close();
        



        String[] review_date = request.getParameterValues("review-dates"); //[TEST, ""]
        String[] r_time = request.getParameterValues("review_start_time");
        String[] r_time1 = request.getParameterValues("review_end_time");
        String[] review_building = request.getParameterValues("review-building");
        String[] review_room = request.getParameterValues("review-room");

        for(int i = 0; i < review_date.length; i++) {
            if (review_date[i].length() > 0 && r_time[i].length() > 0 && r_time1[i].length() > 0 && review_building[i].length() > 0 && review_room[i].length() > 0){
                reviews.setString(1, request.getParameter("sectionID"));
                reviews.setString(2, review_date[i]);

                java.util.Date parsedStartTime = sdf.parse(r_time[i]);
                Time sqlStartTime = new Time(parsedStartTime.getTime());
    
                java.util.Date parsedEndTime = sdf.parse(r_time1[i]);
                Time sqlEndTime = new Time(parsedEndTime.getTime());
    
                reviews.setTime(3, sqlStartTime);
                reviews.setTime(4, sqlEndTime);

                reviews.setString(5, review_building[i]);
                reviews.setString(6, review_room[i]);
                reviews.executeUpdate();
            }
        }
        reviews.close();


        exams.setString(1, request.getParameter("sectionID"));
        exams.setString(2, request.getParameter("final-dates"));

        java.util.Date parsedStartTime = sdf.parse(request.getParameter("final_start_time"));
        Time sqlStartTime = new Time(parsedStartTime.getTime());

        java.util.Date parsedEndTime = sdf.parse(request.getParameter("final_end_time"));
        Time sqlEndTime = new Time(parsedEndTime.getTime());

        exams.setTime(3, sqlStartTime);
        exams.setTime(4, sqlEndTime);

        exams.setString(5, request.getParameter("final-building"));
        exams.setString(6, request.getParameter("final-room"));
        exams.executeUpdate();

        exams.close();

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

    } catch (SQLException sqle) {
        conn.rollback();
        stop = true;
        out.println(sqle.getMessage());

        } catch (Exception e) {
        conn.rollback();
        stop=true;
        out.println(e.getMessage());

        } finally {
            
            // Close the Connection
            conn.close();
            if(!stop){
                response.sendRedirect("classes.jsp");
            }
        }
%>