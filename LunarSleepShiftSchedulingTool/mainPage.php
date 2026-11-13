<?php
    
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        
        $formType = $_POST['form_type'] ?? '';
        
        if ($formType === 'access_morning_questions') {
            $_SESSION['page'] = 'morning_form';
            refresh();
        }
        else if ($formType === 'access_before_sleep_questions') {
            $_SESSION['page'] = 'before_sleep_form';
            refresh();
        }
        else if ($formType === 'access_biometrics_questions') {
            $_SESSION['page'] = 'biometrics_form';
            refresh();
        }
        else if ($formType === 'access_schedule_event_questions') {
            $_SESSION['page'] = 'schedule_event_form';
            refresh();
        }
        else if ($formType === 'access_missed_event_questions') {
            $_SESSION['page'] = 'missed_event_form';
            refresh();
        }
    }
?>


<header>
    <table>
        <tr>
        	<td><img src="ZZZNASA.png" alt="Team Logo" width="100" height="100"></td>
            <td>Lunar Sleep Shift Scheduling Tool</td>
        </tr>
    </table>

  	<hr>
</header>

<nav>
	
</nav>

<table>
	<tr> 
	<td>
        <!-- button | morning -->
    <form action="" method="POST" class="morning-question-button-form">
    	<input type="hidden" name="form_type" value="access_morning_questions">
        <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
        	Morning Form
        </a>
    </form>
    </td>
	<td>
	<!-- button | before_sleep -->
    <form action="" method="POST" class="before_sleep-question-button-form">
    	<input type="hidden" name="form_type" value="access_before_sleep_questions">
        <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
        	Before Sleep Form
        </a>
    </form>
	</td>
	<!-- button | schedule event form
	<td>
    <form action="" method="POST" class="schedule-event-question-button-form">
    	<input type="hidden" name="form_type" value="access_schedule_event_questions">
        <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
        	schedule event
        </a>
    </form>
    </td>
    -->
    <!-- button | missed event form
	<td>
    <form action="" method="POST" class="missed-event-question-button-form">
    	<input type="hidden" name="form_type" value="access_missed_event_questions">
        <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
        	Missed event
        </a>
    </form>
	</td> 
	-->
	<td>
	<!-- button | biometrics -->
    <form action="" method="POST" class="biometrics-question-button-form">
    	<input type="hidden" name="form_type" value="access_biometrics_questions">
        <a href="#" class="pseudo-button" role="button" onclick="this.closest('form').submit(); return false;">
        	Biometrics
        </a>
    </form>
	</td> 
	</tr>
	<tr> <td>
		<?php 
		include 'logout.php';
		?>
	
	</td> </tr>
</table>
    
<?php
    include 'footer.php';
?>