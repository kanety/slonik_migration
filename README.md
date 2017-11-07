# SlonikMigration

A rails migration gem for slony using slonk_execute_script command.

## Dependencies

* ruby 2.3+
* rails 5.0+
* slony 2.2+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slonik_migration'
```

Then execute:

    $ bundle

Generate config file:

    $ bundle exec rails g slonik_migration:config

## Configuration

Edit `config/slonik.yml`.

```ruby
default: &default
  # slonik command for local server. $SQL is replaced with raw SQL.
  command: slonik_execute_script -c $SQL 1 | sed "s/set id = 1,//" | slonik

  # slonik command for remote server.
  # command: ssh -p 22 user@192.168.0.1 'slonik_execute_script -c $SQL 1 | sed "s/set id = 1,//" | slonik'

  # table/sequence owner.
  owner: owner

development:
  <<: *default

test:
  <<: *default

production:
  <<: *default
```

## Usage

Migrate:

```ruby
bundle exec rake slonik:db:migrate RAILS_ENV=production
```

Specify config file:

```ruby
bundle exec rake slonik:db:migrate RAILS_ENV=production CONFIG=/path/to/slonik.yml
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/slonik_migration.

## Reference

This gem is inspired by the discussions [here](http://justatheory.com/computers/databases/postgresql/rails_and_slony.html)
