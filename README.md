# Tournament-Planner

##Contents:
- tournament.sql : Store SQL Create Statement.
- tournament.py : Tournament SQL functions.
- tournament_test.py : Unit and integration tests.


##Run:
1. Install Vagrant and VirtualBox.
2. Include the tournament code inside the vagrant directory.
3. Launch Vagrant VM .
4. Go to shared tournament folder 
	<p>$ cd /tournament</p>
5. Delete the database if already exists. 
	<p>$ dropdb tournament</p>
6. Connect psql.
	<p>$ psql</p>
6. Create tournament database and schema (tables and views) by importing the tournament.sql. 
	<p>$ \i tournament</p>
7. Exit tournament database, and run the units test code.
	<p>$ python tournament_test.py</p>
