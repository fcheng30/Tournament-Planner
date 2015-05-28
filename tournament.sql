-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


-- Players' information name and unique id
CREATE TABLE players ( name TEXT,
                     createtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                     id SERIAL );
					 
-- Tounament information to support mutiple tournament.
CREATE TABLE games ( name TEXT,
					 createtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
					 id SERIAL );
					 
-- All Matches information history and the winner result
CREATE TABLE matches ( player1id SERIAL,
					 player2id SERIAL,
					 gameid SERIAL,
					 winner SERIAL,
					 createtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
					 id SERIAL );
					 
-- Give view of all players' matches with player id and name at first two columns 	
CREATE VIEW playermatches AS
SELECT players.id, players.name, player1id, player2id, gameid, winner
FROM players, matches
WHERE players.id = matches.player1id OR players.id = matches.player2id

-- Group by players' id and winner's id to get wins of each players
CREATE VIEW wins AS
SELECT id, count(*) as wins
FROM playermatches
WHERE id = winner
GROUP BY id

-- Group by players' id to get total matches
CREATE VIEW totalmatches AS
SELECT id, count(*) as matches
FROM playermatches
GROUP BY id

-- Join wins, totalmatches, and players table to get player standing info
CREATE VIEW standing AS
SELECT players.id, players.name, wins, matches
FROM wins, totalmatches, players
WHERE wins.id = totalmatches.id
