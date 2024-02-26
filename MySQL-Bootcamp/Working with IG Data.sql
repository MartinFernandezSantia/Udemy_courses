USE ig_clone;

-- Challenge #1
SELECT 
    *
FROM
    users
ORDER BY created_at
LIMIT 5;

-- Challenge #2
SELECT 
    DAYNAME(created_at) AS day, COUNT(*) AS users_registered
FROM
    users
GROUP BY day
ORDER BY users_registered DESC;

-- Challenge #3
SELECT 
    u.username
FROM
    users AS u
        LEFT JOIN
    photos AS p ON p.user_id = u.id
WHERE
    p.id IS NULL;

-- Challenge #4
SELECT 
    p.id, p.image_url, COUNT(*) AS likes, u.username
FROM
    photos AS p
        JOIN
    likes AS l ON p.id = l.photo_id
        JOIN
    users AS u ON u.id = p.user_id
GROUP BY p.id
ORDER BY likes DESC
LIMIT 1;

-- Challenge #5
select 
	(select count(*) from photos) / (select count(*) from users) as avg_user_post;
    
-- Challenge #6
select t.tag_name
from tags t
join photo_tags pt
	on t.id = pt.tag_id
group by pt.tag_id
order by count(*) desc
limit 5;

-- Challenge #7
select u.username, count(*) as likes
from likes as l
join users as u
	on u.id = l.user_id
group by l.user_id
having likes = (select count(*) from photos);
