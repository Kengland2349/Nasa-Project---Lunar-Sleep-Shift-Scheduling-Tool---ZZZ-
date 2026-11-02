<?php

include 'utils.php';


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    $formType = $_POST['form_type'] ?? '';
    
    if ($formType === 'register') {
        $username = $_POST['username'] ?? '';
        
        $stmt = $pdo->prepare(
            "SELECT user_ID
                 FROM users
                 WHERE user_Name = ?"
            );
        
        $stmt->execute([$username]);
        $user = $stmt->fetch();
        
        if ($user) {
            refreshMessage("Username is already in use!");
        } else {
            $username = $_POST['username'] ?? '';
            $password = $_POST['password'] ?? '';
            
            $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
            
            $stmt = $pdo->prepare(
                "INSERT INTO users (user_Name, secured_Password)
                     VALUES (?, ?)"
                );
            
            $stmt->execute([$username, $hashedPassword]);
            $result = $stmt->fetch();
            
            unset($_SESSION['portalPage']);
            refreshMessage("$username is registered!");
        }
    }
    else if ($formType === 'back') {
        unset($_SESSION['portalPage']);
        refresh();
    }
}
?>


<body>

	<!-- The Register Form -->
<form action="" method="POST" class="register-form">

	<input type="hidden" name="form_type" value="register">
    
    <label for="username">Username</label>
    <input type="text" id="username" name="username" placeholder="Enter your username" required>

    <label for="password">Password</label>
    <input type="password" id="password" name="password" placeholder="Enter your password" required>
	
    <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
        Sign Up
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