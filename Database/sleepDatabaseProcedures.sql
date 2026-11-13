/*
* Sleep Database Procedures
* This file declares and initializes the procedures and triggers used in the sleep database.
*
* Tables: users, schedule_events, daily_sleep_logs, pre_sleep_behaviors, biometric_profiles
* Audits: pre_sleep_behaviors, daily_sleep_logs, schedule_events
*
* Procedures: 
*   user: login, register, 
*   schedule_events: new_event, update_event, delete_event
*   daily_sleep_logs: new_daily_sleep_log, update_daily_sleep_log, get_daily_sleep_log
*   pre_sleep_behaviors: new_pre_sleep_behavior, update_pre_sleep_behavior, get_pre_sleep_behavior
*   biometric_profiles: new_biometric_profiles, update_biometric_profiles, get_biometric_profiles
*/

DROP PROCEDURE IF EXISTS login;                                      -- userName
DROP PROCEDURE IF EXISTS register;                                   -- user_name, hash_password
DROP PROCEDURE IF EXISTS new_event;                                  -- userID, eventName, startTime, endTime, eventDate, instanceType
DROP PROCEDURE IF EXISTS update_event;                               -- userID, eventName, startTime, endTime, eventDate, instanceType
DROP PROCEDURE IF EXISTS delete_event;                               -- userID, eventName, eventDate
DROP PROCEDURE IF EXISTS get_event;                                  -- userID, eventDate
DROP PROCEDURE IF EXISTS new_missed_event;                           -- user_id, event_id, arrival_time, event_name
DROP PROCEDURE IF EXISTS update_missed_event;                        -- event_id, arrival_time, event_name
DROP PROCEDURE IF EXISTS get_missed_event;                           -- event_id
DROP PROCEDURE IF EXISTS new_daily_sleep_log;                        -- user_id, log_date, bed_time, wake_time, latency_mins, awakenings_count, awakening_latency_mins, rating_1_10
DROP PROCEDURE IF EXISTS update_daily_sleep_log;                     -- user_id, log_date, bed_time, wake_time, latency_mins, awakenings_count, awakening_latency_mins, rating_1_10
DROP PROCEDURE IF EXISTS get_daily_sleep_log;                        -- user_id, log_date
DROP PROCEDURE IF EXISTS new_pre_sleep_behavior;                     -- log_id, fatigue_score, alertness_score, caffeine_cups, melatonin_mg, last_meal_hrs, last_meal_size, exercise_mins, exercise_intensity 
DROP PROCEDURE IF EXISTS update_pre_sleep_behavior;                  -- log_id, fatigue_score, alertness_score, caffeine_cups, melatonin_mg, last_meal_hrs, last_meal_size, exercise_mins, exercise_intensity
DROP PROCEDURE IF EXISTS get_pre_sleep_behavior;                     -- log_id
DROP PROCEDURE IF EXISTS new_biometric_profiles;                     -- user_id, age, gender, height_cm, weight_kg
DROP PROCEDURE IF EXISTS update_biometric_profiles;                  -- user_id, age, gender, height_cm, weight_kg
DROP PROCEDURE IF EXISTS get_biometric_profiles;                     -- user_id
DROP TRIGGER IF EXISTS insert_pre_sleep_behavior_audit;
DROP TRIGGER IF EXISTS update_pre_sleep_behavior_audit;
DROP TRIGGER IF EXISTS delete_pre_sleep_behavior_audit;
DROP TRIGGER IF EXISTS insert_daily_sleep_log_audit;
DROP TRIGGER IF EXISTS update_daily_sleep_log_audit;
DROP TRIGGER IF EXISTS delete_daily_sleep_log_audit;
DROP TRIGGER IF EXISTS insert_schedule_event_audit;
DROP TRIGGER IF EXISTS update_schedule_event_audit;
DROP TRIGGER IF EXISTS delete_schedule_event_audit;


DELIMITER //

-- Procedures

-- USER

CREATE PROCEDURE login(user_name varchar(255))
BEGIN
	SELECT user_id, secured_password
    FROM users
    WHERE users.user_name = user_name;
END//

CREATE PROCEDURE register(user_name varchar(255), hashed_password varchar(255))
BEGIN
	INSERT INTO users(user_name, secured_password)
    VALUES(user_name, hashed_password);
END//

-- Schedule-Events

CREATE PROCEDURE new_event(user_id int, event_name varchar(255), start_time time, end_time time, event_date DATE, instance_type enum('Single','Routine'), routine_frequency enum('Daily','Weekly','Monthly'))
BEGIN
	INSERT INTO schedule_events(user_id, event_name, start_time, end_time, event_date, instance_type, routine_frequency)
    VALUES(user_id, event_name, start_time, end_time, event_date, instance_type, routine_frequency);
END//

CREATE PROCEDURE update_event(user_id int, event_name varchar(255), start_time time, end_time time, event_date DATE, instance_type enum('Single','Routine'), routine_frequency enum('Daily','Weekly','Monthly'))
BEGIN
	UPDATE schedule_events
    SET schedule_events.start_time = start_time, schedule_events.end_time = end_time, schedule_events.event_date = event_date, schedule_events.instance_type = instance_type, schedule_events.routine_frequency = routine_frequency
    WHERE schedule_events.user_id = user_id AND schedule_events.event_name = event_name;
END//

CREATE PROCEDURE delete_event(user_id int, event_name varchar(255), event_date DATE)
BEGIN
	DELETE FROM schedule_events
    WHERE schedule_events.user_id = user_id AND schedule_events.event_name = event_name AND schedule_events.event_date = event_date;
END//

CREATE PROCEDURE get_event(user_id int, event_date DATE)
BEGIN
	SELECT event_id, event_name, start_time, end_time, instance_type, routine_frequency
    FROM schedule_events
    WHERE schedule_events.user_id = user_id AND schedule_events.event_date = event_date;
END//

-- Missed Events

CREATE PROCEDURE new_missed_event(user_id int, event_id INT, arrival_time DATETIME, event_name varchar(255))
BEGIN
	INSERT INTO missed_events(user_id, event_id, arrival_time, event_name)
    VALUES(user_id, event_id, arrival_time, event_name);
END//

CREATE PROCEDURE update_missed_event(user_id int, event_id INT, arrival_time DATETIME, event_name varchar(255))
BEGIN
	UPDATE missed_events
    SET missed_events.event_name = event_name, missed_events.arrival_time = arrival_time
    WHERE missed_events.user_id = user_id AND missed_events.event_id = event_id;
END//

CREATE PROCEDURE get_missed_event(event_id INT)
BEGIN
	SELECT missed_event_id, arrival_time, event_name
    FROM missed_events
    WHERE missed_events.event_id = event_id;
END//

-- Daily Sleep Logs

CREATE PROCEDURE new_daily_sleep_log(user_id INT, log_date DATE, bed_time TIME, wake_time TIME, latency_mins SMALLINT, awakenings_count TINYINT, awakening_latency_mins SMALLINT, rating_1_10 TINYINT)
BEGIN
	INSERT INTO daily_sleep_logs(user_id, log_date, bed_time, wake_time, latency_mins, awakenings_count, awakening_latency_mins, rating_1_10)
    VALUES(user_id, log_date, bed_time, wake_time, latency_mins, awakenings_count, awakening_latency_mins, rating_1_10);
END//

CREATE PROCEDURE update_daily_sleep_log(user_id INT, log_date DATE, bed_time TIME, wake_time TIME, latency_mins SMALLINT, awakenings_count TINYINT, awakening_latency_mins SMALLINT, rating_1_10 TINYINT)
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

CREATE PROCEDURE new_pre_sleep_behavior(log_id INT, fatigue_score TINYINT, alertness_score TINYINT, caffeine_cups TINYINT, melatonin_mg DECIMAL(4,2), last_meal_hrs DECIMAL(4,1), last_meal_size TINYINT, exercise_mins SMALLINT, exercise_intensity TINYINT)
BEGIN
	INSERT INTO pre_sleep_behaviors(log_id, fatigue_score, alertness_score, caffeine_cups, melatonin_mg, last_meal_hrs, last_meal_size, exercise_mins, exercise_intensity)
    VALUES(log_id, fatigue_score, alertness_score, caffeine_cups, melatonin_mg, last_meal_hrs, last_meal_size, exercise_mins, exercise_intensity);
END//

CREATE PROCEDURE update_pre_sleep_behavior(log_id INT, fatigue_score TINYINT, alertness_score TINYINT, caffeine_cups TINYINT, melatonin_mg DECIMAL(4,2), last_meal_hrs DECIMAL(4,1), last_meal_size TINYINT, exercise_mins SMALLINT, exercise_intensity TINYINT)
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

-- Biometric Profiles

CREATE PROCEDURE new_biometric_profiles(user_id INT, age TINYINT, gender ENUM('Male', 'Female'), height_cm DECIMAL(5,2), weight_kg DECIMAL(5,2))
BEGIN
	INSERT INTO biometric_profiles(user_id, age, gender, height_cm, weight_kg)
    VALUES(user_id, age, gender, height_cm, weight_kg);
END//

CREATE PROCEDURE update_biometric_profiles(profile_id INT, age TINYINT, gender ENUM('Male', 'Female'), height_cm DECIMAL(5,2), weight_kg DECIMAL(5,2))
BEGIN
	UPDATE biometric_profiles
    SET biometric_profiles.age = age, biometric_profiles.gender = gender, biometric_profiles.height_cm = height_cm, biometric_profiles.weight_kg = weight_kg
    WHERE biometric_profiles.profile_id = profile_id;
END//

CREATE PROCEDURE get_biometric_profiles(profile_id INT)
BEGIN
	SELECT profile_id, age, gender, height_cm, weight_kg
    FROM biometric_profiles
    WHERE biometric_profiles.profile_id = profile_id;
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

CREATE TRIGGER insert_pre_sleep_behavior_audit
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

-- Schedule Events

CREATE TRIGGER insert_schedule_event_audit
AFTER INSERT ON schedule_events
FOR EACH ROW
BEGIN
	INSERT INTO schedule_events_audit(audit_type, event_id, new_event_name, new_start_time, new_end_time, new_event_date, new_instance_type, new_routine_frequency)
	VALUES("Insert", new.event_id, new.event_name, new.start_time, new.end_time, new.event_date, new.instance_type, new.routine_frequency);
END//

CREATE TRIGGER update_schedule_event_audit
AFTER UPDATE ON schedule_events
FOR EACH ROW
BEGIN
	INSERT INTO schedule_events_audit(audit_type, event_id, new_event_name, old_event_name, new_start_time, old_start_time, new_end_time, old_end_time, new_event_date, old_event_date, new_instance_type, old_instance_type, new_routine_frequency, old_routine_frequency)
	VALUES("Update", old.event_id, new.event_name, old.event_name, new.start_time, old.start_time, new.end_time, old.end_time, new.event_date, old.event_date, new.instance_type, old.instance_type, new.routine_frequency, old.routine_frequency);
END//

CREATE TRIGGER delete_schedule_event_audit
AFTER DELETE ON schedule_events
FOR EACH ROW
BEGIN
	INSERT INTO schedule_events_audit(audit_type, event_id, old_event_name, old_start_time, old_end_time, old_event_date, old_instance_type, old_routine_frequency)
	VALUES("Delete", old.event_id, old.event_name, old.start_time, old.end_time, old.event_date, old.instance_type, old.routine_frequency);
END//

DELIMITER ;


