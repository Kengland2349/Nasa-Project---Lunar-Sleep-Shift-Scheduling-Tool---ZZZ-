<?php
    
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        
        $formType = $_POST['form_type'] ?? '';
        
        if ($formType === 'morning_form') {
            $submit = true;
            $sleepDuration = filter_input(INPUT_POST, 'sleep_latency', FILTER_VALIDATE_INT);
            $awakenings = filter_input(INPUT_POST, 'awakenings', FILTER_VALIDATE_INT);
            
            if ($sleepDuration === false || $sleepDuration === null || $sleepDuration < 0) {
                $sleepDurationError = "Enter a integer zero or greater!";
                $submit = false;
            }
            if ($awakenings === false || $awakenings === null || $awakenings < 0) {
                $awakeningsError = "Enter a integer zero or greater!";
                $submit = false;
            }
            if ($submit) {
                $bedTime = $_POST['bed_time'] ?? '';
                $wakeTime = $_POST['wake_time'] ?? '';
                $sleep_latency = $_POST['sleep_latency'] ?? '';
                $awakenings = $_POST['awakenings'] ?? '';
                $awakenings_time_avg = $_POST['awakenings_time_avg'] ?? '';
                $rating = filter_input(
                    INPUT_POST,
                    'rating',
                    FILTER_VALIDATE_INT
                    );
                
                
                $userID = $_SESSION['user_ID'];
                $date = date('Y-m-d');
                
                $stmt = $pdo->prepare(
                    "CALL new_daily_sleep_log(?, ?, ?, ?, ?, ?, ?, ?)"
                    );
                
                $stmt->execute([$userID, $date, $bedTime, $wakeTime, $sleep_latency, $awakenings, $awakenings_time_avg, $rating]);
                $result = $stmt->fetch();
                
                
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
	<input type="hidden" name="form_type" value="morning_form">
	
	<div class="form-group">
        <label for="bed_time">What time did you go to bed last night?</label>
        <input type="time" id="bed_time" name="bed_time" required>
    </div>
	
	<div class="form-group">
        <label for="wake_time">What time did you wake up?</label>
        <input type="time" id="wake_time" name="wake_time" required>
    </div>
	
	<div class="form-group">
        <label for="sleep_latency">How long did it take you to fall asleep last night? (minutes)</label>
        
        <?php
        if (isset($sleepDurationError)) {
            echo '<p class="error">' . htmlspecialchars($sleepDurationError) . '</p>';
        }
        ?>
        
        <input type="number" id="sleep_latency" name="sleep_latency" required>
    </div>
	
    <div class="form-group">
        <label for="sleep_latency">What would you rate your sleep quality 1-10?</label>
        
        
        <div class="star-box">
        <div class="star-rating">
        	<input type="radio" name="rating" value="10" id="rating10">
            <label for="rating10">★</label>
    
            <input type="radio" name="rating" value="9" id="rating9">
            <label for="rating9">★</label>
    
            <input type="radio" name="rating" value="8" id="rating8">
            <label for="rating8">★</label>
    
            <input type="radio" name="rating" value="7" id="rating7">
            <label for="rating7">★</label>
    
            <input type="radio" name="rating" value="6" id="rating6">
            <label for="rating6">★</label>
            
            <input type="radio" name="rating" value="5" id="rating5">
            <label for="rating5">★</label>
    
            <input type="radio" name="rating" value="4" id="rating4">
            <label for="rating4">★</label>
    
            <input type="radio" name="rating" value="3" id="rating3">
            <label for="rating3">★</label>
    
            <input type="radio" name="rating" value="2" id="rating2">
            <label for="rating2">★</label>
    
            <input type="radio" name="rating" value="1" id="rating1">
            <label for="rating1">★</label>
        </div>
        </div>
    </div>
    
    <div class="form-group">
        <label for="awakenings">How many awakenings did you have during your sleep period?</label>
        <?php 
        if (isset($awakeningsError)) {
            echo '<p class="error">' . htmlspecialchars($awakeningsError) . '</p>';
        }
        ?>
        <input type="number" id="awakenings" name="awakenings" required>
    </div>
    
    <div class="form-group">
        <label for="awakenings_time_avg">If you had awakenings; how long on average did it take you to fall back asleep? (minutes)</label>
        <?php 
        if (isset($awakeningsError)) {
            echo '<p class="error">' . htmlspecialchars($awakeningsError) . '</p>';
        }
        ?>
        <input type="number" id="awakenings_time_avg" name="awakenings_time_avg" required>
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
