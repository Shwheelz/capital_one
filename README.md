# CapitalOne

The capital_one gem interfaces Ruby developers with the Capital One API.  Simply require 'capital_one' and gain access to the API methods.  Documentation for Capital One's API can be found at http://api.reimaginebanking.com/documentation.  See lib/capital_one.rb for method definitions in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capital_one'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capital_one

## Usage
To setup, add the following lines of code to the top of your file
```ruby
require 'capital_one'
Config.apiKey = "your_api_key"
```
It is essential to set your API key before any calls to the API.  If you do not have an API key, you can request one from the [Capital One API website](http://api.reimaginebanking.com/) by signing in with GitHub.

## irb Example
![alt tag](http://i.imgur.com/DwXjl2h.png)

After requiring the Capital One gem, use CapitalOne.getCustomers to return a JSON object of the customers in Capital One's API.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/capital_one/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
