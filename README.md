# SlonikMigration

A rails migration gem for slony using `slonik_execute_script` command.

## Dependencies

* ruby 2.4+
* activerecord 5.0+
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

```yaml
default: &default
  # enable migration with slonik
  enabled: true

  # slonik command. $SQL is replaced with raw SQL.
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

This gem enhances following rails commands:

* db:migrate
* db:migrate:up
* db:migrate:down

You can use migration command as usual:

    $ bundle exec rake db:migrate RAILS_ENV=production

If you want to specify config file:

    $ bundle exec rake db:migrate RAILS_ENV=production CONFIG=/path/to/slonik.yml

## Execution example

Migration command executes `slonik_execute_command` as the following example:

    slonik_execute_script -c CREATE\ TABLE\ \"test_tables\"\ \(\"id\"\ bigserial\ primary\ key,\ \"title\"\ text\) 1 | sed "s/set id = 1,//" | slonik    

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/slonik_migration.

## Reference

This gem is inspired by [the discussions](http://justatheory.com/computers/databases/postgresql/rails_and_slony.html).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
