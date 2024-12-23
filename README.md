# Stoack Market
 
Ozone is a Ruby on Rails application.
## How to Create Rails 

- Create Rails project
``` 
rails new stock-market-app-with-ruby-on-rails 
```

- Generate the controlloer or web page or when you want to create db
``` 
rails g controller home index 
```

- Install Bootsrap
    - Go to https://rubygems.org and add to Gemfile
    - https://github.com/twbs/bootstrap-rubygem
## Requirements

- Ruby version: specified in [.ruby-version](.ruby-version)
- Rails version: specified in [Gemfile](Gemfile)

## Setup

1. Clone the repository:
    ```sh
    git clone <repository-url>
    cd ozone
    ```

2. Install dependencies:
    ```sh
    bundle install
    ```

3. Setup the database:
    ```sh
    rails db:setup
    ```

## Running the Application

To start the application, run:
```sh
rails server