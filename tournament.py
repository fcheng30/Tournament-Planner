#!/usr/bin/env python
#
# tournament.py -- implementation of a Swiss-system tournament
#

import psycopg2


def connect(database_name="tournament"):
    """Connect to the PostgreSQL database.  Returns a database connection."""
    try:
        db = psycopg2.connect("dbname={}".format(database_name))
        cursor = db.cursor()
        return db, cursor
    except:
        print("<error message>")


def deleteMatches():
    """Remove all the match records from the database."""
    DB, cur = connect()
    cur.execute("TRUNCATE matches CASCADE")
    DB.commit()
    DB.close()


def deletePlayers():
    """Remove all the player records from the database."""
    DB, cur = connect()
    cur.execute("TRUNCATE players CASCADE")
    DB.commit()
    DB.close()


def countPlayers():
    """Returns the number of players currently registered."""
    DB, cur = connect()
    query = "SELECT count(*) FROM players;"
    cur.execute(query)
    totalplayers = cur.fetchone()
    totalnum = int(totalplayers[0])
    DB.commit()
    DB.close()
    return totalnum


def registerPlayer(name):
    """Adds a player to the tournament database.

    The database assigns a unique serial id number for the player.  (This
    should be handled by your SQL database schema, not in your Python code.)

    Args:
      name: the player's full name (need not be unique).
    """
    DB, cur = connect()
    query = "INSERT INTO players (name) VALUES (%s);"
    parameter = (name,)
    cur.execute(query, parameter)
    DB.commit()
    DB.close()


def playerStandings():
    """Returns a list of the players and their win records, sorted by wins.

    The first entry in the list should be the player in first place, or
    a player tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played
    """
    DB, cur = connect()
    query = "SELECT * FROM standing;"
    cur.execute(query)
    list = cur.fetchall()
    DB.commit()
    DB.close()
    return list


def reportMatch(winner, loser, gameid):
    """Records the outcome of a single match between two players.

    Args:
      winner:  the id number of the player who won
      loser:  the id number of the player who lost
      gameid: Identfy which game they are in
    """
    DB, cur = connect()
    query = "INSERT INTO matches (player1id,player2id,gameid,winner) \
               VALUES (%s,%s,%s,%s);"
    parameter = (winner, loser, gameid, winner,)
    cur.execute(query, parameter)
    DB.commit()
    DB.close()


def swissPairings():
    """Returns a list of pairs of players for the next round of a match.

    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent
    to him or her in the standings.

    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name
    """
    DB, cur = connect()
    query = "SELECT * FROM standing;"
    cur.execute(query)
    list = cur.fetchall()
    counter = 0
    result = []
    while (counter < len(list)):
        # Pair up players by pairing every two rows together
        row1 = list[counter]
        row2 = list[counter+1]
        tuple = [int(row1[0]), str(row1[1]), int(row2[0]), str(row2[1])]
        result.append(tuple)
        counter += 2
    DB.commit()
    DB.close()
    return result
