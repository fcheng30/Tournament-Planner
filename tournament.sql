-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


CREATE TABLE players ( name TEXT,
                     createtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                     id SERIAL );

CREATE TABLE games ( name TEXT,
					 createtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
					 id SERIAL );
					 
CREATE TABLE matches ( player1id SERIAL,
					 player2id SERIAL,
					 gameid SERIAL,
					 winner SERIAL,
					 createtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
					 id SERIAL );
					 
				
CREATE VIEW playermatches AS
SELECT players.id, players.name, player1id, player2id, gameid, winner
FROM players, matches
WHERE players.id = matches.player1id OR players.id = matches.player2id

CREATE VIEW wins AS
SELECT id, count(*) as wins
FROM playermatches
WHERE id = winner
GROUP BY id

CREATE VIEW totalmatches AS
SELECT id, count(*) as matches
FROM playermatches
GROUP BY id

CREATE VIEW standing AS
SELECT players.id, players.name, wins, matches
FROM wins, totalmatches, players
WHERE wins.id = totalmatches.id
