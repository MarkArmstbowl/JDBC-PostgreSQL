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

<%
            String action = request.getParameter("action");

            if (action != null && action.equals("insert")) {
                conn.setAutoCommit(false);

                PreparedStatement cstmt = conn.prepareStatement(
                ("INSERT INTO COURSES VALUES (?, ?, ?, ?)"));

                PreparedStatement prestmt = conn.prepareStatement(
                ("INSERT INTO COURSE_PREREQ VALUES (?, ?)"));
                
                PreparedStatement unitstmt = conn.prepareStatement(
                ("INSERT INTO COURSE_UNITS VALUES (?, ?)"));

                PreparedStatement gradestmt = conn.prepareStatement(
                ("INSERT INTO GRADE_OPTIONS VALUES (?, ?)"));

                PreparedStatement coreqstmt = conn.prepareStatement(
                ("INSERT INTO COURSE_COREQ VALUES (?, ?)"));

                PreparedStatement oldnumstmt = conn.prepareStatement(
                ("INSERT INTO COURSE_OLDNUM VALUES (?, ?)"));

                PreparedStatement catestmt = conn.prepareStatement(
                ("INSERT INTO COURSE_CATEGORY VALUES (?, ?)"));

                
                cstmt.setString(1, request.getParameter("numbers"));
                cstmt.setString(2, request.getParameter("department"));
                cstmt.setString(3, request.getParameter("consent"));
                cstmt.setString(4, request.getParameter("lab"));

                cstmt.executeUpdate();

                cstmt.close();

                
                String pre = request.getParameter("preRequisites").trim();
                if (pre.length() > 0){
                    String[] preArray = pre.split(",");
                
                    for (String unit : preArray) {
                        prestmt.setString(1, request.getParameter("numbers"));
                        prestmt.setString(2, unit.trim());
                        prestmt.executeUpdate();
                    }
                }

                prestmt.close();


                
                String course_units = request.getParameter("units").trim();
                if (course_units.length() > 0){
                    String[] course_units_StringArray = course_units.split(",");

                    int[] course_units_Array = new int[course_units_StringArray.length];

                    for (int i = 0; i < course_units_StringArray.length; i++) {
                        course_units_Array[i] = Integer.parseInt(course_units_StringArray[i].trim());
                    }
                
                    for (int unit : course_units_Array) {
                        unitstmt.setString(1, request.getParameter("numbers"));
                        unitstmt.setInt(2, unit);
                        unitstmt.executeUpdate();
                    }
                }

                unitstmt.close();



                
                String course_grades = request.getParameter("grades").trim();
                if (course_grades.length() > 0){
                    String[] course_grades_Array = course_grades.split(",");

                    for (String unit : course_grades_Array) {
                        gradestmt.setString(1, request.getParameter("numbers"));
                        gradestmt.setString(2, unit.trim());
                        gradestmt.executeUpdate();
                    }
                }

                gradestmt.close();

                String course_coreq = request.getParameter("coreq").trim();
                if (course_coreq.length() > 0){
                    String[] course_coreq_Array = course_coreq.split(",");

                    for (String unit : course_coreq_Array) {
                        coreqstmt.setString(1, request.getParameter("numbers"));
                        coreqstmt.setString(2, unit.trim());
                        coreqstmt.executeUpdate();
                    }
                }

                coreqstmt.close();



                
                String course_oldnum = request.getParameter("previous").trim();
                if (course_oldnum.length() > 0){
                    String[] course_oldnum_Array = course_oldnum.split(",");

                    for (String unit : course_oldnum_Array) {
                        oldnumstmt.setString(1, request.getParameter("numbers"));
                        oldnumstmt.setString(2, unit.trim());
                        oldnumstmt.executeUpdate();
                    }
                }
                
                oldnumstmt.close();


                String course_cates = request.getParameter("cate").trim();
                if (course_cates.length() > 0){
                    String[] course_cates_Array = course_cates.split(",");

                    for (String cate : course_cates_Array) {
                        catestmt.setString(1, request.getParameter("numbers"));
                        catestmt.setString(2, cate.trim());
                        catestmt.executeUpdate();
                    }
                }
                
                catestmt.close();

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
                conn.close();
    
            } catch (SQLException sqle) {
                out.println(sqle.getMessage());
                } catch (Exception e) {
                out.println(e.getMessage());
                }
            response.sendRedirect("courses.jsp");
        %>