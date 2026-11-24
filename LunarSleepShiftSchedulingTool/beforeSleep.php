<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    $formType = $_POST['form_type'] ?? '';
    
    if ($formType === 'before_sleep_form') {
        $submit = true;
        $caffeine_time = filter_input(INPUT_POST, 'caffeine_time', FILTER_VALIDATE_INT);
        $caffeine_amt = filter_input(INPUT_POST, 'caffeine_amt', FILTER_VALIDATE_INT);
        $melatonin_amt = filter_input(INPUT_POST, 'melatonin_amt', FILTER_VALIDATE_INT);
        $last_meal_time = filter_input(INPUT_POST, 'last_meal_time', FILTER_VALIDATE_INT);
        $exercise_duration = filter_input(INPUT_POST, 'exercise_duration', FILTER_VALIDATE_INT);
        
        if ($caffeine_amt === false || $caffeine_amt === null || $caffeine_amt < 0 || $caffeine_amt > 9999.99) {
            $caffeine_amt_Error = "Enter a integer between 0-9999.99!";
            $submit = false;
        }
        if ($melatonin_amt === false || $melatonin_amt === null || $melatonin_amt < 0 || $melatonin_amt > 9999.99) {
            $melatonin_amt_Error = "Enter a integer between 0-9999.99!";
            $submit = false;
        }
        if ($last_meal_time === false || $last_meal_time === null || $last_meal_time < 0) {
            $last_meal_time_Error = "Enter a integer zero or greater!";
            $submit = false;
        }
        if ($exercise_duration === false || $exercise_duration === null || $exercise_duration < 0) {
            $exercise_duration_Error = "Enter a integer zero or greater!";
            $submit = false;
        }
        
        
        if ($submit) {
            $fatigue = filter_input(
                INPUT_POST,
                'fatigue',
                FILTER_VALIDATE_INT
                );
            $alert = filter_input(
                INPUT_POST,
                'alert',
                FILTER_VALIDATE_INT
                );
            $caffeine_time = $_POST['caffeine_time'] ?? '';
            $caffeine_amt = $_POST['caffeine_amt'] ?? '';
            $melatonin_amt = $_POST['melatonin_amt'] ?? '';
            $last_meal_time = $_POST['last_meal_time'] ?? '';
            $last_meal_size = filter_input(
                INPUT_POST,
                'meal_size',
                FILTER_VALIDATE_INT
                );
            $exercise_duration = $_POST['exercise_duration'] ?? '';
            $exercise_intensity =  filter_input(
                INPUT_POST,
                'exercise_intensity_num',
                FILTER_VALIDATE_INT
                );
            
            $userID = $_SESSION['user_ID'];
            $date = date('Y-m-d');
            
            //TODO: add the ability to sumbit data to the database
            $stmt = $pdo->prepare(
                "CALL get_daily_sleep_log(?, ?)"
                );
            
            $stmt->execute([$userID, $date]);
            $log_id = $stmt->fetch();
            $stmt->closeCursor();
            
            if ($log_id) {
                $stmt = $pdo->prepare(
                    "CALL new_pre_sleep_behavior(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
                    );
                $stmt->execute([$log_id["log_id"], $fatigue, $alert, $caffeine_amt, $caffeine_time, $melatonin_amt, $last_meal_time, $last_meal_size, $exercise_duration, $exercise_intensity]);
                $stmt->closeCursor();
            }
            else {
                $No_Log_Id = "You need to do the morning form first!";
                $submit = false;
            }
            
            if ($submit) {
                unset($_SESSION['page']);
                refresh();
            }
        }
        
    }
    else if ($formType === 'back_button') {
        unset($_SESSION['page']);
        refresh();
    }
}
?>


<form action="" method="POST" class="question_form">
	<input type="hidden" name="form_type" value="before_sleep_form">
    
    <div class="form-group">
        <label for="fatigue_amt">How fatigued were you today?</label>
        
        <div class="star-box">
        <div class="star-rating">
        	<input type="radio" name="fatigue" value="10" id="fatigue10">
            <label for="fatigue10">★</label>
    
            <input type="radio" name="fatigue" value="9" id="fatigue9">
            <label for="fatigue9">★</label>
    
            <input type="radio" name="fatigue" value="8" id="fatigue8">
            <label for="fatigue8">★</label>
    
            <input type="radio" name="fatigue" value="7" id="fatigue7">
            <label for="fatigue7">★</label>
    
            <input type="radio" name="fatigue" value="6" id="fatigue6">
            <label for="fatigue6">★</label>
            
            <input type="radio" name="fatigue" value="5" id="fatigue5">
            <label for="fatigue5">★</label>
    
            <input type="radio" name="fatigue" value="4" id="fatigue4">
            <label for="fatigue4">★</label>
    
            <input type="radio" name="fatigue" value="3" id="fatigue3">
            <label for="fatigue3">★</label>
    
            <input type="radio" name="fatigue" value="2" id="fatigue2">
            <label for="fatigue2">★</label>
    
            <input type="radio" name="fatigue" value="1" id="fatigue1">
            <label for="fatigue1">★</label>
        </div>
        </div>
    </div>
    
    <div class="form-group">
        <label for="alert_amt">How Alert were you today?</label>
        
        <div class="star-box">
        <div class="star-rating">
        	<input type="radio" name="alert" value="10" id="alert10">
            <label for="alert10">★</label>
    
            <input type="radio" name="alert" value="9" id="alert9">
            <label for="alert9">★</label>
    
            <input type="radio" name="alert" value="8" id="alert8">
            <label for="alert8">★</label>
    
            <input type="radio" name="alert" value="7" id="alert7">
            <label for="alert7">★</label>
    
            <input type="radio" name="alert" value="6" id="alert6">
            <label for="alert6">★</label>
            
            <input type="radio" name="alert" value="5" id="alert5">
            <label for="alert5">★</label>
    
            <input type="radio" name="alert" value="4" id="alert4">
            <label for="alert4">★</label>
    
            <input type="radio" name="alert" value="3" id="alert3">
            <label for="alert3">★</label>
    
            <input type="radio" name="alert" value="2" id="alert2">
            <label for="alert2">★</label>
    
            <input type="radio" name="alert" value="1" id="alert1">
            <label for="alert1">★</label>
        </div>
        </div>
    </div>
    
    <div class="form-group">
        <label for="caffeine_time">Did you have caffeine(coffee, soda, energy drink) before sleeping? If so, when?</label>
        <input type="time" id="caffeine_time" name="caffeine_time" required>
    </div>
    
    <div class="form-group">
        <label for="caffeine_amt">How many miligrams of caffiene did you have?</label>
        
        <?php
        if (isset($caffeine_amt_Error)) {
            echo '<p class="error">' . htmlspecialchars($caffeine_amt_Error) . '</p>';
        }
        ?>
        
        <input type="number" id="caffeine_amt" name="caffeine_amt" step="0.01" required>
    </div>
    
    <div class="form-group">
        <label for="melatonin_amt">How many miligrams of melatonin did you take before sleeping?</label>
        
        <?php
        if (isset($melatonin_amt_Error)) {
            echo '<p class="error">' . htmlspecialchars($melatonin_amt_Error) . '</p>';
        }
        ?>
        
        <input type="number" id="melatonin_amt" name="melatonin_amt" step="0.01" required>
    </div>
    
    <div class="form-group">
        <label for="last_meal_time">How long ago was your last meal? (minutes)</label>
        
        <?php
        if (isset($last_meal_time_Error)) {
            echo '<p class="error">' . htmlspecialchars($last_meal_time_Error) . '</p>';
        }
        ?>
        
        <input type="number" id="last_meal_time" name="last_meal_time" required>
    </div>
    
    <div class="form-group">
        <label for="last_meal_size">How big was the meal? (1-5) (1 is small and 5 is big)</label>
        
        <div class="star-box">
        <div class="star-rating">
            <input type="radio" name="meal_size" value="5" id="meal_size5">
            <label for="meal_size5">★</label>
    
            <input type="radio" name="meal_size" value="4" id="meal_size4">
            <label for="meal_size4">★</label>
    
            <input type="radio" name="meal_size" value="3" id="meal_size3">
            <label for="meal_size3">★</label>
    
            <input type="radio" name="meal_size" value="2" id="meal_size2">
            <label for="meal_size2">★</label>
    
            <input type="radio" name="meal_size" value="1" id="meal_size1">
            <label for="meal_size1">★</label>
        </div>
        </div>
    </div>
	
	<div class="form-group">
        <label for="exercise_duration">If you exercised today, how long did you exercise? (minutes) (0 min = no excercise)</label>
        
        <?php
        if (isset($exercise_duration_Error)) {
            echo '<p class="error">' . htmlspecialchars($exercise_duration_Error) . '</p>';
        }
        ?>
        
        <input type="number" id="exercise_duration" name="exercise_duration" required>
    </div>
    
    <div class="form-group">
        <label for="exercise_intensity">how intense was your exercise? (1-10) (1 is not intense and 10 is extreme intensity)</label>
        
        <div class="star-box">
        <div class="star-rating">
        	<input type="radio" name="exercise_intensity_num" value="10" id="exercise_intensity_num10">
            <label for="exercise_intensity_num10">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="9" id="exercise_intensity_num9">
            <label for="exercise_intensity_num9">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="8" id="exercise_intensity_num8">
            <label for="exercise_intensity_num8">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="7" id="exercise_intensity_num7">
            <label for="exercise_intensity_num7">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="6" id="exercise_intensity_num6">
            <label for="exercise_intensity_num6">★</label>
            
            <input type="radio" name="exercise_intensity_num" value="5" id="exercise_intensity_num5">
            <label for="exercise_intensity_num5">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="4" id="exercise_intensity_num4">
            <label for="exercise_intensity_num4">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="3" id="exercise_intensity_num3">
            <label for="exercise_intensity_num3">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="2" id="exercise_intensity_num2">
            <label for="exercise_intensity_num2">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="1" id="exercise_intensity_num1">
            <label for="exercise_intensity_num1">★</label>
        </div>
        </div>
    </div>
    
    
    <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
    	Submit
    </a>
    <?php
        if (isset($No_Log_Id)) {
            echo '<p class="error">' . htmlspecialchars($No_Log_Id) . '</p>';
        }
    ?>
</form>

<hr>

<form action="" method="POST" class="back_button">
	<input type="hidden" name="form_type" value="back_button">
    <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
    	Back
    </a>
</form>
