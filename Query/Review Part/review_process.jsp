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
        conn.setAutoCommit(false);

        String action = request.getParameter("action");

        if (action != null && action.equals("Search")) {

            String viewPara = request.getParameter("s_id_info");

            String dropSepView = "DROP VIEW IF EXISTS sep;";
            String dropNotSepView = "DROP VIEW IF EXISTS not_sep CASCADE;";

            PreparedStatement dropSepStmt = conn.prepareStatement(dropSepView);
            dropSepStmt.executeUpdate();

            PreparedStatement dropNotSepStmt = conn.prepareStatement(dropNotSepView);
            dropNotSepStmt.executeUpdate();

            String non_sep = "CREATE VIEW not_sep AS " +
                 "WITH all_stu AS ( " +
                 "    SELECT Student_ID " +
                 "    FROM Enroll " +
                 "    WHERE Section_ID = '" + viewPara + "' "+
                 "), " +
                 "all_section AS ( " +
                 "    SELECT DISTINCT Section_ID " +
                 "    FROM Enroll e1 " +
                 "    JOIN all_stu a1 ON e1.Student_ID = a1.Student_ID " +
                 "    WHERE e1.Term = 'SPRING' AND e1.Year = 2018 " +
                 "), " +
                 "c_time AS ( " +
                 "    SELECT DISTINCT c1.Section_ID, c1.Days_C AS days, " +
                 "        CASE " +
                 "            WHEN EXTRACT(MINUTE FROM c1.start_time) = 0 THEN c1.start_time " +
                 "            ELSE date_trunc('hour', c1.start_time - interval '1 minute')::time " +
                 "        END AS start_time, " +
                 "        CASE " +
                 "            WHEN EXTRACT(MINUTE FROM c1.end_time) = 0 THEN c1.end_time " +
                 "            ELSE date_trunc('hour', c1.end_time + interval '1 hour')::time " +
                 "        END AS end_time " +
                 "    FROM all_section a1 " +
                 "    JOIN Classes_Sections c1 ON a1.Section_ID = c1.Section_ID " +
                 "), " +
                 "c_review AS ( " +
                 "    SELECT r1.Section_ID, TO_CHAR(TO_DATE(r1.Dates, 'MM/DD/YYYY'), 'Dy') AS day, r1.start_time, r1.end_time " +
                 "    FROM all_section a1 " +
                 "    JOIN review r1 ON a1.Section_ID = r1.Section_ID " +
                 "), " +
                 "separated_days AS ( " +
                 "    SELECT section_id, " +
                 "           unnest(regexp_split_to_array( " +
                 "               regexp_replace(days, 'Th', 'Q', 'g'), '')) AS day, " +
                 "           start_time, " +
                 "           end_time " +
                 "    FROM c_time " +
                 "), " +
                 "mapped_days AS ( " +
                 "    SELECT section_id, " +
                 "           CASE " +
                 "               WHEN day = 'M' THEN 'Mon' " +
                 "               WHEN day = 'T' THEN 'Tue' " +
                 "               WHEN day = 'W' THEN 'Wed' " +
                 "               WHEN day = 'Q' THEN 'Thu' " +
                 "               WHEN day = 'F' THEN 'Fri' " +
                 "           END AS day, " +
                 "           start_time, " +
                 "           end_time " +
                 "    FROM separated_days " +
                 "), " +
                 "result_dupp AS ( " +
                 "    SELECT * FROM mapped_days " +
                 "    UNION ALL " +
                 "    SELECT * FROM c_review " +
                 "), " +
                 "result_dup AS ( " +
                 "    SELECT DISTINCT * FROM result_dupp " +
                 ") " +
                 "SELECT * FROM result_dup;";



            PreparedStatement non_seps = conn.prepareStatement(non_sep);
            non_seps.executeUpdate();







                 String sep = "CREATE VIEW sep AS " +
                 "WITH RECURSIVE time_intervals AS ( " +
                 "  SELECT " +
                 "    section_ID, " +
                 "    day, " +
                 "    start_time, " +
                 "    start_time + interval '1 hour' AS next_time, " +
                 "    end_time " +
                 "  FROM not_sep " +
                 "  WHERE start_time < end_time " +
                 "  UNION ALL " +
                 "  SELECT " +
                 "    section_ID, " +
                 "    day, " +
                 "    next_time AS start_time, " +
                 "    next_time + interval '1 hour' AS next_time, " +
                 "    end_time " +
                 "  FROM time_intervals " +
                 "  WHERE next_time < end_time " +
                 ") " +
                 "SELECT " +
                 "  section_ID, " +
                 "  day, " +
                 "  start_time, " +
                 "  next_time AS end_time " +
                 "FROM time_intervals " +
                 "ORDER BY section_ID, day;";




            PreparedStatement seps = conn.prepareStatement(sep);
            seps.executeUpdate();


            String combine = "SELECT Days, Start_Time, End_Time " +
                 "FROM Review_sum " +
                 "WHERE (Days, Start_Time, End_Time) NOT IN( " +
                 "    SELECT s1.day, s1.start_time, s1.end_time " +
                 "    FROM sep s1 " +
                 "    WHERE s1.day = Days AND s1.start_time = Start_Time AND s1.end_time = End_Time " +
                 ");";


            PreparedStatement result = conn.prepareStatement(combine);

    

             String range = "WITH RECURSIVE dates AS ( " +
             "  SELECT TO_DATE(? , 'MM/DD/YYYY') AS date_val, " +
             "         TO_CHAR(TO_DATE(?, 'MM/DD/YYYY'), 'Mon DD') AS date_display, " +
             "         TO_CHAR(TO_DATE(?, 'MM/DD/YYYY'), 'Dy') AS day " +
             "  UNION ALL " +
             "  SELECT date_val + 1, " +
             "         TO_CHAR(date_val + 1, 'Mon DD'), " +
             "         TO_CHAR(date_val + 1, 'Dy') " +
             "  FROM dates " +
             "  WHERE date_val < TO_DATE(?, 'MM/DD/YYYY') " +
             ") " +
             "SELECT date_display, day " +
             "FROM dates;";


            PreparedStatement range1 = conn.prepareStatement(range);

            range1.setString(1, request.getParameter("start_date"));
            range1.setString(2, request.getParameter("start_date"));
            range1.setString(3, request.getParameter("start_date"));
            range1.setString(4, request.getParameter("end_date"));


            ResultSet range_rs = range1.executeQuery();

            


            conn.commit();
            conn.setAutoCommit(true);

    %>

    <p style="text-align: center;">All Available Review Sections For Section <%=request.getParameter("s_id_info")%></p>

    <div style="margin-left: auto; margin-right: auto; text-align: center;">

        <% while(range_rs.next()) { %>
            <% ResultSet result_rs = result.executeQuery();%>
            <% while(result_rs.next()) { 
                if(range_rs.getString("day").equals(result_rs.getString("days"))) {    
            %>

                    <p><span style="color:lightblue"><%=range_rs.getString("date_display")%> 
                        <%=range_rs.getString("day")%></span> 
                        <span style="color:green; font-weight: normal;"><%=result_rs.getString("start_time")%> ~ 
                        <%=result_rs.getString("end_time")%></span>
                    </p>

                <%
                    }
                %>
            <%
                }
            %>

        <%
            }
        %>

           
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