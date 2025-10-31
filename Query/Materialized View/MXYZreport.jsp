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
            width: 50%;
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

        String action = request.getParameter("action");

        if (action != null && action.equals("Search")) {

            String cid = request.getParameter("courseNum");
            String professor = request.getParameter("professor");
            String quarter = request.getParameter("quarter");
            String year = request.getParameter("year");

            String grades = "Select * from CPQG WHERE Course_Num = ? AND Term = ? AND Year_C = ? AND Instructor = ? AND N_Grade = ?";
            
            int A = 0;
            int B = 0;
            int C = 0;
            int D = 0;
            int O = 0;
            PreparedStatement grades_s = conn.prepareStatement(grades);
            

    %>

    <p style="text-align: center;"> Grade Distribution of <%= cid %> Taught by <%= professor %> in <%= quarter %> <%= year %></p>

    <div>
        <table id="display">
            <tr id="main_row">
                <th style="width:5%;">Course Number</th>
                <th style="width:5%;">Professor</th>
                <th style="width:3%;">Quarter</th>
                <th style="width:3%;">Year</th>
                <th style="width:3%;">#A</th>
                <th style="width:3%;">#B</th>
                <th style="width:3%;">#C</th>
                <th style="width:3%;">#D</th>
                <th style="width:3%;">#Other</th>
            </tr>
            
            <tr>
                <td><%= cid %></td>
                <td><%= professor %></td>
                <td><%= quarter %></td>
                <td><%= year %></td>
                <% 
                grades_s.setString(1, cid);
                grades_s.setString(2, quarter);
                grades_s.setInt(3, Integer.parseInt(year));
                grades_s.setString(4, professor);
                grades_s.setString(5, "A");
                ResultSet grades_rs = grades_s.executeQuery();
                if (grades_rs.next()){
                    A = grades_rs.getInt("Num");
                }

                %>
                <td><%= A %></td>
                <%
                grades_s.setString(1, cid);
                grades_s.setString(2, quarter);
                grades_s.setInt(3, Integer.parseInt(year));
                grades_s.setString(4, professor);
                grades_s.setString(5, "B");
                grades_rs = grades_s.executeQuery();
                if (grades_rs.next()){
                    B = grades_rs.getInt("Num");
                }
                %>
                <td><%= B %></td>
                <%
                grades_s.setString(1, cid);
                grades_s.setString(2, quarter);
                grades_s.setInt(3, Integer.parseInt(year));
                grades_s.setString(4, professor);
                grades_s.setString(5, "C");
                grades_rs = grades_s.executeQuery();
                if (grades_rs.next()){
                    C = grades_rs.getInt("Num");
                }
                %>
                <td><%= C %></td>
                <%
                grades_s.setString(1, cid);
                grades_s.setString(2, quarter);
                grades_s.setInt(3, Integer.parseInt(year));
                grades_s.setString(4, professor);
                grades_s.setString(5, "D");
                grades_rs = grades_s.executeQuery();
                if (grades_rs.next()){
                    D = grades_rs.getInt("Num");
                }
                %>
                <td><%= D %></td>
                <%
                grades_s.setString(1, cid);
                grades_s.setString(2, quarter);
                grades_s.setInt(3, Integer.parseInt(year));
                grades_s.setString(4, professor);
                grades_s.setString(5, "O");
                grades_rs = grades_s.executeQuery();
                if (grades_rs.next()){
                    O = grades_rs.getInt("Num");
                }
                %>
                <td><%= O %></td>
            </tr>

        </table>
    </div>

        <%
            grades_rs.close();
            grades_s.close();
        %>

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