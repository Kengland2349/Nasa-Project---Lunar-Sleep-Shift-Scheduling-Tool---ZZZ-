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