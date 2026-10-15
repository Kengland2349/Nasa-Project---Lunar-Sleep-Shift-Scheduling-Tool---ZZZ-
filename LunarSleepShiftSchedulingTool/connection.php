<?php
    // Database configuration
    $host    = 'localhost';
    $db      = 'lunar-sleep-shifts-cheduling-tool';
    $user    = 'userTesting';
    $pass    = '171718Ab';
    $charset = 'utf8mb4';
    
    $dsn = "mysql:host=$host;dbname=$db;charset=$charset";
    
    // Crucial connection options for security and error handling
    $options = [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION, // Turns errors into exceptions
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,       // Fetches arrays indexed by column name
        PDO::ATTR_EMULATE_PREPARES   => false,                  // Uses native prepared statements
    ];
    
    try {
        // 💡 This creates the $pdo variable your script is looking for!
        $pdo = new PDO($dsn, $user, $pass, $options);
    } catch (\PDOException $e) {
        // If connection fails, stop execution and show the error (hide this in production!)
        throw new \PDOException($e->getMessage(), (int)$e->getCode());
    }
?>