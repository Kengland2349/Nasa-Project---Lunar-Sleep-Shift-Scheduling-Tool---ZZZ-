<?php
    
    // testing some stuff
    function refreshMessage($text) {
        $_SESSION['message'] = "$text";
        header("Location: index.php");
        exit;
    }
    
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
                    
                    refreshMessage("Login successful!");
                } else {
                    refreshMessage("Invalid username or password.");
                }
                
            } else {
                refreshMessage("Invalid username or password.");
            }
        }
        else if ($formType === 'register') {
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
                
                refreshMessage("$username is registered!");
            
            }
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
	
    <!-- Your exact-size anchor button adapted to submit the form -->
    <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
        Login
    </a>
</form>

<hr size="50px">

	<!-- The Register Form -->
<form action="" method="POST" class="register-form">

	<input type="hidden" name="form_type" value="register">
    
    <label for="username">Username</label>
    <input type="text" id="username" name="username" placeholder="Enter your username" required>

    <label for="password">Password</label>
    <input type="password" id="password" name="password" placeholder="Enter your password" required>
	
    <!-- Your exact-size anchor button adapted to submit the form -->
    <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
        Register
    </a>
</form>


</body>