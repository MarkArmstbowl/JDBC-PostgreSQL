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

            String sql = "WITH current AS ( " +
             "    SELECT c1.Section_ID AS id1, " +
             "           UNNEST(STRING_TO_ARRAY(c1.Days_C, '')) AS day1, " +
             "           c1.Start_Time AS s1, " +
             "           c1.End_Time AS e1 " +
             "    FROM enroll e1 " +
             "    JOIN classes_sections c1 ON c1.section_ID = e1.section_ID " +
             "    JOIN offering o1 ON c1.section_ID = o1.section_ID " +
             "    WHERE e1.Student_ID = ? " +
             "      AND o1.Year_C = 2018 " +
             "      AND o1.Term = 'SPRING' " +
             "    ORDER BY c1.Section_ID " +
             "), " +
             "All1 AS ( " +
             "    SELECT DISTINCT c2.Section_ID AS id2, " +
             "                    c2.Type_M AS t2, " +
             "                    c2.Days_C AS day2, " +
             "                    c2.Start_Time AS s2, " +
             "                    c2.End_Time AS e2 " +
             "    FROM offering o2 " +
             "    JOIN classes_sections c2 ON o2.section_ID = c2.section_ID " +
             "    WHERE o2.Year_C = 2018 " +
             "      AND o2.Term = 'SPRING' " +
             "      AND c2.Section_ID NOT IN ( " +
             "          SELECT id1 " +
             "          FROM current " +
             "      ) " +
             "    ORDER BY c2.Section_ID " +
             "), " +
             "conflict_time AS ( " +
             "    SELECT DISTINCT a1.id2, a1.t2, a1.day2, a1.s2, a1.e2, c1.id1, c1.day1, c1.s1, c1.e1 " +
             "    FROM All1 a1, current c1 " +
             "    WHERE NOT (c1.e1 <= a1.s2 OR c1.s1 >= a1.e2) " +
             ") " +
             "SELECT c1.id2, c1.day2, c1.id1, c1.day1 " + 
             "FROM conflict_time c1 ";

            PreparedStatement result = conn.prepareStatement(sql);

            

            result.setString(1, request.getParameter("s_id_info"));

            ResultSet result_rs = result.executeQuery();

            
            ArrayList<String> cannot_id = new ArrayList<>();
            ArrayList<String> cannot_days = new ArrayList<>();
            ArrayList<String> taking_id = new ArrayList<>();
            ArrayList<String> taking_days = new ArrayList<>();

            ArrayList<String> cannot_rid = new ArrayList<>();
            ArrayList<String> cannot_rday = new ArrayList<>();
            ArrayList<String> taking_rid = new ArrayList<>();
            ArrayList<String> taking_rday = new ArrayList<>();

            ArrayList<String> cannot_f = new ArrayList<>();
            ArrayList<String> cannot_fday = new ArrayList<>();
            ArrayList<String> taking_f = new ArrayList<>();
            ArrayList<String> taking_fday = new ArrayList<>();
            



            conn.commit();
            conn.setAutoCommit(true);

    %>

    <p style="text-align: center;">All Classes That Student <%=request.getParameter("s_id_info")%> Conflicts With</p>

    <div style="margin-left: auto; margin-right: auto; text-align: center;">

            <%
                while(result_rs.next() ) {
                    cannot_id.add(result_rs.getString("id2").trim());
                    cannot_days.add(result_rs.getString("day2").trim());
                    taking_id.add(result_rs.getString("id1").trim());
                    taking_days.add(result_rs.getString("day1").trim());
                
            %>
            <%
                }
            %>

            <%
                result_rs.close();
                result.close();
            %>
            <%
                for (int i = 0; i < taking_days.size(); i++) {
                    String day = taking_days.get(i);
                    day = day.replace("Th", "U");

                    String day1 = cannot_days.get(i);
                    day1 = day1.replace("Th", "U");

                    taking_days.set(i, day);
                    cannot_days.set(i, day1);
                }
            %>

            <%
                for (int i = 0; i < taking_days.size(); i++) {
                    String day1 = cannot_days.get(i);
                    String day2 = taking_days.get(i);
                    boolean contain = false;
            
                    for (char c : day1.toCharArray()) {
                        if (day2.contains(String.valueOf(c))) {
                            contain = true;
                            break;
                        }
                    }
            
                    if(contain) {
                        cannot_rid.add(cannot_id.get(i));
                        cannot_rday.add(cannot_days.get(i));
                        taking_rid.add(taking_id.get(i));
                        taking_rday.add(taking_days.get(i));
                    }
                }
            %>

            <%
                for(int i = 0; i < cannot_rid.size(); i++) {
                    boolean dub = false;

                    for(int j = i + 1; j < cannot_rid.size(); j++) {
                        if(cannot_rid.get(i).equals(cannot_rid.get(j))) {
                            if(taking_rid.get(i).equals(taking_rid.get(j))){
                                dub = true;
                                break;
                            }
                        }
                    }

                    if(!dub) {
                        cannot_f.add(cannot_rid.get(i));
                        cannot_fday.add(cannot_rday.get(i));
                        taking_f.add(taking_rid.get(i));
                        taking_fday.add(taking_rday.get(i));
                    }

                }

            %>
            
            <%
                for(int i = 0; i < cannot_f.size(); i++) {
                    conn.setAutoCommit(false);

                    PreparedStatement info = conn.prepareStatement(
                        ("SELECT * FROM Offering WHERE Section_ID = ?"));
                    
                    info.setString(1, cannot_f.get(i));

                    PreparedStatement info1 = conn.prepareStatement(
                        ("SELECT * FROM Offering WHERE Section_ID = ?"));
                    
                    info1.setString(1, taking_f.get(i));

                    ResultSet info_rs = info.executeQuery();
                    ResultSet info1_rs = info1.executeQuery();
            
                    conn.commit();
                    conn.setAutoCommit(true);

                    if(info_rs.next() && info1_rs.next()){
            %>
                    <p><span style="color:orange; font-weight: normal;">(<%=cannot_f.get(i)%> <%=info_rs.getString("Title")%> <%=info_rs.getString("Course_ID")%>)</span>  
                        <span style="color:red;">IS CONFLICT WITH</span> 
                        <span style="color:skyblue; font-weight: normal;">(<%=taking_f.get(i)%> <%=info1_rs.getString("Title")%> <%=info1_rs.getString("Course_ID")%>)</span>
                    </p>

                    <%}%>

            <%
                    info_rs.close();
                    info1_rs.close();
                    info.close();
                    info1.close();
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