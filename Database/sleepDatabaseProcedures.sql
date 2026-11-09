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

CREATE PROCEDURE new_daily_sleep_log(user_id INT, log_date DATE, bed_time DATETIME, wake_time DATETIME, latency_mins SMALLINT, awakenings_count TINYINT, rating_1_10 TINYINT)
BEGIN
	INSERT INTO daily_sleep_logs(user_id, log_date, bed_time, wake_time, latency_mins, awakenings_count, rating_1_10)
    VALUES(user_id, log_date, bed_time, wake_time, latency_mins, awakenings_count, rating_1_10);
END//

CREATE PROCEDURE update_daily_sleep_log(user_id INT, log_date DATE, bed_time DATETIME, wake_time DATETIME, latency_mins SMALLINT, awakenings_count TINYINT, rating_1_10 TINYINT)
BEGIN
	UPDATE daily_sleep_logs
    SET daily_sleep_logs.bed_time = bed_time, daily_sleep_logs.wake_time = wake_time, daily_sleep_logs.latency_mins = latency_mins, daily_sleep_logs.awakenings_count = awakenings_count, daily_sleep_logs.rating_1_10 = rating_1_10
    WHERE daily_sleep_logs.user_id = user_id AND daily_sleep_logs.log_date = log_date;
END//

CREATE PROCEDURE get_daily_sleep_log(user_id int, log_date DATE)
BEGIN
	SELECT log_id, bed_time, wake_time, latency_mins, awakenings_count, rating_1_10
    FROM daily_sleep_logs
    WHERE daily_sleep_logs.user_id = user_id AND daily_sleep_logs.log_date = log_date;
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
DELIMITER ;


