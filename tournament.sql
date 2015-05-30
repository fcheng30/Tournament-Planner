-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- Delete the database if already exists. 
drop database if exists tournament;

-- Create database and connect it using the following command 
CREATE DATABASE tournament;
\c tournament;

-- Players' information name and unique id
CREATE TABLE players ( name TEXT,
                     createtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                     id SERIAL PRIMARY KEY);
					 
-- Tounament information to support mutiple tournament
CREATE TABLE games ( name TEXT,
					 createtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
					 id SERIAL PRIMARY KEY);
					 
-- All Matches information history and the winner result
CREATE TABLE matches ( player1id SERIAL REFERENCES players(id),
					 player2id SERIAL REFERENCES players(id),
					 gameid SERIAL,
					 winner SERIAL REFERENCES players(id),
					 createtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
					 id SERIAL PRIMARY KEY);
					 
-- Give view of all players' matches with player id and name at first two columns 	
CREATE VIEW playermatches AS
SELECT players.id, players.name, player1id, player2id, gameid, winner
FROM players, matches
WHERE players.id = matches.player1id OR players.id = matches.player2id;

-- Group by players' id and winner's id to get wins of each players
CREATE VIEW wins AS
SELECT id, count(*) as wins
FROM playermatches
WHERE id = winner
GROUP BY id;

-- Group by players' id to get total matches
CREATE VIEW totalmatches AS
SELECT id, count(*) as matches
FROM playermatches
GROUP BY id;

-- Join wins, totalmatches, and players table to get player standing info
CREATE VIEW standing AS
SELECT players.id, players.name, COALESCE(wins,0) as wins, COALESCE(matches,0) as matches
FROM players 
LEFT JOIN wins ON players.id = wins.id
LEFT JOIN  totalmatches ON players.id = totalmatches.id
ORDER BY wins;
