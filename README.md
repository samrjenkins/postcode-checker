**Ruby version: 3.1.0 (specified in Gemfile)**

**Rails version: 7.0.1**

## Installation
- Install MySQL and ensure the MySQL server is running
- Run `bin/setup` to install dependencies and prepare database

## Launch the app
- `bundle exec rails s`
- navigate to `localhost:3000` in your browser

## Run the tests
- RSpec suite is run with `bundle exec rspec`

## Run the linters
- Rubocop is run with `bundle exec rubocop`
- Yalphabetize is run with `bundle exec yalphabetize`

## Run tests and linters together
- `bundle exec rake`

## Development decisions
- An interesting task that doesn't demand use of a DB
- Instead, my app works as follows (happy path):
  1. User submits postcode via form
  2. User is redirected to path ending `/:postcode`
  3. `LsoaCheck` checks if postcode is in serviceable area
  4. `LsoaCheck` depends upon `FetchPostcodeData` which serves as the client object handling communication with the Postcode.io API
  5. Page renders with message to user
- Nowhere in this flow is a DB necessary
  - Initially I developed with a hard-coded constant which defined the names of the LSOAs which are serviced (`ALLOW_LIST = ['Lambeth', Southwark]`)
  - As a step in the right direction, I moved the allowlist to a db table. This is a more scalable solution, should the list grow. It also allows for greater flexibility regards list maintenance; in the future, the list could be added to/deleted from via rake tasks or an admin UI.
- I have developed following [KISS](https://en.wikipedia.org/wiki/KISS_principle) and [YAGNI](https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it) principles as much as possible, starting with a minimal rails framework and only adding dependencies as and when I need them. In particular, there was a [postcode.io gem](https://github.com/jamesruston/postcodes_io) which I considered using but it included a lot of behaviour didn't need. I thought it better to write my own simple client object and reduce my dependencies on external libraries.
- The instructions for the exercise were explicit that no front-end styling was necessary so I have not spent time on any.
- I did not find the need to introduce any Javascript during the exercise so I have not spent any time on any.
- The Postcode.io documentation does not provide an exhaustive list of possible statuses that might be returned and any accompanying data. For this reason I have only been able to handle errors that I have been able to create myself through trial-and-error. I might want to contact the maintainers of the API for this information or perhaps even read through the API's source code which is freely available on Github.
- Dependencies I have chosen to use:
  - MySQL instead of default SQLite because MySQL is more scalable and SQLite only commits data to memory (does not persist)
  - Capybara allows for feature testing in a headless browser by mimicking a user clicking/typing through a user journey
  - RSpec and Simplecov for testing and test coverage
  - VCR and Webmock for stubbing requests to the Postcodes.io API. VCR was my choice because it mocks the API's response exactly
  - Yalphabetize (my own gem!) for ensuring alphabetisation of YAML files.

## Possible future improvements
- Containerise the app (Docker) for ease of setup across environments
- Build a UI or implement rake tasks for adding/destroying LSOA records from the DB
