-- We can either use the terminal to exeecute the code or use an application (e.g. Postico) to make it easier and check the database
-- The general formate to insert in to the Terminal to run our code is -- psql -dfootball -f football_queries.sql --

-- Below is the task instructions copied; with the added soloutions

-- Football Matches - Tasks

-- Each of the questions/tasks below can be answered using a `SELECT` query. When you find a solution copy it into the code block under the question before pushing your solution to GitHub.

-- 1) Find all the matches from 2017.

SELECT * FROM matches WHERE season = '2017';

-- 2) Find all the matches featuring Barcelona.

SELECT * FROM matches WHERE hometeam = 'Barcelona' OR awayteam = 'Barcelona';

-- 3) What are the names of the Scottish divisions included?

SELECT * FROM divisions WHERE country = 'Scotland';

-- 4) Find the division code for the Bundesliga. Use that code to find out how many matches Freiburg have played in the Bundesliga since the data started being collected.

SELECT COUNT(*) FROM matches WHERE (SELECT code FROM public.divisions WHERE country = '%Bundesliga%';) AND (hometeam = 'Freiburg' OR awayteam = 'Freiburg');

    -- Here, the function first counts all matches within the Bundesliga division i.e. D1 & D2 ... thereafter, filters this list for where either the Home or Away team are 'Freiburg    

-- 5) Find the unique names of the teams which include the word "City" in their name (as entered in the database)

SELECT hometeam FROM matches WHERE hometeam ILIKE '%city%' UNION SELECT awayteam FROM public.matches WHERE awayteam ILIKE '%city%';

    -- I used the UNION operator to combine the result-set of two SELECT statements to solve this task 

-- 6) How many different teams have played in matches recorded in a French division?

SELECT COUNT(*) FROM matches WHERE (SELECT DISTINCT awayteam WHERE code = (SELECT code FROM public.divisions WHERE country = 'France') UNION (SELECT DISTINCT hometeam WHERE code = (SELECT code FROM public.divisions WHERE country = 'France') 

    -- @Richard/Anna - I'm not sure if my soloution to task 6 is correct (could you please have a look?)... I'm having technical issues (says relation already exists) with running it and so can't see for myself
    
-- 7) Have Huddersfield played Swansea in the period covered?

SELECT COUNT(*) FROM matches WHERE hometeam = 'Huddersfield' AND awayteam = 'Swansea' OR hometeam = 'Swansea' AND awayteam = 'Huddersfield';
    
    -- If the result is greater than 0, we will know if Huddersfield and Swansea have played in the period covered

-- 8) How many draws were there in the Eredivisie between 2010 and 2015?

SELECT COUNT(*) FROM matches WHERE ftr = 'D' AND division_code = 'N1' AND season >= 2010 AND season <= 2015;

-- 9) Select the matches played in the Premier League in order of total goals scored from highest to lowest. Where there is a tie the match with more home goals should come first.

SELECT * FROM matches WHERE division_code = 'E0' ORDER BY (fthg + ftag) DESC;
-- Not sure about how to filter by the higher home goals when fthg = ftag .... is it 'fthg DESC'?


-- 10) In which division and which season were the most goals scored?

SELECT division_code, season, SUM(fthg + ftag) AS sum_scores FROM matches GROUP BY division_code, season ORDER BY sum_scores DESC FETCH FIRST 1 ROW ONLY;
-- I'm not sure about question 10 but have attempted the question. I'm having issues running the program in terminal and therefore can't check if it's correct

### Useful Resources

- [Filtering results](https://www.w3schools.com/sql/sql_where.asp)
- [Ordering results](https://www.w3schools.com/sql/sql_orderby.asp)
- [Grouping results](https://www.w3schools.com/sql/sql_groupby.asp)