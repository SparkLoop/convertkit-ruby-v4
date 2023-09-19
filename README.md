# Convertkit V4 Ruby Client

A Ruby toolkit for [ConvertkitV4](https://convertkit.com/) API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'convertkit_v4-ruby', require: 'convertkit_v4'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install convertkit_v4-ruby

## Authentication

For private integrations, use your personal ``API_KEY`` and ``API_SECRET`` found in [your account settings.](https://app.ConvertkitV4.com/account/edit)

```ruby
require "dotenv"
Dotenv.load(".env.local")

ConvertkitV4.configure do |config|
  config.api_secret = ENV["API_SECRET"]
  config.api_key = ENV["API_KEY"]
end

client = ConvertkitV4::Client.new
```

## Usage

Calls for ConvertkitV4 API v3 are relative to the url [developers.convertkit.com](developers.convertkit.com).

API actions are available as methods on the client object. Currently, the ConvertkitV4 client has the following methods:


| Action                       | Method                                                          |
|:-----------------------------|:----------------------------------------------------------------|
| Get account information      | `#account`                                                      |
| List subscribers             | `#subscribers(options = {})`                                    |
| Fetch a subscriber           | `#subscriber(subscriber_id)`                                    |
| List sequences/courses       | `#sequences`                                                    |
| Add subscriber to sequence   | `#add_subscriber_to_sequence(sequence_id, email, options = {})` |
| List tags                    | `#tags`                                                         |
| Add subscriber to tag        | `#add_subscriber_to_tag(tag_id, email, options = {})`           |
| Remove tag from a subscriber | `#remove_tag_from_subscriber(subscriber_id, tag_id)`            |
| List forms                   | `#forms`                                                        |
| Add subscriber to form       | `#add_subscriber_to_form(form_id, email, options = {})`         |
| Unsubscribe                  | `#unsubscribe(email)`                                           |

**Note:** We do not have complete API coverage yet. If we are missing an API method that you need to use in your application, please file an issue and/or open a pull request. 

[See the official API documentation](http://kb.convertkit.com/article/api-documentation-v3/) for a complete API reference.

## Use Cases

Here are some common use cases for the ConvertkitV4 v4 API client.

First configure the ``convertkit_v4-ruby`` gem with your ``API_KEY`` and ``API_SECRET``, and initialize a new client. After that, you can fetch data from your account.

### List subscribers

List all subscribers added to your account on or after a specific date.

```ruby
response = client.subscribers(from: "2016-03-01")
# => <Faraday::Response ...>

response.status
# => 200
```

### Fetching subscriber data

Subscribers can be looked up by their ``subscriber_id``.

```ruby
response = client.subscriber("17682009")
# => <Faraday::Response ...>

response.status
# => 200
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, copy `.env.local.sample` to `.env.local` and substitute your own real values from your account. Finally, run `rake spec` to run the tests.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SparkLoop/convertkit-ruby-v4. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

1. Fork it ( https://github.com/SparkLoop/convertkit-ruby-v4/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
