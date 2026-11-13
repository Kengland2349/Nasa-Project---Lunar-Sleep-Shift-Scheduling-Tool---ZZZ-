/*
* Sleep Database Declaration
* This file declares the tables used in the sleep database.
*
* Tables: users, schedule_events, daily_sleep_logs, pre_sleep_behaviors, biometric_profiles
* Audits: pre_sleep_behaviors, daily_sleep_logs, schedule_events
*
*/


-- create the database
DROP DATABASE IF EXISTS sleepyNASA;
CREATE DATABASE sleepyNASA;

-- select the database
USE sleepyNASA;


CREATE TABLE users(
 user_id int NOT NULL AUTO_INCREMENT,
 user_name varchar(255) UNIQUE NOT NULL,
 secured_password varchar(64) NOT NULL,
 
 PRIMARY KEY(user_id)
);
CREATE INDEX idx_user_user_name ON users(user_name);


CREATE TABLE daily_sleep_logs ( 
log_id INT AUTO_INCREMENT PRIMARY KEY, 
user_id INT NOT NULL, 
log_date DATE NOT NULL UNIQUE,
bed_time TIME NOT NULL, 
wake_time TIME NOT NULL,
latency_mins SMALLINT DEFAULT 0, 
awakenings_count TINYINT DEFAULT 0, 
awakening_latency_mins SMALLINT DEFAULT 0,
rating_1_10 TINYINT CHECK (rating_1_10 BETWEEN 1 AND 10), 
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE, 
UNIQUE KEY uq_user_date (user_id, log_date) 
) 
ENGINE=InnoDB;


CREATE TABLE pre_sleep_behaviors ( 
behavior_id INT AUTO_INCREMENT PRIMARY KEY,
log_id INT NOT NULL,
fatigue_score TINYINT CHECK (fatigue_score BETWEEN 0 AND 10),
alertness_score TINYINT CHECK (alertness_score BETWEEN 0 AND 10),
caffeine_cups TINYINT DEFAULT 0,
melatonin_mg DECIMAL(4,2) DEFAULT 0.0,
last_meal_hrs DECIMAL(4,1) NOT NULL,
last_meal_size INT CHECK (last_meal_size BETWEEN 1 AND 5),
exercise_mins SMALLINT DEFAULT 0,
exercise_intensity TINYINT CHECK (exercise_intensity BETWEEN 0 AND 10),

FOREIGN KEY (log_id) REFERENCES daily_sleep_logs(log_id) ON DELETE CASCADE
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


CREATE TABLE schedule_events(

event_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
user_id INT NOT NULL,
event_name VARCHAR(255) NOT NULL,
start_time TIME NOT NULL,
end_time TIME NOT NULL,
event_date DATE NOT NULL,
instance_type ENUM('Single', 'Routine') NOT NULL,
routine_frequency ENUM('Daily', 'Weekly', 'Monthly') DEFAULT NULL,

FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE missed_events(

missed_event_id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT NOT NULL,
event_id INT NOT NULL UNIQUE,
arrival_time DATETIME,
event_name varchar(255),
FOREIGN KEY(event_id) REFERENCES schedule_events(event_id) ON DELETE CASCADE,
UNIQUE KEY uq_user_event (user_id, event_id)
FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Audit tables

CREATE TABLE pre_sleep_behaviors_audit ( 

pre_sleep_audit_id INT AUTO_INCREMENT PRIMARY KEY,
pre_sleep_audit_type ENUM("Insert", "Update", "Delete") NOT NULL,
behavior_id INT NOT NULL,

old_fatigue_score TINYINT,
new_fatigue_score TINYINT,
old_alertness_score TINYINT,
new_alertness_score TINYINT,
old_caffeine_cups TINYINT,
new_caffeine_cups TINYINT,
old_melatonin_mg DECIMAL(4,2),
new_melatonin_mg DECIMAL(4,2),
old_last_meal_hrs DECIMAL(4,1),
new_last_meal_hrs DECIMAL(4,1),
old_last_meal_size INT,
new_last_meal_size INT,
old_exercise_mins SMALLINT,
new_exercise_mins SMALLINT,
old_exercise_intensity TINYINT,
new_exercise_intensity TINYINT,

FOREIGN KEY (behavior_id) REFERENCES pre_sleep_behaviors(behavior_id)
) 
ENGINE=InnoDB;


CREATE TABLE daily_sleep_logs_audit ( 

log_audit_id INT AUTO_INCREMENT PRIMARY KEY,
log_audit_type ENUM("Insert", "Update", "Delete") NOT NULL,
log_id INT, 
log_date DATE NOT NULL UNIQUE,
old_bed_time TIME NOT NULL, 
new_bed_time TIME, 
old_wake_time TIME NOT NULL,
new_wake_time TIME,
old_latency_mins SMALLINT, 
new_latency_mins SMALLINT, 
old_awakenings_count TINYINT, 
new_awakenings_count TINYINT, 
old_rating_1_10 TINYINT, 
new_rating_1_10 TINYINT, 
created_at TIMESTAMP,

FOREIGN KEY (log_id) REFERENCES daily_sleep_logs(log_id)
) 
ENGINE=InnoDB;

CREATE TABLE schedule_events_audit(

audit_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
audit_type varchar(8) NOT NULL,
event_id INT NOT NULL,

new_event_name varchar(255),
old_event_name varchar(255),
new_start_time time,
old_start_time time,
new_end_time time,
old_end_time time,
new_event_date DATE,
old_event_date DATE,
new_instance_type ENUM('Single', 'Routine'),
old_instance_type ENUM('Single', 'Routine'),

CONSTRAINT fk_events_audit FOREIGN KEY(event_id) REFERENCES schedule_events(event_id)
);
