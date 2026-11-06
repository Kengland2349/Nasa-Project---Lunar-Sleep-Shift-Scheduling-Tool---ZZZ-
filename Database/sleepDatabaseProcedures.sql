DROP PROCEDURE IF EXISTS login;
DROP PROCEDURE IF EXISTS register;
DROP PROCEDURE IF EXISTS newEvent;
DROP PROCEDURE IF EXISTS updateEvent;
DROP PROCEDURE IF EXISTS deleteEvent;
DROP PROCEDURE IF EXISTS newMorningSurvey;
DROP PROCEDURE IF EXISTS updateMorningSurvey;
DROP PROCEDURE IF EXISTS pullMorningSurvey;

DELIMITER //

-- Procedures

-- USER

CREATE PROCEDURE login(userName varchar(255))
BEGIN
	SELECT userID, securedPassword
    FROM users
    WHERE users.userName = userName;
END//

CREATE PROCEDURE register(userName varchar(255), userEmail varchar(255), hashPassword varchar(255))
BEGIN
	INSERT INTO users(userName, userEmail, securedPassword)
    VALUE(userName, userEmail, hashPassword);
END//

-- SCHEDULE

CREATE PROCEDURE newEvent(userID int, eventName varchar(255), startTime time, endTime time, instanceType enum('Single','Routine'))
BEGIN
	INSERT INTO schedule_events(userID, eventName, startTime, endTime ,instanceType)
    VALUE(userID, eventName, startTime, endTime, instanceType);
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

CREATE PROCEDURE newMorningSurvey(userID int, wakeTime time, sleepDelay int, awakenCount int, awakenTime int, qualityLevel int)
BEGIN
	INSERT INTO schedule_events(userID, wakeTime, sleepDelay, awakenCount ,awakenTime, qualityLevel, recordDate)
    VALUE(userID, wakeTime, sleepDelay, awakenCount, awakenTime, qualityLevel, current_timestamp());
END//

CREATE PROCEDURE updateMorningSurvey(userID int, wakeTime time, sleepDelay int, awakenCount int, awakenTime int, qualityLevel int, recordDate datetime)
BEGIN
	UPDATE morning_records
    SET morning_records.wakeTime = wakeTime, morning_records.sleepDelay = sleepDelay, morning_records.awakenCount = awakenCount, morning_records.awakenTime = awakenTime, morning_records.qualityLevel = qualityLevel
    WHERE morning_records.userID = userID AND morning_records.recordDate = recordDate;
END//

CREATE PROCEDURE pullMorningSurvey(userID int)
BEGIN
	SELECT *
    FROM morning_records
    WHERE morning_records.userID = userID;
END//

-- Triggers
CREATE TRIGGER 

CREATE

DELIMITER ;


