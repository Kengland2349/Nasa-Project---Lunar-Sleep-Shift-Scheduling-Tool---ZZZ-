<?php
    session_start();
    
    include 'connection.php';
    
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $formType = $_POST['form_type'] ?? '';
        if ($formType == 'logout') {
            $_SESSION = [];
            session_destroy();
            
            header('Location: index.php');
            exit;
        }
    }
    
    
    include 'header.php';
    
    if (!isset($_SESSION['user_ID'])) {
        if (isset($_SESSION['portalPage'])) {
            if ($_SESSION['portalPage'] == 'login') {
                include 'login.php';
            }
            else if ($_SESSION['portalPage'] == 'signUp') {
                include 'signUp.php';
            }
        }
        else {
            include 'portal.php';
        }
    } else {
        include 'mainPage.php';
    }
    
    if (isset($_SESSION['message'])) {
        echo htmlspecialchars($_SESSION['message']);
        unset($_SESSION['message']);
    }
    
    
?>


<script>
    function test() {
        console.log("testing scripts and functions");
    }
    
    setInterval(test, 5000);
</script>
    