# capital_one

The capital_one gem interfaces Ruby developers with Capital One's Hackathon API.  Simply require 'capital_one' and gain access to the API methods.  Documentation for Capital One's API can be found at [api.nessiebanking.com/documentation](http://api.nessiebanking.com/documentation).  See lib/capital_one.rb for method definitions in Ruby.  Please note that this gem in under construction as the Nessie team recently changed their API endpoint.  I expect to have this gem fully updated and 100% functional by the end of September (likely much sooner).  Thank you for your patience.

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

1. Require the gem  

	````ruby
	require 'capital_one'
	````

2. Go to [api.nessiebanking.com](http://api.nessiebanking.com/documentation) and sign up for an API Key with your Github account.  Read the documentation on the API and go to your Profile page and retrieve your API key.  Once you retrive your key you must specify the key in your project to gain access to the API.  

	````ruby
	Config.apiKey = "YOUR_API_KEY"
	````
	
	You will see that you are assigned two api keys when signing up for the API.  These keys have different roles and permissions assigned to them.
	
	**Enterprise Key** - Take on the role of a Capital One employee. Only GET requests are permitted.  
	**Customer Key** - Take on the role of a Capital One customer. All requests involving your assigned customers and anything they own are permitted.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/capital_one/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
