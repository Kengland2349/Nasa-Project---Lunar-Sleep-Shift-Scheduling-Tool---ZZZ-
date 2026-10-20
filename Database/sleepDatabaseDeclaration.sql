CREATE TABLE users(
 userID int NOT NULL AUTO_INCREMENT,
 userName varchar(255) UNIQUE NOT NULL,
 securedPassword varchar(255) NOT NULL,
 
 PRIMARY KEY(user_ID)
);

CREATE TABLE night_records(
nightID int NOT NULL AUTO_INCREMENT,
userID int,

fatigueLevel int NOT NULL,
alertLevel int NOT NULL,
mealTime time NOT NULL,
caffieneTime time NOT NULL,
melatoninCount int NOT NULL,
sleepCount int NOT NULL,
excerciseTime time,
exerciseIntensity int,
recordDate datetime NOT NULL,


PRIMARY KEY(nightID),

CONSTRAINT fk_night_userID
FOREIGN KEY(userID) REFERENCES users(userID)
);

CREATE TABLE morning_records(
morningID int NOT NULL AUTO_INCREMENT,
userID int,

wakeTime time NOT NULL,
sleepDelay int NOT NULL,
awakenCount int NOT NULL,
awakenTime int NOT NULL,
qualityLevel int NOT NULL,
recordDate datetime NOT NULL,

PRIMARY KEY(morningID),

CONSTRAINT fk_morning_userID
FOREIGN KEY(userID) REFERENCES users(userID)
);

CREATE TABLE night_records_audit(
nightID int NOT NULL,

newFatigueLevel int,
oldFatigueLevel int,
newAlertLevel int,
oldAlertLevel int,
newMealTime time,
oldMealTime time,
newCaffieneTime time,
oldCaffieneTime time,
newMelatoninCount int,
oldMelatoninCount int,
newSleepCount int,
oldSleepCount int,
newExcerciseTime time,
oldExcerciseTime time,
newExerciseIntensity int,
oldExerciseIntensity int,
auditDate datetime,


CONSTRAINT fk_night_users
FOREIGN KEY(userID) REFERENCES users(userID)
);

CREATE TABLE morning_records_audit(
morningID int NOT NULL,

newWakeTime time,
oldWakeTime time,
newSleepDelay int,
oldSleepDelay int,
newAwakenCount int,
oldAwakenCount int,
newAwakenTime int,
oldAwakenTime int,
newQualityLevel int,
oldQualityLevel int,
auditDate datetime,

CONSTRAINT fk_morning_users
FOREIGN KEY(userID) REFERENCES users(userID)
);

CREATE TABLE userStat(
statID int NOT NULL AUTO_INCREMENT,
userID int,

PRIMARY KEY(statID),

CONSTRAINT fk_events_userID
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

CONSTRAINT fk_events_userID
FOREIGN KEY(userID) REFERENCES users(userID)
);