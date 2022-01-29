Ruby version: 3.1.0 (specified in Gemfile)
Rails version: 7.0.1

Development decisions:
- Use MySQL database for scalability over default SQLite

Installation:
- Install MySQL and ensure the MySQL server is running
- Run `bin/setup` to install dependencies and prepare database

Launch the app:
- `bundle exec rails s`

Run the tests:
- RSpec suite is run with `bundle exec rspec`

Run the linter:
- Rubocop is run with `bundle exec rubocop`

Run tests and linter together:
- `bundle exec rake`

A few improvements I would like to make:
- Containerise the app (Docker) for ease of setup across environments
