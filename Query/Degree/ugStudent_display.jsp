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

            String sid = request.getParameter("s_id_info");
            String dep = request.getParameter("dep_info");

            String taken = "SELECT * FROM TAKEN WHERE Student_ID = ?";
            String degree = "SELECT * FROM UnderGrad_Degree WHERE DEPARTMENT = ?";
            
            PreparedStatement taken_s = conn.prepareStatement(taken);
            taken_s.setString(1, sid);
            ResultSet taken_rs = taken_s.executeQuery();

            PreparedStatement degree_s = conn.prepareStatement(degree);
            degree_s.setString(1, dep);
            ResultSet degree_rs = degree_s.executeQuery();

            int lower = 0;
            int upper = 0;
            int elective = 0;

            while (taken_rs.next()){
                String course = taken_rs.getString("Course_Num");
                int unit = taken_rs.getInt("Unit");

                String category_low = "SELECT count(*) FROM COURSE_CATEGORY WHERE Course_ID = ? AND Category = 'Lower'";
                PreparedStatement category_low_s = conn.prepareStatement(category_low);
                category_low_s.setString(1, course);

                String category_up = "SELECT count(*) FROM COURSE_CATEGORY WHERE Course_ID = ? AND Category = 'Upper'";
                PreparedStatement category_up_s = conn.prepareStatement(category_up);
                category_up_s.setString(1, course);
            
                String category_elec = "SELECT count(*) FROM COURSE_CATEGORY WHERE Course_ID = ? AND Category = 'Elective'";
                PreparedStatement category_elec_s = conn.prepareStatement(category_elec);
                category_elec_s.setString(1, course);

                ResultSet low_rs = category_low_s.executeQuery();
                low_rs.next();
                if (low_rs.getInt(1) != 0){
                    lower = lower + unit;
                }

                ResultSet up_rs = category_up_s.executeQuery();
                up_rs.next();
                if (up_rs.getInt(1) != 0){
                    upper = upper + unit;
                }

                ResultSet elec_rs = category_elec_s.executeQuery();
                elec_rs.next();
                if (elec_rs.getInt(1) != 0){
                    elective = elective + unit;
                }

                category_low_s.close();
                category_up_s.close();
                category_elec_s.close();
                low_rs.close();
                up_rs.close();
                elec_rs.close();
            }
            
            degree_rs.next();
            int lower_required = degree_rs.getInt("LowerD") - lower;
            int upper_required = degree_rs.getInt("UpperD") - upper;
            int elective_required = degree_rs.getInt("ElectiveD") - elective;

            if (lower_required < 0){
                lower_required = 0;
            }
            if (upper_required < 0){
                upper_required = 0;
            }
            if (elective_required < 0){
                elective_required = 0;
            }

            int total_required = lower_required + upper_required + elective_required;

            taken_s.close();
            taken_rs.close();
            degree_s.close();
            degree_rs.close();
        
    %>

    <p style="text-align: center;"> Student <%= sid %> Degree Progress for Bachelor in <%= dep %></p>

    <div>
        <table id="display">
            <tr id="main_row">
                <th style="width:3%;">Student ID</th>
                <th style="width:3%;">Degree Department</th>
                <th style="width:5%;">Total Units Required</th>
                <th style="width:5%;">Lower Division Units Required</th>
                <th style="width:5%;">Upper Division Units Required</th>
                <th style="width:5%;">Technical Elective Units Required</th>
            </tr>

            <tr>
                <td><%= sid %></td>
                <td><%= dep %></td>
                <td><%= total_required %></td>
                <td><%= lower_required %></td>
                <td><%= upper_required %></td>
                <td><%= elective_required %></td>
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