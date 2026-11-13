<?php
    
?>

<!DOCTYPE html>
<html>
    <head>
        <!-- html comment -->
        <title>Lunar Sleep Shift Scheduling Tool</title>
        <link rel="icon" type="image/png" href="ZZZNASA.png">
        <script src="app.js"></script>

        <style>
            body {
                background-color: white;
            }
            p {
                
            }
            h1, h2, h3, h4 {
            
            }
            ol li {
            
            }
            body td {
                padding: 50px;
                border: 50px;
                background-color: brown;
            }
            
            .error {
                color: red;
                font-size: 14px;
                margin: 0;
            }
            
            
            .pseudo-button {
                display: inline-block;
    
                /* dimensions */
                width: 200px; 
                padding: 10px 0; /* Padding on top/bottom only so it doesn't break the width */
                
                /* Handle text that is too long */
                white-space: nowrap;       /* Prevents text from wrapping to a second line */
                overflow: hidden;          /* Hides any text that overflows the width */
                
                /* Style and feedback */
                background-color: #007BFF;
                color: #ffffff;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
                text-align: center; /* Centers the text perfectly inside the fixed width */
                cursor: pointer;
                transition: background 0.2s ease-in-out;
            }
            /* Hover state for feedback */
            .pseudo-button:hover {
                background-color: #0056b3;
                color: #ffffff;
            }
            
            /* Active state for when it is clicked */
            .pseudo-button:active {
                transform: scale(0.98);
            }
            
            /* FORMS */
            
            .question_form {
                display: flex;
                flex-direction: column;
                gap: 20px;
                max-width: 400px;
            }
            
            .form-group {
                display: flex;
                flex-direction: column;
                gap: 12px;
            }
            
            .form-group input {
                padding: 12px;
                box-sizing: border-box;
                width: 100%;
            }
            
            /* STARS */
            
            .star-rating {
                display: flex;
                flex-direction: row-reverse;
                justify-content: flex-end;
            }
            
            .star-rating input {
                display: none;
            }
            
            .star-box {
                border: 1px solid #ccc;
                border-radius: 10px;
                padding: 12px;
                display: inline-block;
                width: fit-content;
            }
            
            .star-rating label {
                font-size: 35px;
                color: #ccc;
                cursor: pointer;
            }
            
            .star-rating input:checked ~ label,
            .star-rating label:hover,
            .star-rating label:hover ~ label {
                color: gold;
            }
            
            
            
            
            .multiple-options {
                display: flex;
                gap: 15px;
            }
            
            .multiple-option {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 12px 20px;
                border: 1px solid #ccc;
                border-radius: 8px;
                cursor: pointer;
                background-color: white;
                transition: 0.2s;
            }
            
            .multiple-option:hover {
                background-color: #f0f4f8;
                border-color: #3976a8;
            }
            
            .multiple-option input {
                cursor: pointer;
                accent-color: #3976a8;
            }
        </style>

    </head>
    <body>