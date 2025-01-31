CREATE DATABASE nba;

USE nba;

CREATE TABLE Games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    season YEAR NOT NULL,
    date DATE NOT NULL,
    regular VARCHAR(50) NOT NULL,
    playoffs VARCHAR(50) NOT NULL
);
    
CREATE TABLE Teams (
	team_ID INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(50) NOT NULL,
    team_sym CHAR(4) NOT NULL UNIQUE
);
    
CREATE TABLE Scores (
	score_ID INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL, 
    team_sym_away CHAR(4) NOT NULL,
	team_sym_home CHAR(4) NOT NULL,
    score_away INT NOT NULL,
	score_home INT NOT NULL,
    Q1_away INT NOT NULL,
    Q2_away INT NOT NULL,
    Q3_away INT NOT NULL,
    Q4_away INT NOT NULL,
    OT_away INT NOT NULL,
    Q1_home INT NOT NULL,
    Q2_home INT NOT NULL,
    Q3_home INT NOT NULL,
    Q4_home INT NOT NULL,
    OT_home INT NOT NULL,
    CONSTRAINT fk_game_id FOREIGN KEY (game_id) REFERENCES Games (game_id) -- links to Games table
);

-- CREATE TABLE QuarterScores (
	-- game_id INT NOT NULL,              
    -- q_number TINYINT NOT NULL,         
    -- away_q_score INT NOT NULL,         
    -- home_q_score INT NOT NULL,         
    -- PRIMARY KEY (game_id, q_number),   -- composite primary key to uniquely identify each game's quarter
    -- CONSTRAINT fk_qaurter_scores_games FOREIGN KEY (game_id) REFERENCES Games(game_id) -- links to Games table
-- );

CREATE TABLE BettingLines (
	betting_line_id INT AUTO_INCREMENT PRIMARY KEY, 
    game_id INT NOT NULL,                           
    whos_favored ENUM('home', 'away') NOT NULL,     
    spread DECIMAL(5, 2) NOT NULL,                  
    total DECIMAL(5, 2) NOT NULL,                   
    moneyline_away INT NOT NULL,                    
    moneyline_home INT NOT NULL,                    
    CONSTRAINT fk_betting_lines_games FOREIGN KEY (game_id) REFERENCES Games(game_id)  -- constraint to ensure the game_id value must exist in the Games table      
);

CREATE TABLE BettingResults (
	betting_results_id INT AUTO_INCREMENT PRIMARY KEY,       
    game_id INT NOT NULL,                            
    id_spread TINYINT NOT NULL,                      -- 1 = favorite covered, 0 = underdog covered, 2 = push
    id_total TINYINT NOT NULL,                       -- 1 = total went over, 0 = under, 2 = push
	CONSTRAINT fk_betting_results_games FOREIGN KEY (game_id) REFERENCES Games(game_id)   -- constraint to ensure the game_id value must exist in the Games table
);       

CREATE TABLE SecondHalfLines (
    game_id INT NOT NULL,    
   	H2_line_id INT AUTO_INCREMENT PRIMARY KEY,    
    H2_spread DECIMAL(5,2) NOT NULL,               
    H2_total DECIMAL(5,2) NOT NULL,               
    CONSTRAINT fk_second_half_lines_games FOREIGN KEY (game_id) REFERENCES Games(game_id)   -- constraint to establish relationship with Games table
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/nba_game.csv'
INTO TABLE Games
FIELDS TERMINATED BY ','   -- delimiter between values in CSV
LINES TERMINATED BY '\n'   -- line ending
IGNORE 1 ROWS              -- skip header row in the CSV
(season, date, regular, playoffs);  -- columns in database to be filled from CSV

INSERT INTO Teams VALUES
(1, 'Atlanta Hawks', 'atl'),
(2, 'Boston Celtics', 'bos'),
(3, 'Brooklyn Nets', 'bkn'),
(4, 'Charlotte Hornets', 'cha'),
(5, 'Chicago Bulls', 'chi'),
(6, 'Cleveland Cavaliers', 'cle'),
(7, 'Dallas Mavericks', 'dal'),
(8, 'Denver Nuggets', 'den'),
(9, 'Detroit Pistons', 'det'),
(10, 'Golden State Warriors', 'gs'),
(11, 'Houston Rockets', 'hou'),
(12, 'Indiana Pacers', 'ind'),
(13, 'Los Angeles Clippers', 'lac'),
(14, 'Los Angeles Lakers', 'lal'),
(15, 'Memphis Grizzlies', 'mem'),
(16, 'Miami Heat', 'mia'),
(17, 'Milwaukee Bucks', 'mil'),
(18, 'Minnesota Timberwolves', 'min'),
(19, 'New Orleans Pelicans', 'no'),
(20, 'New York Knicks', 'ny'),
(21, 'Oklahoma City Thunder', 'okc'),
(22, 'Orlando Magic', 'orl'),
(23, 'Philadelphia 76ers', 'phi'),
(24, 'Phoenix Suns', 'phx'),
(25, 'Portland Trail Blazers', 'por'),
(26, 'Sacramento Kings', 'sac'),
(27, 'San Antonio Spurs', 'sa'),
(28, 'Toronto Raptors', 'tor'),
(29, 'Utah Jazz', 'utah'),
(30, 'Washington Wizards', 'wsh');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/nba_score.csv'
INTO TABLE Scores
FIELDS TERMINATED BY ','  
LINES TERMINATED BY '\n'   
IGNORE 1 ROWS              
(game_id, team_sym_away, team_sym_home, score_away, score_home, q1_away, q2_away, q3_away, q4_away, ot_away, q1_home, q2_home, q3_home, q4_home, ot_home);  

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/nba_blines.csv'
INTO TABLE BettingLines
FIELDS TERMINATED BY ','   
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS              
(game_id, whos_favored, spread, total, moneyline_away, moneyline_home);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/nba_bresults.csv'
INTO TABLE BettingResults
FIELDS TERMINATED BY ','   
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS              
(game_id, id_spread, id_total);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/nba_h2lines.csv'
INTO TABLE SecondHalfLines
FIELDS TERMINATED BY ','   
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS              
(game_id, h2_spread, h2_total);