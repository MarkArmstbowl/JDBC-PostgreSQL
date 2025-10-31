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

        PreparedStatement course = conn.prepareStatement(
            ("SELECT * FROM Offering WHERE Term = 'SPRING' AND Year_C = 2018"));

        ResultSet course_rs = course.executeQuery();

        conn.commit();
        conn.setAutoCommit(true);

    %>

    <div class="displayS">

        <label for="course">Please Select a Section</label>
        <br>
        <select id="course" >
            <option></option>

            <% while(course_rs.next()) {%>

                <% 
                    String sid = course_rs.getString("Section_ID");
                    String course_id = course_rs.getString("Course_ID");
                    
                %>
                <option><%= sid + ", " + course_id %></option>

            <% } %>


        </select>

        <form action="review_process.jsp" method="get">
            <p>Please Enter Review Start Date</p>
            <input name="start_date" placeholder="05/28/2018">
            <p>Please Enter Review End Date</p>
            <input name="end_date" placeholder="06/01/2018">
            <input type="hidden" id="result" name="s_id_info">
            <br>
            <input type="submit" value="Search" name="action">
        </form>

        <script>
            var select1 = document.getElementById("course");
            
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
            course_rs.close();

            // Close the Statement
            course.close();

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