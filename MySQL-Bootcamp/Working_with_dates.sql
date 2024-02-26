use book_shop;

create table people (
	name varchar(100),
    birthdate date,
    birthtime time,
    birthdt datetime
);

insert into people (name, birthdate, birthtime, birthdt) 
values ('Elton','2000-12-25','11:00:00','2000-12-25 11:00:00');

insert into people (name, birthdate, birthtime, birthdt) 
values ('Lulu','1985-04-11','9:45:10','1985-04-11 9:45:10');

insert into people (name, birthdate, birthtime, birthdt) 
values ('Juan','2020-08-15','23:59:00','2020-08-15 23:59:00');

select * from people;

select curdate(), curtime(), now();

insert into people (name, birthdate, birthtime, birthdt)
values ('Hazel', curdate(), curtime(), now());

SELECT 
    birthdate,
    DAY(birthdate),
    DAYOFWEEK(birthdate),
    DAYOFYEAR(birthdate)
FROM people;
 
SELECT 
    birthdate,
    MONTHNAME(birthdate),
    YEAR(birthdate)
FROM people;

SELECT 
    birthtime,
    HOUR(birthtime),
    MINUTE(birthtime)
FROM people;
 
SELECT 
    birthdt,
    MONTH(birthdt),
    DAY(birthdt),
    HOUR(birthdt),
    MINUTE(birthdt)
FROM people;

SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %D') FROM people;
 
SELECT birthdt, DATE_FORMAT(birthdt, '%H:%i') FROM people;
 
SELECT birthdt, DATE_FORMAT(birthdt, 'BORN ON: %r') FROM people;

CREATE TABLE captions (
  text VARCHAR(150),
  created_at TIMESTAMP default CURRENT_TIMESTAMP
);
 
CREATE TABLE captions2 (
  text VARCHAR(150),
  created_at TIMESTAMP default CURRENT_TIMESTAMP,
  updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Excersises

create table inventory (
	item_name varchar(50),
    price decimal(9, 3),
    quantity mediumint unsigned
);

select curtime();
select curdate();
select dayofweek(curdate());
select dayname(curdate());
select date_format(curdate(), '%m/%d/%Y');
select date_format(current_timestamp(), '%M %D at %k:%i');

create table tweets (
	content varchar(250),
    username varchar(50),
    creation_time timestamp default now()
);

insert into tweets (content, username) values ('Hey, what\'s up', 'Esmoquin5256');
select * from tweets;