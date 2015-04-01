require 'net/http'
require 'json'
require 'uri'

require 'capital_one/accounts'
require 'capital_one/atms'
require 'capital_one/bills'
require 'capital_one/branches'
require 'capital_one/customers'
require 'capital_one/config'

class CapitalOne

=begin 
Depending on the access level/type of API key supplied, some of
these methods will return 403 error codes(forbidden). Enterprise level
API keys have access to any/all of the GET requests, but nothing else. 
Customer level API keys have access to GET, POST, PUT, and DELETE, but only
for valid accounts which are associated with the customer API key. 
=end

=begin
Testing data
DELETION ACCT ID(because I don't want to
break all the other testing data): 546cd56d04783a02616859c9
Note: This won't actually delete anything as it isn't a valid customer account ID associated with the API key included here. 
Customer ID: 5516c07ba520e0066c9ac53b
^That customer's bank account ID: 55173197c5749d260bb8d151	
More cust ids w/ account ids:
cust: 5516c07ba520e0066c9ac53b
acct: 55175197c5749d260bb8d159

cust: 5516c07ba520e0066c9ac53b
acct: 5517614cc5749d260bb8d160

Json for updating cusomter data: 	
myJson ='{
 		 "address": {
  		   "street_number": "424 Waupelani Drive",
    	   "street_name": "",
  		   "city": "state college",
   		   "state": "PA",
    	   "zip": "16801"
  		}
	}'

Json for updating Account data:
{
	"type":"Savings",
	"nickname":"test",
	"rewards":10,
	"balance":1000,
	"customer":"5516c07ba520e0066c9ac53b",
	"_id":"55173197c5749d260bb8d151"
	}

Json for creating a new account:
{
  "type": "Savings",
  "nickname": "TomP"1,
  "rewards": 2,
  "balance": 300
}

Json for creating a new bill: 
{
  "status": "",
  "payment_date": "",
  "recurring_date": 0,
  "payment_amount": 0
}

Json for creating a new transaction:
{
  "transaction type": "cash",
  "payee id": "5517614cc5749d260bb8d160",
  "amount": 50
}

=end
#Test Data:

	APIkey = 'CUSTf52dd79967987b3ba94904e83cc26e47'
	baseURL = 'http://api.reimaginebanking.com:80'

		json ='{
	 		 "address": {
	  		   "street_number": "424 Waupelani Drive",
	    	   "street_name": "",
	  		   "city": "state college",
	   		   "state": "PA",
	    	   "zip": "16801"
	  		}
		}'

		acctJson =	'{
			"nickname":"myTest"
		}'

		newAcctJson = '{
		  "type": "",
		  "nickname": "",
		  "rewards": 0,
		  "balance": 0
		}'

		newBillJson = '{
		  "status": "Pending",
		  "payment_amount": 1000
		}'

		newTranJson = '{
		  "transaction type": "cash",
		  "payee id": "5517614cc5749d260bb8d160",
		  "amount": 50
		}'

#End Test Data



		
		#getCustAccts('5516c07ba520e0066c9ac53b')

		#get all 
		def self.getBills(custID)
			url = "http://api.reimaginebanking.com:80/customers/#{custID}/bills?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			
		end

		#cust = 5516c07ba520e0066c9ac53b
		#bill = null
		def self.getCustBill(custID, billID)
			 url = "http://api.reimaginebanking.com:80/customers/#{custID}/bills/#{billID}?key=#{APIkey}"
			 resp = Net::HTTP.get_response(URI.parse(url))
			 data = resp.body
			 
		end



		#get all branches
		def self.getBranches
			url = "http://api.reimaginebanking.com:80/branches?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			
		end

		#find branch by id
		def self.findBranch(branchID)
			url = "http://api.reimaginebanking.com:80/branches/#{APIkey}?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			
		end



		#PUT requests

		#update customer info






		#updateAccount('55173197c5749d260bb8d151', acctJson)

		#POST requests

		#creates a new account
		def self.createAcct(custID, json)
			url = "http://api.reimaginebanking.com:80/customers/#{custID}/accounts?key=#{APIkey}"
			uri = URI.parse(url)
			http = Net::HTTP.new(uri.host, uri.port)
			request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
			request.body = json
			resp = http.request(request)
			puts(resp.body)
			getCustAccts('5516c07ba520e0066c9ac53b')
		end

		

	#Get all bills for a specific account
	def self.getBillsByAccountId(accID)
		url = "#{self.urlWithEntity}/#{accID}/bills?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
	end

	#getAccBills('55173197c5749d260bb8d151')

	#get a specific bill from a specific account
	def self.getBillByAccountIdBillId(accID, billID)
		url ="##{self.urlWithEntity}/#{accID}/bills/#{billID}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
	end
	#Find all transactions associated with an account
	def self.getTransactionsByAccountId(accID)
		url = "#{self.urlWithEntity}/#{accID}/transactions?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
	end

	#Find a transaction by id for a specific accoutnt id
	def self.getTransactionByAccountIdTransactionId(accID, tranID)
		url = "#{self.urlWithEntity}/#{accID}/transactions/#{tranID}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
	end

	# updateCustomer('5516c07ba520e0066c9ac53b', json)
	# getCustomer('5516c07ba520e0066c9ac53b')



		#create a new bill on an associated account ID
	def createBill(acctID, json)
		url = "#{self.urlWithEntity}/#{acctID}/bills?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' => 'application/json'})
		request.body = json
		resp = http.request(request)
		puts(resp.body)
		puts("in create bill")
		getAccBills(acctID)
	end
	

	#create a new transaction between 2 accounts
	def createTransaction(toAcc, json)
		url = "#{self.urlWithEntity}/#{toAcc}/transactions?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' => 'application/json'})
		request.body = json
		resp = http.request(request)
		puts("Finished Creating Transaction")
		puts(resp.body)
		getAccTransactions(toAcc)
	end


	#DELETE requests

	#delete a bill by id from a given account
	def self.deleteBill(accID, billID)
		url = "#{self.urlWithEntity}/#{accID}/bills/#{billID}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		http.request(request)
	end

	#deleteBill('546cd56d04783a02616859c9', '546cd56d04783a02616859c9')



	#deleteAcc('546cd56d04783a02616859c9')

	def self.deleteTransaction(accID, transID)
		url = "#{self.urlWithEntity}/#{accID}/transactions/#{transID}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		http.request(request)
	end


		#deleteTransaction('546cd56d04783a02616859c9', '546cd56d04783a02616859c9')


		def self.setAPIKey(key)
		#	APIkey = key
		end

		def self.getAPIKey
			return APIkey
		end
	end

