<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CSE 132B Project</title>
    <script src="../script.js"></script>

    <style>
        .displayS {
            margin-left: auto;
            margin-right: auto;
            text-align: center;
            margin-top: 3%;
        }

        #display {
            border-collapse: collapse;
            width: 100%;
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

    <%
        conn.setAutoCommit(false);

        PreparedStatement student = conn.prepareStatement(
            ("SELECT DISTINCT s1.Student_ID, s1.First_Name, s1.Middle_Name, s1.Last_Name FROM Student s1, Enroll e1 WHERE s1.Student_ID = e1.Student_ID"));

        ResultSet student_rs = student.executeQuery();

        conn.commit();
        conn.setAutoCommit(true);

    %>

    <div class="displayS">

        <label for="student">Please Select Student: </label>
        <select id="student" >
            <option></option>

            <% while(student_rs.next()) {%>

                <% 
                    String fn = student_rs.getString("First_Name");
                    String mn = student_rs.getString("Middle_Name");
                    String ln = student_rs.getString("Last_Name");
                    String sid = student_rs.getString("Student_ID");
                    
                %>
                <option><%= sid + ", " + fn + " " + mn + " " + ln%></option>

            <% } %>


        </select>

        <form action="student_schedule_process.jsp" method="get">
            <input type="hidden" id="result" name="s_id_info">
            <input type="submit" value="Search" name="action">
        </form>

        <script>
            var select1 = document.getElementById("student");
            
            select1.addEventListener("change", function() {
                
                var selectedValue = select1.value;

                var valuesArray = selectedValue.split(", ");
                
                var firstValue = valuesArray[0];
                
                var result = document.getElementById("result");
                result.value = firstValue;
            });
        </script>

        
    </div>


    

    <%-- Close Statement Code --%>
    <%
            // Close the ResultSet
            student_rs.close();

            // Close the Statement
            student.close();

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