**Ruby version: 3.1.0 (specified in Gemfile)**

**Rails version: 7.0.1**

## Installation
- Install MySQL 🚨**IMPORTANT: >= v8.0.0**🚨 and ensure the MySQL server is running
- Run `bin/setup` to install dependencies and prepare database

## Launch the app
- `bundle exec rails s`
- navigate to `localhost:3000` in your browser
- Try it out! Setup will have seeded the DB with the records required for the app to behave according to the tech test requirements. At this time, adding/deleting DB records must be done from rails console (see Possible future improvements section)

## Example usage
![Screen Recording 2022-01-30 at 21 27 11](https://user-images.githubusercontent.com/36191075/151718838-f8020de4-8311-4cc8-a6d7-9562fd246ce2.gif)

## Run the tests
- RSpec suite is run with `bundle exec rspec`

## Run the linters
- Rubocop is run with `bundle exec rubocop`
- Yalphabetize is run with `bundle exec yalphabetize`

## Run tests and linters together
- `bundle exec rake`
- VCR is outputing an error message which I haven't been able to fix. Specs still appear to run correctly.

## Possible future improvements/known issues
Due to limited time constraints, I have prioritised development and robust testing of the guest-user-facing part of the app. Future work could include:
- Add validations/sanitisation on format of `AllowPostcode#postcode` and `Lsoa#name` to ensure that all record have consistent formatting. Currently, care must be taken to ensure records are created with correct formatting.
- Containerise the app (Docker) for ease of setup across environments. This will particularly streamline setting up the correct version of MySQL .
- Build an admin UI or implement rake tasks for adding/destroying LSOA records from the DB
- Address weird VCR error message when running specs
- Rename Lsoa model/table. Strictly, these records are not LSOAs. Rather, they are names of areas. Some suitable name might be `AllowedLocation`.

## Development decisions
- The app works as follows (happy path):
  1. User submits postcode via form
  2. User is redirected to path ending `/:postcode`
  3. `ServicedCheck` checks if postcode is serviced. It checks if the postcode is listed as allowed in the DB. If not, it calls `LsoaCheck`.
  4. `LsoaCheck` checks if postcode is in serviceable area
  5. `LsoaCheck` depends upon `FetchPostcodeData` which serves as the client object handling communication with the Postcode.io API
  6. Page renders with message to user
- I considered implementing some form of validation of the postcode values submitted via the form. However, the Postcodes.io API performs validations and informs when the postcodes are invalid. Therefore, validation inside the app seemed unnecessary; no point validating the postcode twice (once by us, once by API)!
- Initially I developed with a hard-coded constant which defined the names of the LSOAs which are serviced (`ALLOW_LIST = ['Lambeth', Southwark]`)
- As a step in the right direction, I moved the allowlist to a db table. This is a more scalable solution, should the list grow. It also allows for greater flexibility regards list maintenance; in the future, the list could be added to/deleted from via rake tasks or an admin UI.
- I have developed following [KISS](https://en.wikipedia.org/wiki/KISS_principle) and [YAGNI](https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it) principles as much as possible, starting with a minimal rails framework and only adding dependencies as and when I need them.
- There is a [postcode.io gem](https://github.com/jamesruston/postcodes_io) which I considered using but it included a lot of behaviour didn't need. Additionally, it provides no information when submitting invalid/unrecognised postcodes (returns `nil`). I thought it better to write my own simple client object and reduce my dependencies on external libraries.
- The instructions for the exercise were explicit that no front-end styling was necessary so I have not spent time on any.
- I did not find the need to introduce any Javascript during the exercise so I have not spent any time on any.
- The Postcode.io documentation does not provide an exhaustive list of possible statuses that might be returned and any accompanying data. For this reason I have only been able to handle errors that I have been able to create myself through trial-and-error. I might want to contact the maintainers of the API for this information or perhaps even read through the API's source code which is freely available on Github.
- Use I18n translations for future internationalisation possibility

## Dependencies
- MySQL instead of default SQLite because MySQL is more scalable and SQLite only commits data to memory (does not persist)
- Capybara allows for feature testing in a headless browser by mimicking a user clicking/typing through a user journey
- RSpec and Simplecov for testing and test coverage
- VCR and Webmock for stubbing requests to the Postcodes.io API. VCR was my choice because it mocks the API's response exactly
- Yalphabetize (my own gem!) for ensuring alphabetisation of YAML files.

## Disagreements with Rubocop
- `Lint/MissingSuper` I want to be able to inherit from parent classes while overriding the `initialize` method. In my case, `ApplicationService` doesn't even define `initialize`, so calling `super` in its descendants would be a unnecessary.
- `Metrics/BlockLength` I think it is pretty common for RSpec blocks to get long.
- `RSpec/ExpectInHook` I like to stub dependencies in before hooks and I like to use `expect` to do the stubbing. The reason for this is that, in the future, should the stub no long be hit by the test, the test will fail, prompting the developer to remove the unused stub.
- `RSpec/NamedSubject` I don't find that this affords much of an increase in readability.
- `RSpec/NestedGroups` I increased the maximum nesting level by 1.
- `RSpec/MessageSpies` this is a pattern I am less familiar with.
- `RSpec/StubbedMock` see `RSpec/ExpectInHook`.
- `Style/Documentation` ruby code is largely self-documenting. Class documentation is mainly for generating documentation onp platforms like Ruby Docs.
