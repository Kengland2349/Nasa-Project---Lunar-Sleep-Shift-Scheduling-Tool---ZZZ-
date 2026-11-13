<?php
    
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        
        $formType = $_POST['form_type'] ?? '';
        
        if ($formType === 'login-portal') {
            $_SESSION['portalPage'] = 'login';
            refresh();
        }
        else if ($formType === 'signup-portal') {
            $_SESSION['portalPage'] = 'signUp';
            refresh();
        }
    }
?>


<body>
	<!-- The Login Portal -->
<form action="" method="POST" class="login-portal-form">

	<input type="hidden" name="form_type" value="login-portal">
	
    <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
        Login
    </a>
</form>

    <!-- The Sign up Portal -->
<form action="" method="POST" class="signup-portal-form">

	<input type="hidden" name="form_type" value="signup-portal">
	
    <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
        Sign Up
    </a>
</form>

</body>