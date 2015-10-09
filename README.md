# capital_one

The [capital_one gem](http://https://rubygems.org/gems/capital_one) interfaces Ruby developers with Capital One's Hackathon API.  Simply require 'capital_one' and gain access to the API methods.  Documentation for Capital One's API can be found at [http://reimaginebanking.com/documentation](http://api.reimaginebanking.com/documentation).

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

2. Go to [http://reimaginebanking.com](http://api.reimaginebanking.com/documentation) and sign up for an API Key with your Github account.  Read the documentation on the API and go to your Profile page and retrieve your API key.  Once you retrive your key you must specify the key in your project to gain access to the API.  

	````ruby
	Config.apiKey = "YOUR_API_KEY"
	````
	
	You will see that you are assigned two api keys when signing up for the API.  These keys have different roles and permissions assigned to them.
	
	**Enterprise Key** - Take on the role of a Capital One employee. Only GET requests are permitted.  
	**Customer Key** - Take on the role of a Capital One customer. All requests involving your assigned customers and anything they own are permitted.

## Bugs/Quirks
1. No methods for Enterprise endpoints.  If you wish to use Enterprise, you will have to write your own get requests.  [Net::HTTP](http://ruby-doc.org/stdlib-2.2.3/libdoc/net/http/rdoc/Net/HTTP.html) is the easiest way to do this.
2. Responses that are paginated, such as getting all ATMs or all Branches, isn't intuitive to use with wrapper methods.  Again, this can be accomplished through writing explicit requests to the endpoint supplied in the response.
3. Transactions can take up to 60 seconds to occur.  This isn't a bug with the wrapper; the API is designed to execute transactions every minute to simulate the delayed transaction time experienced with real transactions.
4. ATMs are populated for Arlington, VA and surrounding locations, not the whole country

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/capital_one/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
