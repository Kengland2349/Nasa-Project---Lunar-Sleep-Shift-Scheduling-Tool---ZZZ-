<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    $formType = $_POST['form_type'] ?? '';
    
    if ($formType === 'schedule_event_form') {
        $submit = true;
        
        if ($submit) {
            unset($_SESSION['page']);
            refresh();
        }
        
    }
}
?>


<form action="" method="POST" class="question_form">
	<input type="hidden" name="form_type" value="schedule_event_form">
	
	<div class="form-group">
        <label for="event_name">Event Name</label>
        <input type="text" id="event_name" name="event_name" required>
    </div>
    
    <div class="form-group">
        <label>Event type</label>

        <div class="multiple-options">
        <label class="multiple-option">
            <input type="radio" name="event_type" value="routine" required>
            <span>Routine</span>
        </label>

        <label class="multiple-option">
            <input type="radio" name="event_type" value="single">
            <span>Single Instance</span>
        </label>
    	</div>
    </div>
    
    <div class="form-group">
        <label>Routine type</label>

        <div class="multiple-options">
        <label class="multiple-option">
            <input type="radio" name="routine_type" value="daily" required>
            <span>daily</span>
        </label>
        
        <label class="multiple-option">
            <input type="radio" name="routine_type" value="every_other_day" required>
            <span>every other day</span>
        </label>

        <label class="multiple-option">
            <input type="radio" name="routine_type" value="weekly">
            <span>weekly</span>
        </label>
        
        <label class="multiple-option">
            <input type="radio" name="routine_type" value="semi_weekly">
            <span>semi weekly</span>
        </label>
        
        <label class="multiple-option">
            <input type="radio" name="routine_type" value="monthly">
            <span>monthly</span>
        </label>
    	</div>
    </div>
    
    <div class="form-group">
        <label for="date">Date</label>
        <input type="date" id="date" name="date" required>
    </div>
    
    <div class="form-group">
        <label for="start_time">Start Time</label>
        <input type="time" id="start_time" name="start_time" required>
    </div>
    
    <div class="form-group">
        <label for="end_time">End Time</label>
        <input type="time" id="end_time" name="end_time" required>
    </div>
    
    
    
    
    <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
    	Submit
    </a>
</form>
