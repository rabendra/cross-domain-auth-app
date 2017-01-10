# Equus Hub API

[ ![Codeship Status for Touchtap/equusmatch-backend](https://app.codeship.com/projects/2fef84b0-a466-0134-897a-6a0a51f3bf6e/status?branch=master)](https://app.codeship.com/projects/190529)

Provides the API to manage users, listings, events and more for the mobile app.

Available at [http://api.equushub.com](http://api.equushub.com).

## Installation

### Requirements
* Ruby 2.3
* Postgres 9.5+
* Redis
* ImageMagick
* Mailcatcher

### Setup

```shell
$> cp env.sample .env # make any necessary changes to credentials
$> bundle exec rake db:setup
```

## Deployment
 Deployment is handled automatically via [CodeShip](www.codeship.com) after any changes are pushed to the `master` branch and the test suite passes.

 The app is hosted on Heroku with DNS managed on GoDaddy.
