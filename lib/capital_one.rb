=begin
 
==Capital One API Gem

 This is a gem to wrap the Capital One public API.
 Visit api.reimaginebanking.com for more details.
  
=end

module Config
  class << self
    attr_accessor :apiKey

    def baseUrl
      @baseUrl = 'http://api.reimaginebanking.com:80'
    end
  end
end

require 'net/http'
require 'json'
require 'uri'

require 'capital_one/account'
require 'capital_one/atm'
require 'capital_one/bill'
require 'capital_one/branch'
require 'capital_one/customer'
require 'capital_one/transaction'
 
=begin 

==Important Info

Depending on the access level/type of API key supplied, some of
these methods will return 403 error codes(forbidden). Enterprise level
API keys have access to any/all of the GET requests, but nothing else. 
Customer level API keys have access to GET, POST, PUT, and DELETE, but only
for valid accounts which are associated with the customer API key. 

Additionally, some of the GET requests will change in functionality depending on the
type of key used. For example, the getAll method in the Customer class returns all customers if
the enterprise API key is used. If the customer API key is used, it will only return the customers that
the key is associated with.

For the purposes of this gem, any ID parameters Strings that are 24 hex characters long. Below is an example:
5326c07ba520d1066c9ac52b

You can see the API that this gem wraps at api.reimaginebanking.com



=end