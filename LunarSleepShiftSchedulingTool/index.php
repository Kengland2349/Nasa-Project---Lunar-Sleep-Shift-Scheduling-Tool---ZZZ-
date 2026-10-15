<?php
    session_start();
    
    include 'connection.php';
    
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'logout') {
        
        $_SESSION = [];
        session_destroy();
        
        header('Location: index.php');
        exit;
    }
    
    include 'header.php';
    
    if (!isset($_SESSION['user_ID'])) {
        include 'login.php';
    } else {
        include 'mainPage.php';
    }
    
    
?>


<script>
    function test() {
        console.log("testing scripts and functions");
    }
    
    setInterval(test, 5000);
</script>
    