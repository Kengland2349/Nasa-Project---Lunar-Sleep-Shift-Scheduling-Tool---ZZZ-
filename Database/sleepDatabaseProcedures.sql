DROP PROCEDURE IF EXISTS login;
DROP PROCEDURE IF EXISTS register;
DROP PROCEDURE IF EXISTS newEvent;
DROP PROCEDURE IF EXISTS updateEvent;
DROP PROCEDURE IF EXISTS deleteEvent;
DROP PROCEDURE IF EXISTS new_daily_sleep_log;
DROP PROCEDURE IF EXISTS update_daily_sleep_log;
DROP PROCEDURE IF EXISTS get_daily_sleep_log;
DROP TRIGGER IF EXISTS insert_daily_sleep_log_audit;
DROP TRIGGER IF EXISTS update_daily_sleep_log_audit;

DELIMITER //

-- Procedures

-- USER

CREATE PROCEDURE login(userName varchar(255))
BEGIN
	SELECT userID, securedPassword
    FROM users
    WHERE users.userName = userName;
END//

CREATE PROCEDURE register(userName varchar(255), hashPassword varchar(255))
BEGIN
	INSERT INTO users(userName, securedPassword)
    VALUES(userName, hashPassword);
END//

-- SCHEDULE

CREATE PROCEDURE newEvent(userID int, eventName varchar(255), startTime time, endTime time, instanceType enum('Single','Routine'))
BEGIN
	INSERT INTO schedule_events(userID, eventName, startTime, endTime ,instanceType)
    VALUES(userID, eventName, startTime, endTime, instanceType);
END//

CREATE PROCEDURE updateEvent(userID int, eventName varchar(255), startTime time, endTime time, instanceType enum('Single','Routine'))
BEGIN
	UPDATE schedule_events
    SET schedule_events.startTime = startTime, schedule_events.endTime = endTime, schedule_events.instanceType = instanceType
    WHERE schedule_events.userID = userID AND schedule_events.eventName = eventName;
END//

CREATE PROCEDURE deleteEvent(userID int, eventName varchar(255))
BEGIN
	DELETE FROM schedule_events
    WHERE schedule_events.userID = userID AND schedule_events.eventName = eventName;
END//

-- MORNING

CREATE PROCEDURE new_daily_sleep_log(user_id INT, log_date DATE, bed_time DATETIME, wake_time DATETIME, latency_mins SMALLINT, awakenings_count TINYINT, awakening_latency_mins SMALLINT, rating_1_10 TINYINT)
BEGIN
	INSERT INTO daily_sleep_logs(user_id, log_date, bed_time, wake_time, latency_mins, awakenings_count, awakening_latency_mins, rating_1_10)
    VALUES(user_id, log_date, bed_time, wake_time, latency_mins, awakenings_count, awakening_latency_mins, rating_1_10);
END//

CREATE PROCEDURE update_daily_sleep_log(user_id INT, log_date DATE, bed_time DATETIME, wake_time DATETIME, latency_mins SMALLINT, awakenings_count TINYINT, awakening_latency_mins SMALLINT, rating_1_10 TINYINT)
BEGIN
	UPDATE daily_sleep_logs
    SET daily_sleep_logs.bed_time = bed_time, daily_sleep_logs.wake_time = wake_time, daily_sleep_logs.latency_mins = latency_mins, daily_sleep_logs.awakenings_count = awakenings_count, daily_sleep_logs.awakening_latency_mins = awakening_latency_mins, daily_sleep_logs.rating_1_10 = rating_1_10
    WHERE daily_sleep_logs.user_id = user_id AND daily_sleep_logs.log_date = log_date;
END//

CREATE PROCEDURE get_daily_sleep_log(user_id int, log_date DATE)
BEGIN
	SELECT log_id, bed_time, wake_time, latency_mins, awakenings_count, awakening_latency_mins, rating_1_10
    FROM daily_sleep_logs
    WHERE daily_sleep_logs.user_id = user_id AND daily_sleep_logs.log_date = log_date;
END//

-- Pre-Sleep Behaviors

CREATE PROCEDURE new_pre_sleep_behavior(log_id INT, fatigue_score TINYINT, alertness_score TINYINT, caffeine_cups TINYINT, melatonin_mg SMALLINT, last_meal_hrs TINYINT, last_meal_size TINYINT, exercise_mins SMALLINT, exercise_intensity TINYINT)
BEGIN
	INSERT INTO pre_sleep_behaviors(log_id, fatigue_score, alertness_score, caffeine_cups, melatonin_mg, last_meal_hrs, last_meal_size, exercise_mins, exercise_intensity)
    VALUES(log_id, fatigue_score, alertness_score, caffeine_cups, melatonin_mg, last_meal_hrs, last_meal_size, exercise_mins, exercise_intensity);
END//

CREATE PROCEDURE update_pre_sleep_behavior(log_id INT, fatigue_score TINYINT, alertness_score TINYINT, caffeine_cups TINYINT, melatonin_mg SMALLINT, last_meal_hrs TINYINT, last_meal_size TINYINT, exercise_mins SMALLINT, exercise_intensity TINYINT)
BEGIN
	UPDATE pre_sleep_behaviors
    SET pre_sleep_behaviors.fatigue_score = fatigue_score, pre_sleep_behaviors.alertness_score = alertness_score, pre_sleep_behaviors.caffeine_cups = caffeine_cups, pre_sleep_behaviors.melatonin_mg = melatonin_mg, pre_sleep_behaviors.last_meal_hrs = last_meal_hrs, pre_sleep_behaviors.last_meal_size = last_meal_size, pre_sleep_behaviors.exercise_mins = exercise_mins, pre_sleep_behaviors.exercise_intensity = exercise_intensity
    WHERE pre_sleep_behaviors.log_id = log_id;
END//

CREATE PROCEDURE get_pre_sleep_behavior(behavior_id INT)
BEGIN
	SELECT behavior_id, fatigue_score, alertness_score, caffeine_cups, melatonin_mg, last_meal_hrs, last_meal_size, exercise_mins, exercise_intensity
    FROM pre_sleep_behaviors
    WHERE pre_sleep_behaviors.behavior_id = behavior_id;
END//

-- Triggers

-- Daily Sleep Log

CREATE TRIGGER insert_daily_sleep_log_audit
AFTER INSERT ON daily_sleep_logs
FOR EACH ROW
BEGIN
	INSERT INTO daily_sleep_logs_audit(log_audit_type, log_id, log_date, new_bed_time, new_wake_time, new_latency_mins, new_awakenings_count, new_rating_1_10)
	VALUES("Insert", new.log_id, new.log_date, new.bed_time, new.wake_time, new.latency_mins, new.awakenings_count, new.rating_1_10);
END//

CREATE TRIGGER update_daily_sleep_log_audit
AFTER UPDATE ON daily_sleep_logs
FOR EACH ROW
BEGIN
	INSERT INTO daily_sleep_logs_audit(log_audit_type, log_id, log_date, new_bed_time, old_bed_time, new_wake_time, old_wake_time, new_latency_mins, old_latency_mins, new_awakenings_count, old_awakenings_count, new_rating_1_10, old_rating_1_10)
	VALUES("Update", old.log_id, old.log_date, new.bed_time, old.bed_time, new.wake_time, old.wake_time, new.latency_mins, old.latency_mins, new.awakenings_count, old.awakenings_count, new.rating_1_10, old.rating_1_10);
END//

CREATE TRIGGER delete_daily_sleep_log_audit
AFTER DELETE ON daily_sleep_logs
FOR EACH ROW
BEGIN
	INSERT INTO daily_sleep_logs_audit(log_audit_type, log_id, log_date, old_bed_time, old_wake_time, old_latency_mins, old_awakenings_count, old_rating_1_10)
	VALUES("Delete", old.log_id, old.log_date, old.bed_time, old.wake_time, old.latency_mins, old.awakenings_count, old.rating_1_10);
END//

-- Pre-Sleep Behaviors

CREATE TRIGGER insert_daily_sleep_log_audit
AFTER INSERT ON pre_sleep_behaviors
FOR EACH ROW
BEGIN
	INSERT INTO pre_sleep_behaviors_audit(pre_sleep_audit_type, behavior_id, new_fatigue_score, new_alertness_score, new_caffeine_cups, new_melatonin_mg, new_last_meal_hrs, new_last_meal_size, new_exercise_mins, new_exercise_intensity)
	VALUES("Insert", new.behavior_id, new.fatigue_score, new.alertness_score, new.caffeine_cups, new.melatonin_mg, new.last_meal_hrs, new.last_meal_size, new.exercise_mins, new.exercise_intensity);
END//

CREATE TRIGGER update_pre_sleep_behavior_audit
AFTER UPDATE ON pre_sleep_behaviors
FOR EACH ROW
BEGIN
	INSERT INTO pre_sleep_behaviors_audit(pre_sleep_audit_type, behavior_id, new_fatigue_score, old_fatigue_score, new_alertness_score, old_alertness_score, new_caffeine_cups, old_caffeine_cups, new_melatonin_mg, old_melatonin_mg, new_last_meal_hrs, old_last_meal_hrs, new_last_meal_size, old_last_meal_size, new_exercise_mins, old_exercise_mins, new_exercise_intensity, old_exercise_intensity)
	VALUES("Update", old.behavior_id, new.fatigue_score, old.fatigue_score, new.alertness_score, old.alertness_score, new.caffeine_cups, old.caffeine_cups, new.melatonin_mg, old.melatonin_mg, new.last_meal_hrs, old.last_meal_hrs, new.last_meal_size, old.last_meal_size, new.exercise_mins, old.exercise_mins, new.exercise_intensity, old.exercise_intensity);
END//

CREATE TRIGGER delete_pre_sleep_behavior_audit
AFTER DELETE ON pre_sleep_behaviors
FOR EACH ROW
BEGIN
	INSERT INTO pre_sleep_behaviors_audit(pre_sleep_audit_type, behavior_id, old_fatigue_score, old_alertness_score, old_caffeine_cups, old_melatonin_mg, old_last_meal_hrs, old_last_meal_size, old_exercise_mins, old_exercise_intensity)
	VALUES("Delete", old.behavior_id, old.fatigue_score, old.alertness_score, old.caffeine_cups, old.melatonin_mg, old.last_meal_hrs, old.last_meal_size, old.exercise_mins, old.exercise_intensity);
END//


DELIMITER ;


