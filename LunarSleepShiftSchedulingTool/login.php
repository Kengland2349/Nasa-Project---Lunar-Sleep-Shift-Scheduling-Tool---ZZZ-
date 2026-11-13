<?php
    
    
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        
        $formType = $_POST['form_type'] ?? '';
        
        if ($formType === 'login') {
            $username = $_POST['username'] ?? '';
            $password = $_POST['password'] ?? '';
            
            $stmt = $pdo->prepare(
                "SELECT user_ID, secured_Password
                 FROM users
                 WHERE user_Name = ?"
                );
            
            $stmt->execute([$username]);
            $user = $stmt->fetch();
            
            if ($user) {
                
                $storedHashFromDb = $user['secured_Password'];
                
                if (password_verify($password, $storedHashFromDb)) {
                    session_regenerate_id(true);
                    
                    $_SESSION['user_ID'] = $user['user_ID'];
                    
                    unset($_SESSION['portalPage']);
                    refreshMessage("Login successful!");
                } else {
                    refreshMessage("Invalid username or password.");
                }
                
            } else {
                refreshMessage("Invalid username or password.");
            }
        }
        else if ($formType === 'back') {
            unset($_SESSION['portalPage']);
            refresh();
        }
    }
?>


<body>
	<!-- The Login Form -->
<form action="" method="POST" class="login-form">

	<input type="hidden" name="form_type" value="login">
    
    <label for="username">Username</label>
    <input type="text" id="username" name="username" placeholder="Enter your username" required>

    <label for="password">Password</label>
    <input type="password" id="password" name="password" placeholder="Enter your password" required>
	
    <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
        Login
    </a>
</form>

    <!-- The Back Form -->
<form action="" method="POST" class="back-form">

	<input type="hidden" name="form_type" value="back">
	
    <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
        Back
    </a>
</form>

</body>