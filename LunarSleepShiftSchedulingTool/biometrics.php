<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    $formType = $_POST['form_type'] ?? '';
    
    if ($formType === 'biometrics_form') {
        $submit = true;
        $height_inches = filter_input(INPUT_POST, 'height_inches', FILTER_VALIDATE_INT);
        $weight_lbs = filter_input(INPUT_POST, 'weight_lbs', FILTER_VALIDATE_INT);
        $age = filter_input(INPUT_POST, 'age', FILTER_VALIDATE_INT);
        
        if ($height_inches === false || $height_inches === null || $height_inches < 0) {
            $height_inches_Error = "Enter a integer zero or greater!";
            $submit = false;
        }
        if ($weight_lbs === false || $weight_lbs === null || $weight_lbs < 0) {
            $weight_lbs_Error = "Enter a integer zero or greater!";
            $submit = false;
        }
        if ($age === false || $age === null || $age < 0) {
            $age_Error = "Enter a integer zero or greater!";
            $submit = false;
        }
        
        
        
        
        if ($submit) {
            
            $gender = $_POST['gender'] ?? '';
            $height_inches = $_POST['height_inches'] ?? '';
            $weight_lbs = $_POST['weight_lbs'] ?? '';
            $age = $_POST['age'] ?? '';
            
            //TODO: add the ability to sumbit data to the database
            
            unset($_SESSION['page']);
            refresh();
        }
        
    }
    else if ($formType === 'back_button') {
        unset($_SESSION['page']);
        refresh();
    }
}
?>


<form action="" method="POST" class="question_form">
	<input type="hidden" name="form_type" value="biometrics_form">
    
    <div class="form-group">
        <label>Gender</label>

        <div class="multiple-options">
        <label class="multiple-option">
            <input type="radio" name="gender" value="Male" required>
            <span>Male</span>
        </label>

        <label class="multiple-option">
            <input type="radio" name="gender" value="Female">
            <span>Female</span>
        </label>
    	</div>
    </div>
    
    <div class="form-group">
        <label for="height_inches">Height (inches)</label>
        
        <?php
        if (isset($height_inches_Error)) {
            echo '<p class="error">' . htmlspecialchars($height_inches_Error) . '</p>';
        }
        ?>
        
        <input type="number" id="height_inches" name="height_inches" required>
    </div>
    
    <div class="form-group">
        <label for="weight_lbs">Weight (lbs)</label>
        
        <?php
        if (isset($weight_lbs_Error)) {
            echo '<p class="error">' . htmlspecialchars($weight_lbs_Error) . '</p>';
        }
        ?>
        
        <input type="number" id="weight_lbs" name="weight_lbs" required>
    </div>
    
    <div class="form-group">
        <label for="age">Age</label>
        
        <?php
        if (isset($age_Error)) {
            echo '<p class="error">' . htmlspecialchars($age_Error) . '</p>';
        }
        ?>
        
        <input type="number" id="age" name="age" required>
    </div>
    
    
    
    
    <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
    	Submit
    </a>
</form>

<hr>

<form action="" method="POST" class="back_button">
	<input type="hidden" name="form_type" value="back_button">
    <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
    	Back
    </a>
</form>
