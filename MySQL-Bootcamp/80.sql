CREATE database shirts_db;
USE shirts_db;

CREATE TABLE shirts (
    shirt_id INT AUTO_INCREMENT PRIMARY KEY,
    article VARCHAR(20),
    color VARCHAR(20),
    shirt_size VARCHAR(5),
    last_worn INT
);

insert into shirts
	(article, color, shirt_size, last_worn)
values 
	('t-shirt', 'white', 'S', 10),
	('t-shirt', 'green', 'S', 200),
	('polo shirt', 'black', 'M', 10),
	('tank top', 'blue', 'S', 50),
	('t-shirt', 'pink', 'S', 0),
	('polo shirt', 'red', 'M', 5),
	('tank top', 'white', 'S', 200),
	('tank top', 'blue', 'M', 15);
    
SELECT 
    *
FROM
    shirts;

insert into shirts (article, color, shirt_size, last_worn)
values ('polo shirt', 'purple', 'M', 50);


SELECT 
    article, color
FROM
    shirts;

SELECT 
    article, color, shirt_size, last_worn
FROM
    shirts
WHERE
    shirt_size LIKE 'M';

UPDATE shirts 
SET 
    shirt_size = 'L';

UPDATE shirts 
SET 
    last_worn = 0
WHERE
    last_worn = 15;

UPDATE shirts 
SET 
    shirt_size = 'XS',
    color = 'off white'
WHERE
    color = 'white';

DELETE FROM shirts 
WHERE
    last_worn = 200;

DELETE FROM shirts 
WHERE
    article LIKE 'tank top';

DELETE FROM shirts;

drop database shirts_db;