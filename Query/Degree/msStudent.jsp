<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CSE 132B Project</title>
    <script src="../../script.js"></script>

    <style>
        .displayS {
            margin-left: auto;
            margin-right: auto;
            text-align: center;
            margin-top: 3%;
        }
        .displayS select {
            width: 200px;
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
            "SELECT s1.Student_ID, s1.SSN, s1.First_Name, s1.Middle_Name, s1.Last_Name " +
            "FROM STUDENT s1, STUDENT_GRADUATE g1 " +
            "WHERE s1.Student_ID = g1.Student_ID " +
            "AND s1.Enroll = 'Enrolled'"
        );
        
        PreparedStatement ms = conn.prepareStatement(
            ("SELECT DISTINCT Department FROM MS_Degree"));

        ResultSet student_rs = student.executeQuery();
        ResultSet ms_rs = ms.executeQuery();


        conn.commit();
        conn.setAutoCommit(true);

    %>

    <div class="displayS">

        <label for="student">Please Select Graduate Student </label> <br>
        <select id="student">
            <option></option>

            <% while(student_rs.next()) {%>

                <% 
                    String ssn = student_rs.getString("SSN");
                    String fn = student_rs.getString("First_Name");
                    String mn = student_rs.getString("Middle_Name");
                    String ln = student_rs.getString("Last_Name");
                    String sid = student_rs.getString("Student_ID");
                    
                %>
                <option><%= sid + ", " + ssn + ", " + fn + " " + mn + " " + ln%></option>

            <% } %>


        </select>

        <br><br>


        <label for="msdegree">Please Select MS Degree </label> <br>
        <select id="msdegree" >
            <option></option>

            <% while(ms_rs.next()) {%>

                <% 
                    String dep = ms_rs.getString("Department");
                %>
                <option><%= dep %></option>

            <% } %>


        </select>
        

        <script>
            var select1 = document.getElementById("student");
            var select2 = document.getElementById("msdegree");
            
            select1.addEventListener("change", function() {
                
                var selectedValue = select1.value;

                var valuesArray = selectedValue.split(", ");
                
                var firstValue = valuesArray[0];
                
                var result = document.getElementById("result");
                result.value = firstValue;
            });

            select2.addEventListener("change", function() {
                
                var selectedValue = select2.value;                
                
                var result = document.getElementById("depres");

                result.value = selectedValue;
            });


        </script>


        <form action="msStudent_display.jsp" method="get">
            <input type="hidden" id="result" name="s_id_info">
            <input type="hidden" id="depres" name="dep_info">
            <input type="submit" value="Search" name="action">
        </form>

        
    </div>


    

    <%-- Close Statement Code --%>
    <%
            // Close the ResultSet
            student_rs.close();
            ms_rs.close();

            // Close the Statement
            student.close();
            ms.close();

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