CREATE TABLE users(
 user_ID int NOT NULL AUTO_INCREMENT,
 user_Name varchar(255) UNIQUE,
 secured_Password varchar(255),
 
 PRIMARY KEY(user_ID)
);

CREATE TABLE night_records(
night_ID int NOT NULL AUTO_INCREMENT,
user_ID int,

fatigueLevel int,
alertLevel int,
caffieneTime time,



PRIMARY KEY(night_ID),

CONSTRAINT fk_night_users
FOREIGN KEY(user_ID) REFERENCES users(user_ID)
);

CREATE TABLE morning_records(
morning_ID int NOT NULL AUTO_INCREMENT,
user_ID int,


PRIMARY KEY(morning_ID),

CONSTRAINT fk_morning_users
FOREIGN KEY(user_ID) REFERENCES users(user_ID)
);