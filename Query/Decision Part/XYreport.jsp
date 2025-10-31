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

            String grades = "SELECT DISTINCT t.Student_ID, t.Course_Num, t.Grade, t.Unit FROM TAKEN t, OFFERING o, CLASSES_SECTIONS c WHERE c.Instructor = ? AND c.Section_ID = o.Section_ID AND o.Course_ID = ? AND o.Section_ID = t.Section_ID";
            
            PreparedStatement grades_s = conn.prepareStatement(grades);
            grades_s.setString(1, professor);
            grades_s.setString(2, cid);
            ResultSet grades_rs = grades_s.executeQuery();

            int countA = 0;
            int countB = 0;
            int countC = 0;
            int countD = 0;
            int countElse = 0;

            Double totalPoints = 0.00;
            int totalUnits = 0;

            while (grades_rs.next()){
                String grade = grades_rs.getString("Grade").trim();
                int unit = grades_rs.getInt("Unit");

                String conversion = "SELECT NUMBER_GRADE FROM GRADE_CONVERSION WHERE LETTER_GRADE = ?";
                PreparedStatement conversion_s = conn.prepareStatement(conversion);
                if (grade.equals("A+") || grade.equals("A") || grade.equals("A-")){
                    totalUnits += unit;
                    conversion_s.setString(1, grade);
                    ResultSet conversion_rs = conversion_s.executeQuery();
                    conversion_rs.next();
                    totalPoints += unit * Double.parseDouble(conversion_rs.getString("NUMBER_GRADE"));
                    conversion_rs.close();
                    countA += 1;
                }else if (grade.equals("B+") || grade.equals("B") || grade.equals("B-")){
                    totalUnits += unit;
                    conversion_s.setString(1, grade);
                    ResultSet conversion_rs = conversion_s.executeQuery();
                    conversion_rs.next();
                    totalPoints += unit * Double.parseDouble(conversion_rs.getString("NUMBER_GRADE"));
                    conversion_rs.close();
                    countB += 1;
                }else if (grade.equals("C+") || grade.equals("C") || grade.equals("C-")){
                    totalUnits += unit;
                    conversion_s.setString(1, grade);
                    ResultSet conversion_rs = conversion_s.executeQuery();
                    conversion_rs.next();
                    totalPoints += unit * Double.parseDouble(conversion_rs.getString("NUMBER_GRADE"));
                    conversion_rs.close();
                    countC += 1;
                }else if (grade.equals("D")){
                    totalUnits += unit;
                    conversion_s.setString(1, grade);
                    ResultSet conversion_rs = conversion_s.executeQuery();
                    conversion_rs.next();
                    totalPoints += unit * Double.parseDouble(conversion_rs.getString("NUMBER_GRADE"));
                    conversion_rs.close();
                    countD += 1;
                }else{
                    countElse += 1;
                }
                conversion_s.close();
            }

            double gpa = totalPoints / totalUnits;
            
            grades_rs.close();
            grades_s.close();
    %>

    <p style="text-align: center;"> Grade Distribution of <%= cid %> Taught by <%= professor %> in Past Years</p>

    <div>
        <table id="display">
            <tr id="main_row">
                <th style="width:5%;">Course Number</th>
                <th style="width:5%;">Professor</th>
                <th style="width:3%;">#A</th>
                <th style="width:3%;">#B</th>
                <th style="width:3%;">#C</th>
                <th style="width:3%;">#D</th>
                <th style="width:3%;">#Other</th>
                <th style="width:3%;">Average GPA</th>
            </tr>

            <tr>
                <td><%= cid %></td>
                <td><%= professor %></td>
                <td><%= countA %></td>
                <td><%= countB %></td>
                <td><%= countC %></td>
                <td><%= countD %></td>
                <td><%= countElse %></td>
                <td><%= gpa %></td>
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