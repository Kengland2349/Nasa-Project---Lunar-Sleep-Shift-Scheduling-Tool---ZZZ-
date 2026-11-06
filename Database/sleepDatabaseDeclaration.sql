
-- create the database
DROP DATABASE IF EXISTS sleepyNASA;
CREATE DATABASE sleepyNASA;

-- select the database
USE sleepyNASA;

-- clean
CREATE TABLE users(
 user_id int NOT NULL AUTO_INCREMENT,
 user_name varchar(255) UNIQUE NOT NULL,
 email varchar(255) UNIQUE NOT NULL,
 secured_password varchar(64) NOT NULL,
 
 PRIMARY KEY(userID)
);
CREATE INDEX idx_user_user_name ON users(user_name);

/*
behavior_id
log_id
fatigue_score
alertness_score
caffeine_cups
melatonin_mg
last_meal_hrs
exercise_mins
exercise_intensity
*/
CREATE TABLE pre_sleep_behaviors ( 
behavior_id INT AUTO_INCREMENT PRIMARY KEY,
log_id INT NOT NULL,
fatigue_score TINYINT CHECK (fatigue_score BETWEEN 0 AND 10),
alertness_score TINYINT CHECK (alertness_score BETWEEN 0 AND 10),
caffeine_cups TINYINT DEFAULT 0,
melatonin_mg DECIMAL(4,2) DEFAULT 0.0,
last_meal_hrs DECIMAL(4,1) NOT NULL,
exercise_mins SMALLINT DEFAULT 0,
exercise_intensity TINYINT CHECK (exercise_intensity BETWEEN 0 AND 10),

FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE, 
UNIQUE KEY uq_user_date (user_id, log_date) 
) 
ENGINE=InnoDB;

/*
log_id
user_id
bed_time
wake_time
latency_mins
awakenings_count
rating_1_10
*/
CREATE TABLE daily_sleep_logs ( 
log_id INT AUTO_INCREMENT PRIMARY KEY, 
user_id INT NOT NULL, 
log_date DATE NOT NULL,
bed_time DATETIME NOT NULL, 
wake_time DATETIME NOT NULL,
latency_mins SMALLINT DEFAULT 0, 
awakenings_count TINYINT DEFAULT 0, 
awakenings_avg_mins SMALLINT DEFAULT 0, 
rating_1_10 TINYINT CHECK (rating_1_10 BETWEEN 1 AND 10), 
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE, 
UNIQUE KEY uq_user_date (user_id, log_date) 
) 
ENGINE=InnoDB;


CREATE TABLE biometric_profiles ( 

profile_id INT AUTO_INCREMENT PRIMARY KEY, 
user_id INT NOT NULL UNIQUE, 

age TINYINT NOT NULL CHECK (age BETWEEN 10 AND 120), 
gender ENUM('Male', 'Female') NOT NULL, 
height_cm DECIMAL(5,2) NOT NULL,
weight_kg DECIMAL(5,2) NOT NULL, 

FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
)
ENGINE=InnoDB; 

/*
schedule_id
user_id
busy_start
busy_end
event_label
*/
CREATE TABLE schedule_events(

eventID INT NOT NULL AUTO_INCREMENT,
user_id INT NOT NULL,
event_name varchar(255) ,
start_time time NOT NULL,
end_time time NOT NULL,
instance_type ENUM('Single', 'Routine'),

PRIMARY KEY(eventID),

FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE missed_events(

event_id INT NOT NULL AUTO_INCREMENT,
user_id int,
planned_time DATETIME,
arrival_time DATETIME,

FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Audit tables

CREATE TABLE night_records_audit(

auditID INT NOT NULL AUTO_INCREMENT,
auditType varchar(8) NOT NULL,
nightID int NOT NULL,

newFatigueLevel INT,
oldFatigueLevel INT,
newAlertLevel INT,
oldAlertLevel INT,
newMealTime time,
oldMealTime time,
newCaffieneTime time,
oldCaffieneTime time,
newMelatoninCount INT,
oldMelatoninCount INT,
newSleepCount INT,
oldSleepCount INT,
newExcerciseTime time,
oldExcerciseTime time,
newExerciseIntensity INT,
oldExerciseIntensity INT,
auditDate datetime,

PRIMARY KEY(auditID),

CONSTRAINT fk_night_audit
FOREIGN KEY(nightID) REFERENCES night_records(nightID)
);

CREATE TABLE morning_records_audit(

auditID INT NOT NULL AUTO_INCREMENT,
auditType varchar(8) NOT NULL,
morningID INT NOT NULL,

newWakeTime time,
oldWakeTime time,
newSleepDelay INT,
oldSleepDelay INT,
newAwakenCount INT,
oldAwakenCount INT,
newAwakenTime INT,
oldAwakenTime INT,
newQualityLevel INT,
oldQualityLevel INT,
auditDate datetime,

PRIMARY KEY(auditID),

CONSTRAINT fk_morning_audit
FOREIGN KEY(morningID) REFERENCES morning_records(morningID)
);

CREATE TABLE schedule_events_audit(

auditID INT NOT NULL AUTO_INCREMENT,
auditType varchar(8) NOT NULL,
eventID INT NOT NULL,

newEventName varchar(255),
oldEventName varchar(255),
newStartTime time,
oldStartTime time,
newEndTime time,
oldEndTime time,
newInstanceType ENUM('Single', 'Routine'),
oldInstanceType ENUM('Single', 'Routine'),

PRIMARY KEY(auditID),

CONSTRAINT fk_events_audit
FOREIGN KEY(eventID) REFERENCES schedule_events(eventID)
);
