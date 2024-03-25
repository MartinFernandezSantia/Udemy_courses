-- It's recommended to keep triggers in a separated file.

CREATE DATABASE trigger_demo;
USE trigger_demo;

CREATE TABLE users(
	username VARCHAR(100),
    age INT
);

-- DELIMITER statement is used to change the standard delimiter (usually a semicolon ;) used to 
-- 	terminate SQL statements within a script or query.
DELIMITER $$
CREATE TRIGGER must_be_adult
     BEFORE INSERT ON users FOR EACH ROW
     BEGIN
          IF NEW.age < 18
          THEN
              SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Must be an adult!';
          END IF;
     END;
$$ 
DELIMITER ;

INSERT INTO users (username, age) VALUES ('Bobby', 23);
INSERT INTO users (username, age) VALUES ('Sally', 54);
INSERT INTO users (username, age) VALUES ('Sue', 16);

-- Prevent self following
USE ig_clone

DELIMITER $$
	CREATE TRIGGER prevent_self_follows
		BEFORE INSERT ON follows FOR EACH ROW
		BEGIN
			IF NEW.follower_id = NEW.followee_id
			THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = "Can't follow yourself!";
			END IF;
		END;
$$
DELIMITER ;

INSERT INTO follows(follower_id, followee_id) VALUES (5, 5);

-- Logging Unfollows
CREATE TABLE unfollows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);

DELIMITER $$
	CREATE TRIGGER unfollows_logger
		AFTER DELETE ON follows FOR EACH ROW
        BEGIN
			INSERT INTO unfollows (follower_id, followee_id) 
				VALUES (OLD.follower_id, OLD.followee_id);
        END;
$$
DELIMITER ;

DELETE FROM follows WHERE follower_id = 2 AND followee_id = 1;
SELECT * FROM unfollows;

SHOW TRIGGERS;
-- DROP TRIGGER trigger_name