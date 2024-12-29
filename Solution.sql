-- 1. Count the number of Movies vs TV Shows

SELECT 
 type,
 count(show_id) as COUNT 
FROM netflix
GROUP BY type


-- 2. Find the most common rating for movies and TV shows

SELECT 
    type,
    rating
FROM (
    SELECT 
    type,
    rating,
    COUNT(*),
    RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) as Ranking
FROM
    netflix
GROUP BY 
    type, rating
) as T1
WHERE Ranking = 1


-- 3. List all movies released in a specific year (e.g., 2020)

SELECT * 
FROM 
    netflix 
WHERE 
    type = 'Movie'  and release_year = 2020 ;


-- 4. Find the top 5 countries with the most content on Netflix

SELECT
    UNNEST(STRING_TO_ARRAY(country, ',')) as new_country,
    COUNT(show_id) as total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


-- 5. Identify the longest movie

SELECT 
    *
FROM 
    netflix
WHERE 
    type = 'Movie' and duration = (SELECT MAX(duration) FROM netflix) 


-- 6. Find content added in the last 5 years

SELECT *
FROM netflix
WHERE
    date_added >= CURRENT_DATE - INTERVAL '5 YEARS'
    


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT *
FROM netflix
WHERE 
    director LIKE '%Rajiv Chilaka%'


-- 8. List all TV shows with more than 5 seasons

SELECT *
FROM netflix
WHERE 
    type = 'TV Show'
    AND SPLIT_PART(duration, ' ', 1)::numeric > 5


-- 9. Count the number of content items in each genre

SELECT  
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
    COUNT(show_id)
FROM
    netflix
GROUP BY 1


-- 10.Find each year and the average numbers of content release in India on netflix. 
-- return top 5 year with highest avg content release!

SELECT  
    COUNT(show_id) as contentCount,
    ROUND(COUNT(*)::numeric/(SELECT Count(show_id) FROM netflix WHERE country = 'India')::numeric * 100
    , 2) as PercentageOfTotal,
    release_year
FROM
    netflix
WHERE 
    country = 'India'
GROUP BY release_year
ORDER BY PercentageOfTotal DESC
LIMIT 5


-- 11. List all movies that are documentaries

SELECT *
FROM netflix
WHERE
    listed_in ILIKE '%documentaries%' AND type = 'Movie'


-- 12. Find all content without a director

SELECT *
FROM netflix
WHERE 
    director IS NULL


-- 13. Find how many movies actor 'Luna Wedler' appeared in last 10 years!

SELECT *
FROM netflix
WHERE "cast" ILIKE '%Luna Wedler%' AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;




