# Netflix Movies and TV Shows Data Analysis using SQL and PostgreSQL

![](https://github.com/Hansal13/Netflix/blob/main/Netflix.jpg)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset

- **Dataset Link:** [Movies Dataset](https://github.com/Hansal13/Netflix/blob/main/netflix_titles.csv)

## Schema

```sql
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
```

## Business Problems and Solutions

### 1. Count the Number of Movies vs TV Shows

```sql
SELECT 
 type,
 count(show_id) as COUNT 
FROM netflix
GROUP BY type
```

**Objective:** Determine the distribution of content types on Netflix.

### 2. Find the Most Common Rating for Movies and TV Shows

```sql
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
```

**Objective:** Identify the most frequently occurring rating for each type of content.

### 3. List All Movies Released in a Specific Year (e.g., 2020)

```sql
SELECT * 
FROM 
    netflix 
WHERE 
    type = 'Movie'  and release_year = 2020 ;
```

**Objective:** Retrieve all movies released in a specific year.

### 4. Find the Top 5 Countries with the Most Content on Netflix

```sql
SELECT
    UNNEST(STRING_TO_ARRAY(country, ',')) as new_country,
    COUNT(show_id) as total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```

**Objective:** Identify the top 5 countries with the highest number of content items.

### 5. Identify the Longest Movie

```sql
SELECT 
    *
FROM 
    netflix
WHERE 
    type = 'Movie' and duration = (SELECT MAX(duration) FROM netflix) 
```

**Objective:** Find the movie with the longest duration.

### 6. Find Content Added in the Last 5 Years

```sql
SELECT *
FROM netflix
WHERE
    date_added >= CURRENT_DATE - INTERVAL '5 YEARS'
```

**Objective:** Retrieve content added to Netflix in the last 5 years.

### 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

```sql
SELECT *
FROM netflix
WHERE 
    director LIKE '%Rajiv Chilaka%'
```

**Objective:** List all content directed by 'Rajiv Chilaka'.

### 8. List All TV Shows with More Than 5 Seasons

```sql
SELECT *
FROM netflix
WHERE 
    type = 'TV Show'
    AND SPLIT_PART(duration, ' ', 1)::numeric > 5
```

**Objective:** Identify TV shows with more than 5 seasons.

### 9. Count the Number of Content Items in Each Genre

```sql
SELECT  
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
    COUNT(show_id)
FROM
    netflix
GROUP BY 1
```

**Objective:** Count the number of content items in each genre.

### 10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!

```sql
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
```

**Objective:** Calculate and rank years by the average number of content releases by India.

### 11. List All Movies that are Documentaries

```sql
SELECT *
FROM netflix
WHERE
    listed_in ILIKE '%documentaries%' AND type = 'Movie'
```

**Objective:** Retrieve all movies classified as documentaries.

### 12. Find All Content Without a Director

```sql
SELECT *
FROM netflix
WHERE 
    director IS NULL
```

**Objective:** List content that does not have a director.

### 13. Find How Many Movies Actor 'Luna Wedler' Appeared in the Last 10 Years

```sql
SELECT *
FROM netflix
WHERE "cast" ILIKE '%Luna Wedler%' AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```
  
## Findings and Conclusion

- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
- **Common Ratings:** Insights into the most common ratings provide an understanding of the content's target audience.
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.
- **Content Categorization:** Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.



## Author - Hansal Amrutiya

This project is part of my portfolio, showcasing the SQL skills essential for data analyst and business analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

- **Personal Website**: [Hansal](https://hansal.web.app/)

Thank you for your support, and I look forward to connecting with you!
