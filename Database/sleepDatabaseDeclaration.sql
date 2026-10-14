CREATE TABLE users(
 user_ID int NOT NULL AUTO_INCREMENT,
 user_Name varchar(255) UNIQUE NOT NULL,
 secured_Password varchar(255) NOT NULL,
 
 PRIMARY KEY(user_ID)
);

CREATE TABLE night_records(
night_ID int NOT NULL AUTO_INCREMENT,
user_ID int,

fatigueLevel int NOT NULL,
alertLevel int NOT NULL,
mealTime time NOT NULL,
caffieneTime time NOT NULL,
melatoninCount int NOT NULL,
sleepCount int NOT NULL,
excerciseTime time,
exerciseIntensity int,
recordDate datetime NOT NULL,


PRIMARY KEY(night_ID),

CONSTRAINT fk_night_users
FOREIGN KEY(user_ID) REFERENCES users(user_ID)
);

CREATE TABLE morning_records(
morning_ID int NOT NULL AUTO_INCREMENT,
user_ID int,

wakeTime time NOT NULL,
sleepDelay int NOT NULL,
awakenCount int NOT NULL,
awakenTime int NOT NULL,
qualityLevel int NOT NULL,
recordDate datetime NOT NULL,

PRIMARY KEY(morning_ID),

CONSTRAINT fk_morning_users
FOREIGN KEY(user_ID) REFERENCES users(user_ID)
);

CREATE TABLE night_records_audit(
night_ID int NOT NULL,

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
FOREIGN KEY(user_ID) REFERENCES users(user_ID)
);

CREATE TABLE morning_records_audit(
morning_ID int NOT NULL,

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
FOREIGN KEY(user_ID) REFERENCES users(user_ID)
);
