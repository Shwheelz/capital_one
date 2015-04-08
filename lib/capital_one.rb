=begin
 
 This is a gem to wrap the Capital One public API.
 Visit api.reimaginebanking.com for more details.
  
=end

require 'net/http'
require 'json'
require 'uri'

require 'capital_one/accounts'
require 'capital_one/atms'
require 'capital_one/bills'
require 'capital_one/branches'
require 'capital_one/customers'
require 'capital_one/config'
require 'capital_one/transactions'

=begin 

Depending on the access level/type of API key supplied, some of
these methods will return 403 error codes(forbidden). Enterprise level
API keys have access to any/all of the GET requests, but nothing else. 
Customer level API keys have access to GET, POST, PUT, and DELETE, but only
for valid accounts which are associated with the customer API key. 

=end