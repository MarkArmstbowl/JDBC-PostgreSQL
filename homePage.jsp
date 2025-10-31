<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>CSE 132B Project</title>
    <script src="/CSE132B/script.js"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }

        #second_div{
            margin-top: 10px;
        }

        .unordered_list {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        .unordered_list li{
            display: inline-block;
            margin-right: 5%;
            border-radius: 10px;
            padding-left: 20px;
            padding-right: 20px;
        }

        .unordered_list li:hover{
            background-color: orange;
        }

        .unordered_list li a{
            text-decoration: none;
        }

        .main_container {
            text-align: center;
        }

        h1, h2 {
            color: black;
            text-align: center;
        }
        h2{
            font-size: 15px;
            margin-top: 0px;
            color: lightblue;
        }
        h1{
            margin-bottom: 0px;
        }
    </style>
</head>





<body>
    <jsp:include page="index.html"/>

    <div style="text-align: center; margin-top: 5%;">
        <p style="font-size: 3rem; color:brown;">Welcome to Our DataBase!</p>
        <img src="/CSE132B/database.png" alt="Example image">
    </div>


 
</body>
</html>