<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CSE 132B Project</title>
    <script src="../script.js"></script>
    
</head>




<body>
    <jsp:include page="../index.html" />

    <div id="dropdown" style="margin-top: 3%; text-align: center;">
        <label for="degree_type">Please Select Type of Degrees: </label>
        <select id="degree_type" onchange="redirectToPage(this)">
            <option> </option>
            <option value="undergrad_degree.jsp">Bachelor</option>
            <option value="ms_degree.jsp">MS Degree</option>
        </select>
    </div>

    <script>
        function redirectToPage(selectElement) {
            var selectedPage = selectElement.value;
            window.location.href = selectedPage;
        }
    </script>




</body>
</html>