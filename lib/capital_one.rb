=begin
 
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

Depending on the access level/type of API key supplied, some of
these methods will return 403 error codes(forbidden). Enterprise level
API keys have access to any/all of the GET requests, but nothing else. 
Customer level API keys have access to GET, POST, PUT, and DELETE, but only
for valid accounts which are associated with the customer API key. 

=end