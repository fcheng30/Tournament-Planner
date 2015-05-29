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
   `$ cd /tournament`
5. Delete the database if already exists. 
   `$ dropdb tournament`
6. Connect psql.
   `$ psql`
6. Create tournament database and schema (tables and views) by importing the tournament.sql. 
   `$ \i tournament`
7. Exit tournament database, and run the units test code.
   `$ python tournament_test.py`
