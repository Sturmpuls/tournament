-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament

create table players (
	id serial PRIMARY KEY,
	name text
    );

create table matches (
    id serial PRIMARY KEY,
    winner int REFERENCES players(id),
    loser int REFERENCES players(id)
    );

create view standings 
    AS SELECT players.id,
            players.name,
            COUNT(wi.winner) as wins,
            ((SELECT COUNT(lo.loser) as loss) + (SELECT COUNT(wi.winner) as win)) as n_matches
        FROM players
        LEFT JOIN matches wi ON (players.id = wi.winner)
        LEFT JOIN matches lo ON (players.id = lo.loser)
        GROUP BY players.id;
    ;