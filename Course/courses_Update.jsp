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

            if (action != null && action.equals("update")) {
                conn.setAutoCommit(false);

                PreparedStatement prereq_delete_stmt = conn.prepareStatement(
                "DELETE FROM COURSE_PREREQ WHERE Course_ID = ?");

                PreparedStatement units_delete_stmt = conn.prepareStatement(
                "DELETE FROM COURSE_UNITS WHERE Course_ID = ?");

                PreparedStatement oldnum_delete_stmt = conn.prepareStatement(
                "DELETE FROM COURSE_OLDNUM WHERE Course_ID = ?");

                PreparedStatement coreq_delete_stmt = conn.prepareStatement(
                "DELETE FROM COURSE_COREQ WHERE Course_ID = ?");

                PreparedStatement grades_delete_stmt = conn.prepareStatement(
                "DELETE FROM GRADE_OPTIONS WHERE Course_ID = ?");

                PreparedStatement cate_delete_stmt = conn.prepareStatement(
                "DELETE FROM COURSE_CATEGORY WHERE Course_ID = ?");

                prereq_delete_stmt.setString(1, request.getParameter("hiddenNum"));
                units_delete_stmt.setString(1, request.getParameter("hiddenNum"));
                oldnum_delete_stmt.setString(1, request.getParameter("hiddenNum"));
                coreq_delete_stmt.setString(1, request.getParameter("hiddenNum"));
                grades_delete_stmt.setString(1, request.getParameter("hiddenNum"));
                cate_delete_stmt.setString(1, request.getParameter("hiddenNum"));

                
                prereq_delete_stmt.executeUpdate();
                units_delete_stmt.executeUpdate();
                oldnum_delete_stmt.executeUpdate();
                coreq_delete_stmt.executeUpdate();
                grades_delete_stmt.executeUpdate();
                cate_delete_stmt.executeUpdate();

                prereq_delete_stmt.close();
                units_delete_stmt.close();
                oldnum_delete_stmt.close();
                coreq_delete_stmt.close();
                grades_delete_stmt.close();
                cate_delete_stmt.close();

                PreparedStatement cstmt = conn.prepareStatement(
                ("UPDATE COURSES SET Department = ?, Consent = ?, LabReq = ? WHERE Numbers = ?"));

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

                cstmt.setString(1, request.getParameter("Department"));
                cstmt.setString(2, request.getParameter("Consent"));
                cstmt.setString(3, request.getParameter("LabReq"));
                cstmt.setString(4, request.getParameter("hiddenNum"));

                cstmt.executeUpdate();

                cstmt.close();

                String pre = request.getParameter("Prerequisites").trim();

                if (pre.length() > 0){
                    String[] preArray = pre.split(",");
                
                    for (String unit : preArray) {
                        prestmt.setString(1, request.getParameter("hiddenNum"));
                        prestmt.setString(2, unit.trim());
                        prestmt.executeUpdate();
                    }
                }
                prestmt.close();

                String course_units = request.getParameter("Units").trim();

                if (course_units.length() > 0){
                    String[] course_units_StringArray = course_units.split(",");

                    int[] course_units_Array = new int[course_units_StringArray.length];

                    for (int i = 0; i < course_units_StringArray.length; i++) {
                        course_units_Array[i] = Integer.parseInt(course_units_StringArray[i].trim());
                    }
                
                    for (int unit : course_units_Array) {
                        unitstmt.setString(1, request.getParameter("hiddenNum"));
                        unitstmt.setInt(2, unit);
                        unitstmt.executeUpdate();
                    }
                }
                unitstmt.close();

                String course_grades = request.getParameter("Grades").trim();

                if (course_grades.length() > 0){
                    String[] course_grades_Array = course_grades.split(",");

                    for (String unit : course_grades_Array) {
                        gradestmt.setString(1, request.getParameter("hiddenNum"));
                        gradestmt.setString(2, unit.trim());
                        gradestmt.executeUpdate();
                    }
                }
                gradestmt.close();

                String course_coreq = request.getParameter("COREQ_ID").trim();

                if (course_coreq.length() > 0){
                    String[] course_coreq_Array = course_coreq.split(",");

                    for (String unit : course_coreq_Array) {
                        coreqstmt.setString(1, request.getParameter("hiddenNum"));
                        coreqstmt.setString(2, unit.trim());
                        coreqstmt.executeUpdate();
                    }
                }
                coreqstmt.close();

                String course_oldnum = request.getParameter("OLD_NUMBERS").trim();

                if (course_oldnum.length() > 0){
                    String[] course_oldnum_Array = course_oldnum.split(",");

                    for (String unit : course_oldnum_Array) {
                        oldnumstmt.setString(1, request.getParameter("hiddenNum"));
                        oldnumstmt.setString(2, unit.trim());
                        oldnumstmt.executeUpdate();
                    }
                }
                oldnumstmt.close();

                String cates = request.getParameter("CATEGORY").trim();

                if (cates.length() > 0){
                    String[] cates_Array = cates.split(",");

                    for (String cate : cates_Array) {
                        catestmt.setString(1, request.getParameter("hiddenNum"));
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