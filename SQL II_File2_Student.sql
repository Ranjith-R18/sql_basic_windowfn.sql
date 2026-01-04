CREATE SCHEMA IF NOT EXISTS SQL2TakeHome2;
USE SQL2TakeHome2;
SELECT 
    *
FROM
    Video_Games_Sales;

SELECT 
    name, platform, SUM(NA_Sales)
FROM
    Video_Games_Sales
GROUP BY platform , name;

SELECT 
    *
FROM
    (SELECT 
        name,
            platform,
            genre Genre_Sales,
            SUM(na_sales) Platform_Sales,
            global_sales total_sales
    FROM
        Video_Games_Sales
    GROUP BY name , platform , genre_SALES , total_sales) temp
ORDER BY Platform_sales DESC;


# 3. Use nonaggregate window functions to produce the row number for each row 
# within its partition (Platform) ordered by release year.(4586 Rows) 
SELECT row_number()OVER(partition by platform) 's.no' FROM Video_Games_Sales;

# 4. Use aggregate window functions to produce the average global sales of each row
# within its partition (Year of release). Also arrange the result in the descending order
# by year of release.(4586 Rows) 
SELECT AVG(global_sales)OVER(partition by year_of_release ORDER BY year_of_release DESC) FROM Video_Games_Sales ;
  
# 5. Display the name of the top 5 Games with highest Critic Score For Each Publisher.(821 Rows)  
SELECT publisher, name, critic_score
FROM (
    SELECT 
        publisher,
        name,
        critic_score,
        dense_RANK() OVER (PARTITION BY publisher ORDER BY critic_score DESC) AS rnk
    FROM Video_Games_Sales
    WHERE critic_score IS NOT NULL
) ranked
WHERE rnk <= 5
ORDER BY publisher, critic_score DESC;

-- ----------------------------------------------------------------------------------
SELECT 
    *
FROM
    website_stats;
SELECT 
    *
FROM
    web;
-- ----------------------------------------------------------------------------------
# 6. Write a query that displays the opening date two rows forward i.e. 
#the 1st row should display the 3rd website launch date using LEAD function.(3 Rows) 
SELECT launch_date,lead(launch_date,2)OVER() FROM web;

# 7. Write a query that displays the statistics for website_id = 1 i.e. for each row, 
#show the day, the income and the income on the first day.(3 Rows) 
-- Example: Display website name, launch date, and the launch date 2 rows ahead
 -- Show only first 3 rows as per requirement
SELECT day,income,ld FROM (SELECT website_id,day,income,LEAD(income,2)OVER() ld FROM website_stats) temp WHERE website_id = 1 LIMIT 3;


-----------------------------------------------------------------
# Dataset Used: play_store.csv 
SELECT * FROM play_store;
-----------------------------------------------------------------
# 8. For each game, show its name, genre and date of release. 
#In the next three columns, show RANK(), DENSE_RANK() and ROW_NUMBER() 
#sorted by the date of release in ascending order.(12 Rows) 

SELECT name,genre,released,RANK()OVER(),DENSE_RANK()OVER(),row_number()OVER() FROM play_store ORDER BY released DESC;


