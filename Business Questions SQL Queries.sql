-- Business Questions SQL Queries

-- 1. Which teams had the highest average scoring margin during regular season games compared to playoff games? Breakdown by season.
SELECT 
    g.season,
    t.team_name,
    g.playoffs AS game_type,
    ROUND(AVG(s.score_home - s.score_away), 2) AS avg_scoring_margin
FROM Games g
JOIN Scores s ON g.game_id = s.game_id
JOIN Teams t ON t.team_sym IN (s.team_sym_home, s.team_sym_away)
GROUP BY g.season, g.playoffs, t.team_name
ORDER BY g.season, g.playoffs, avg_scoring_margin DESC;



-- 2. What percentage of games in a season resulted in the favorite failing to cover the spread? Breakdown by season.
SELECT  g.season,
    COUNT(CASE 
            WHEN (br.id_spread = 0 AND bl.whos_favored = 'home' AND s.score_home < s.score_away) OR
                 (br.id_spread = 0 AND bl.whos_favored = 'away' AND s.score_away < s.score_home)
         THEN 1 
         END) AS failed_to_cover,
    COUNT(*) AS total_games,
    ROUND((COUNT(CASE 
            WHEN (br.id_spread = 0 AND bl.whos_favored = 'home' AND s.score_home < s.score_away) OR
                 (br.id_spread = 0 AND bl.whos_favored = 'away' AND s.score_away < s.score_home)
         THEN 1 
         END) / COUNT(*)) * 100, 2) AS percentage_favorite_failed
FROM BettingResults br
JOIN BettingLines bl ON br.game_id = bl.game_id
JOIN Games g ON bl.game_id = g.game_id
JOIN Scores s ON s.game_id = g.game_id
WHERE g.regular = 'TRUE'
GROUP BY g.season
ORDER BY g.season;



-- 3. By team, identify percentage of games where the underdog covered the second half spread but not the full-game spread. Breakdown by season.
SELECT 
    g.season,
    t.team_name,
    COUNT(CASE WHEN sr.H2_spread = 1 AND br.id_spread = 0 THEN 1 END) AS underdog_covered_H2_not_full,
    COUNT(*) AS total_games,
    ROUND((COUNT(CASE WHEN sr.H2_spread = 1 AND br.id_spread = 0 THEN 1 END) / COUNT(*)) * 100, 2) AS percentage
FROM Games g
JOIN Scores s ON g.game_id = s.game_id
JOIN Teams t ON t.team_sym = s.team_sym_away
JOIN SecondHalfLines sr ON sr.game_id = g.game_id
JOIN BettingResults br ON br.game_id = g.game_id
GROUP BY g.season, t.team_name
ORDER BY g.season, percentage DESC;



-- 4. What is the average point differential games played during the playoffs versus regular-season games? Breakdown by season.
SELECT 
    g.season,
    g.playoffs AS game_type,
    ROUND(AVG(ABS(s.score_home - s.score_away)), 2) AS avg_point_differential
FROM Games g
JOIN Scores s ON g.game_id = s.game_id
GROUP BY g.season, g.playoffs
ORDER BY g.season, g.playoffs;



-- 5. Determine the top teams with the best performance based on win rates in close games decided by 5 points or fewer in regular season and playoffs. Breakdown by season
SELECT 
    t.team_name AS team,
    g.season,
    ROUND(SUM(
        CASE 
            WHEN (s.team_sym_home = t.team_sym AND ABS(s.score_home - s.score_away) <= 5 AND s.score_home > s.score_away) OR
                 (s.team_sym_away = t.team_sym AND ABS(s.score_away - s.score_home) <= 5 AND s.score_away > s.score_home)
            THEN 1
            ELSE 0
        END
    ) / NULLIF(COUNT(
        CASE 
            WHEN (s.team_sym_home = t.team_sym AND ABS(s.score_home - s.score_away) <= 5) OR
                 (s.team_sym_away = t.team_sym AND ABS(s.score_away - s.score_home) <= 5)
            THEN 1
        END
    ), 0) * 100, 2) AS close_game_win_rate
FROM Teams t
JOIN Scores s ON t.team_sym IN (s.team_sym_home, s.team_sym_away)
JOIN Games g ON s.game_id = g.game_id
WHERE g.regular = 'TRUE'  -- Restricting to regular season games
GROUP BY t.team_name, g.season
ORDER BY close_game_win_rate DESC;



-- 6. Calculate the percentage of games where the total score matched exactly with the line. Include a breakdown by season.
SELECT 
    g.season,
    (COUNT(CASE 
               WHEN (s.score_home + s.score_away) = b.total 
            THEN 1 END) / COUNT(*) * 100) AS percentage_matched_total
FROM BettingLines b
JOIN Games g ON b.game_id = g.game_id
JOIN Scores s ON s.game_id = g.game_id
GROUP BY g.season;



-- 7. Which team had the most games where they covered the spread as an underdog per season? Include breakdown by season.
SELECT
	g.season,
    t.team_name,
    COUNT(*) AS games_covered_as_underdog
FROM BettingResults br
JOIN bettinglines bl on br.game_id = bl.game_id
JOIN Games g ON bl.game_id = g.game_id
JOIN Scores s ON s.game_id = g.game_id
JOIN Teams t ON t.team_sym = s.team_sym_away
WHERE br.id_spread = 0 AND bl.whos_favored = 'away' AND g.regular = 'TRUE'
GROUP BY g.season, t.team_name
ORDER BY g.season, games_covered_as_underdog DESC;



-- 8. By season and team, identify how often second half betting results differed from full game betting results.
SELECT 
    g.season,
    t.team_name,
    COUNT(CASE 
               WHEN (br.id_spread = sh.H2_spread) 
            THEN 1 END) / NULLIF(COUNT(*), 0) * 100 AS second_half_vs_full_game_difference
FROM BettingResults br
JOIN SecondHalfLines sh ON br.game_id = sh.game_id
JOIN Games g ON br.game_id = g.game_id
JOIN Scores s ON s.game_id = g.game_id
JOIN Teams t ON t.team_sym = s.team_sym_away
WHERE g.regular = 'TRUE'
GROUP BY g.season, t.team_name;



-- 9. Is there a statistically significant difference in average home scores versus away scores during the playoffs, and where? 
SELECT 
    g.season,
    g.regular AS game_type,
    t.team_name,
    AVG(s.score_home) AS avg_home_score,
    AVG(s.score_away) AS avg_away_score
FROM Scores s
JOIN Games g ON s.game_id = g.game_id
JOIN Teams t ON t.team_sym = s.team_sym_home
WHERE g.regular = 'FALSE'
GROUP BY g.season, g.regular, t.team_name
HAVING AVG(s.score_home) != AVG(s.score_away)
ORDER BY g.season, game_type, team_name;