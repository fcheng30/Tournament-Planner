# Tournament-Planner

##Contents:
- tournament.sql : Store SQL Create Statement.
- tournament.py : Tournament SQL functions.
- tournament_test.py : Unit and integration tests.


##Run:
1. Install Vagrant and VirtualBox
2. Include the tournament code inside the vagrant directory
3. Launch Vagrant VM 
4. Go to tournament folder ($ cd /tournament)
5. Create tournament database ($ psql createdb tournament)
6. Go into tournament database to create the tables and views
   using the SQL statements in tournament.sql. ($ psql tournament)
7. Exit tournament database, and run the units test code. ($ python tournament_test.py)
