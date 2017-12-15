# Kisiwebhooks

Gem to define rules for the Kisi webhook API in an easy way. Based on an easy YAML configuration file, the user is able to implement arbitrary rules for filtering the webhook events.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kisiwebhooks'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kisiwebhooks

## Usage

Load the rules like the following:


```ruby
require 'kisiwebhooks/rules'
RULES = Kisiwebhooks::Rules::Loader.from_yaml(File.read('rules.yml')) # an example file is provided
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Example microservice

There is an example Sinatra microservice at [microservice.rb](https://github.com/dcluna/kisiwebhooks/microservice.rb), which you can run with the following command:

```sh
bundle install
ruby microservice.rb
```

If you want to test with example requests, install [`mailcatcher`](https://github.com/sj26/mailcatcher), [httpie](https://github.com/jakubroztocil/httpie) and run the following commands:

```sh
mailcatcher
http POST localhost:4567/kisi < example_requests/unlock-webhook.json
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dcluna/kisiwebhooks.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
