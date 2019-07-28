# SCHOOL MANAGEMENT


The School System was developed with the purpose of improving the school administrative management where I work, thus facilitating the registration of Employees, student enrollment. An area has also been developed for the teacher to manage his class with activity records and class observations..

Things you may want to cover:

* Ruby version - 2.5.5

* Rails version - 5.2.3

* System dependencies: Activeadmin(Addons, Quill_editor, Index_as_calendar,Jquery_input_mask), Cancancan, Devise, Formadmin, Rails-i18n.

* Configuration: 
First configure your .env file with variables for connecting to the local and production database.
Create a file an .env file at the root of the project. Then run the `rails db: create db: migrate` database create command to create and migrate the system database tables. To start with a standard user run the command `rails db: seed`, and you're done!
Now run the `rails server` or `rails s` server.

* Database creation: rails db:create db:migrate

* Database initialization: rails db:seed
