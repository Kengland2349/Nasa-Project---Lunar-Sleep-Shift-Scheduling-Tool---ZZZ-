
CREATE TABLE users(
 userID int NOT NULL AUTO_INCREMENT,
 userName varchar(255) UNIQUE NOT NULL,
 securedPassword varchar(255) NOT NULL,
 
 PRIMARY KEY(userID)
);

CREATE TABLE night_records(
nightID int NOT NULL AUTO_INCREMENT,
userID INT,

fatigueLevel INT NOT NULL,
alertLevel INT NOT NULL,
mealTime time NOT NULL,
caffieneTime time NOT NULL,
melatoninCount INT NOT NULL,
sleepCount INT NOT NULL,
excerciseTime time,
exerciseIntensity INT,
recordDate datetime NOT NULL,


PRIMARY KEY(nightID),

CONSTRAINT fk_night_userID
FOREIGN KEY(userID) REFERENCES users(userID)
);

CREATE TABLE morning_records(
morningID INT NOT NULL AUTO_INCREMENT,
userID INT,

wakeTime time NOT NULL,
sleepDelay INT NOT NULL,
awakenCount INT NOT NULL,
awakenTime INT NOT NULL,
qualityLevel INT NOT NULL,
recordDate datetime NOT NULL,

PRIMARY KEY(morningID),

CONSTRAINT fk_morning_userID
FOREIGN KEY(userID) REFERENCES users(userID)
);


CREATE TABLE user_bio(

bioID INT NOT NULL AUTO_INCREMENT,
userID INT NOT NULL,

age INT NOT NULL,
height INT NOT NULL,
weight INT NOT NULL,
gender ENUM('M', 'F', 'Other'),


PRIMARY KEY(bioID),

CONSTRAINT fk_bio_userID
FOREIGN KEY(userID) REFERENCES users(userID)
);

CREATE TABLE schedule_events(

eventID INT NOT NULL AUTO_INCREMENT,
userID INT NOT NULL,
eventName varchar(255) NOT NULL,
startTime time NOT NULL,
endTime time NOT NULL,
instanceType ENUM('Single', 'Routine'),

PRIMARY KEY(eventID),

CONSTRAINT fk_events_user
FOREIGN KEY(userID) REFERENCES users(userID)
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
FOREIGN KEY(userID) REFERENCES morning_records(userID)
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

drop table userbio;