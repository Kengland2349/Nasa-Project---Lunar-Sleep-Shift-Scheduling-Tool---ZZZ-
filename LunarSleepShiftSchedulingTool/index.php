<?php
    ob_start(); // buffers the PHP code
    session_start();
    
    /*echo '<pre>';
    var_dump($_SESSION);
    echo '</pre>';*/
    
    include 'connection.php';
    include 'header.php';
    include 'utils.php';
    
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $formType = $_POST['form_type'] ?? '';
        if ($formType == 'logout') {
            $_SESSION = [];
            session_destroy();
            
            refresh();
        }
    }
    
    
    
    
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
        if (isset($_SESSION['page'])) {
            if ($_SESSION['page'] == 'morning_form') {
                include 'morningForm.php';
            }
            else if ($_SESSION['page'] == 'before_sleep_form') {
                include 'beforeSleep.php';
            }
            else if ($_SESSION['page'] == 'biometrics_form') {
                include 'biometrics.php';
            }
            else if ($_SESSION['page'] == 'schedule_event_form') {
                include 'scheduleSurvey.php';
            }
            else if ($_SESSION['page'] == 'missed_event_form') {
                include 'MissedEvents.php';
            }
            
        }
        else {
            include 'mainPage.php';
        }
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
    