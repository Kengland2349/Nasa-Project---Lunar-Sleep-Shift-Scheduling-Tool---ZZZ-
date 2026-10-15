<?php
    include 'header.php';
    
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        
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
                
                echo "Login successful!";
                header("Location: index.php");
                exit;
            } else {
                echo "Invalid username or password.";
            }
            
        } else {
            echo "Invalid username or password.";
        }
        
    }
?>


<body>
	<!-- The Login Form -->
<form action="" method="POST" class="login-form">
    
    <label for="username">Username</label>
    <input type="text" id="username" name="username" placeholder="Enter your username" required>

    <label for="password">Password</label>
    <input type="password" id="password" name="password" placeholder="Enter your password" required>
	
    <!-- Your exact-size anchor button adapted to submit the form -->
    <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
        Login
    </a>
</form>
</body>