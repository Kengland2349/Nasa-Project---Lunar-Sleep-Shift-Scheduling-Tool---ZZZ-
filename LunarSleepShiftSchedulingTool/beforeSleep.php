<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    $formType = $_POST['form_type'] ?? '';
    
    if ($formType === 'before_sleep_form') {
        $submit = true;
        $caffeine_time = filter_input(INPUT_POST, 'caffeine_time', FILTER_VALIDATE_INT);
        $melatonin_amt = filter_input(INPUT_POST, 'melatonin_amt', FILTER_VALIDATE_INT);
        $last_meal_time = filter_input(INPUT_POST, 'last_meal_time', FILTER_VALIDATE_INT);
        $exercise_duration = filter_input(INPUT_POST, 'exercise_duration', FILTER_VALIDATE_INT);
        
        if ($caffeine_time === false || $caffeine_time === null || $caffeine_time < 0) {
            $caffeine_time_Error = "Enter a integer zero or greater!";
            $submit = false;
        }
        if ($melatonin_amt === false || $melatonin_amt === null || $melatonin_amt < 0) {
            $melatonin_amt_Error = "Enter a integer zero or greater!";
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
            $melatonin_amt = $_POST['melatonin_amt'] ?? '';
            $last_meal_time = $_POST['last_meal_time'] ?? '';
            $last_meal_size = filter_input(
                INPUT_POST,
                'last_meal_size',
                FILTER_VALIDATE_INT
                );
            $exercise_duration = $_POST['exercise_duration'] ?? '';
            $exercise_time = $_POST['exercise_time'] ?? '';
            $exercise_intensity =  filter_input(
                INPUT_POST,
                'exercise_intensity',
                FILTER_VALIDATE_INT
                );
            
            
            
            $userID = $_SESSION['user_ID'];
            
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
	<input type="hidden" name="form_type" value="before_sleep_form">
    
    <div class="form-group">
        <label for="fatigue_amt">How fatigued were you today?</label>
        
        <div class="star-box">
        <div class="star-rating">
        	<input type="radio" name="fatigue" value="10" id="star10">
            <label for="star10">★</label>
    
            <input type="radio" name="fatigue" value="9" id="star9">
            <label for="star9">★</label>
    
            <input type="radio" name="fatigue" value="8" id="star8">
            <label for="star8">★</label>
    
            <input type="radio" name="fatigue" value="7" id="star7">
            <label for="star7">★</label>
    
            <input type="radio" name="fatigue" value="6" id="star6">
            <label for="star6">★</label>
            
            <input type="radio" name="fatigue" value="5" id="star5">
            <label for="star5">★</label>
    
            <input type="radio" name="fatigue" value="4" id="star4">
            <label for="star4">★</label>
    
            <input type="radio" name="fatigue" value="3" id="star3">
            <label for="star3">★</label>
    
            <input type="radio" name="fatigue" value="2" id="star2">
            <label for="star2">★</label>
    
            <input type="radio" name="fatigue" value="1" id="star1">
            <label for="star1">★</label>
        </div>
        </div>
    </div>
    
    <div class="form-group">
        <label for="alert_amt">How Alert were you today?</label>
        
        <div class="star-box">
        <div class="star-rating">
        	<input type="radio" name="alert" value="10" id="star10">
            <label for="star10">★</label>
    
            <input type="radio" name="alert" value="9" id="star9">
            <label for="star9">★</label>
    
            <input type="radio" name="alert" value="8" id="star8">
            <label for="star8">★</label>
    
            <input type="radio" name="alert" value="7" id="star7">
            <label for="star7">★</label>
    
            <input type="radio" name="alert" value="6" id="star6">
            <label for="star6">★</label>
            
            <input type="radio" name="alert" value="5" id="star5">
            <label for="star5">★</label>
    
            <input type="radio" name="alert" value="4" id="star4">
            <label for="star4">★</label>
    
            <input type="radio" name="alert" value="3" id="star3">
            <label for="star3">★</label>
    
            <input type="radio" name="alert" value="2" id="star2">
            <label for="star2">★</label>
    
            <input type="radio" name="alert" value="1" id="star1">
            <label for="star1">★</label>
        </div>
        </div>
    </div>
    
    <div class="form-group">
        <label for="caffeine_time">Did you have caffeine(coffee, soda, energy drink) before sleeping? If so, when? (minutes before bed)</label>
        
        <?php
        if (isset($caffeine_time_Error)) {
            echo '<p class="error">' . htmlspecialchars($caffeine_time_Error) . '</p>';
        }
        ?>
        
        <input type="number" id="caffeine_time" name="caffeine_time" required>
    </div>
    
    <div class="form-group">
        <label for="melatonin_amt">How much melatonin did you take before sleeping?</label>
        
        <?php
        if (isset($melatonin_amt_Error)) {
            echo '<p class="error">' . htmlspecialchars($melatonin_amt_Error) . '</p>';
        }
        ?>
        
        <input type="number" id="melatonin_amt" name="melatonin_amt" required>
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
        	<input type="radio" name="meal_size" value="10" id="star10">
            <label for="star10">★</label>
    
            <input type="radio" name="meal_size" value="9" id="star9">
            <label for="star9">★</label>
    
            <input type="radio" name="meal_size" value="8" id="star8">
            <label for="star8">★</label>
    
            <input type="radio" name="meal_size" value="7" id="star7">
            <label for="star7">★</label>
    
            <input type="radio" name="meal_size" value="6" id="star6">
            <label for="star6">★</label>
            
            <input type="radio" name="meal_size" value="5" id="star5">
            <label for="star5">★</label>
    
            <input type="radio" name="meal_size" value="4" id="star4">
            <label for="star4">★</label>
    
            <input type="radio" name="meal_size" value="3" id="star3">
            <label for="star3">★</label>
    
            <input type="radio" name="meal_size" value="2" id="star2">
            <label for="star2">★</label>
    
            <input type="radio" name="meal_size" value="1" id="star1">
            <label for="star1">★</label>
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
        <label for="exercise_time">When did you start your exercise? (if you did not exercise then just put the current time)</label>
        
        <input type="time" id="exercise_time" name="exercise_time" required>
    </div>
    
    <div class="form-group">
        <label for="exercise_intensity">how intense was your exercise? (1-10) (1 is not intense and 10 is extreme intensity)</label>
        
        <div class="star-box">
        <div class="star-rating">
        	<input type="radio" name="exercise_intensity_num" value="10" id="star10">
            <label for="star10">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="9" id="star9">
            <label for="star9">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="8" id="star8">
            <label for="star8">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="7" id="star7">
            <label for="star7">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="6" id="star6">
            <label for="star6">★</label>
            
            <input type="radio" name="exercise_intensity_num" value="5" id="star5">
            <label for="star5">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="4" id="star4">
            <label for="star4">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="3" id="star3">
            <label for="star3">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="2" id="star2">
            <label for="star2">★</label>
    
            <input type="radio" name="exercise_intensity_num" value="1" id="star1">
            <label for="star1">★</label>
        </div>
        </div>
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
