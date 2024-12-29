DROP TABLE IF EXISTS netflix;

CREATE TABLE netflix (
    show_id	VARCHAR(256),
    "type" 	VARCHAR(256),
    title	VARCHAR(256),
    director	VARCHAR(256),
    "cast" VARCHAR(2500),	
    country	VARCHAR(256),
    date_added  date,
    release_year INT,
    rating	VARCHAR(256),
    duration	VARCHAR(256),
    listed_in	VARCHAR(256),
    "description" VARCHAR(2000)
);

SELECT * FROM netflix LIMIT 50;