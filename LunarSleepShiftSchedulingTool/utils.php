<?php
    function refreshMessage($text) {
        $_SESSION['message'] = "$text";
        header("Location: index.php");
        exit;
    }
    
    function refresh() {
        header("Location: index.php");
        exit;
    }
    

?>