class Lib
=begin 
	Depending on the access level/type of API key supplied, some of
	these methods will return 403 error codes(forbidden). Enterprise level
	API keys have access to any/all of the GET requests, but nothing else. 
	Customer level API keys have access to GET, POST, PUT, and DELETE, but only
	for valid accounts which are associated with the customer API key. 
=end
	#Enterprise APIKey
	#APIkey = 'ENTf52dd79967987b3ba94904e83cc26e47'

	#Customer APIKey
	APIkey = 'CUSTf52dd79967987b3ba94904e83cc26e47'
	baseURL = 'http://api.reimaginebanking.com:80'

=begin
	Testing data
	DELETION ACCT ID(because I don't want to fucking
	break all the other testing data): 546cd56d04783a02616859c9
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
	  "nickname": "TomP",
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
	module CapitalOne
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
		  "payment_amount": 10
		}'

		newTranJson = '{
		  "transaction type": "cash",
		  "payee id": "5517614cc5749d260bb8d160",
		  "amount": 50
		}'

		#GET requests

		def getATMS
			url = "http://api.reimaginebanking.com:80/atms?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			puts(data)
		end
=begin
		def getATM(id)
			url = "http://api.reimaginebanking.com:80/atms/#{id}?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
		end

		def getCustomers
			url = "http://api.reimaginebanking.com:80/customers?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			puts(data)
		end

		def getCustomer(id)
			url = "http://api.reimaginebanking.com:80/customers/#{id}?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			puts(data)
		end

		def getCustAccts(custID)
			url = "http://api.reimaginebanking.com:80/customers/#{custID}/accounts?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			puts(data)
		end
		#getCustAccts('5516c07ba520e0066c9ac53b')

		#get all 
		def getBills(custID)
			url = "http://api.reimaginebanking.com:80/customers/#{custID}/bills?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			puts(data)
		end

		#cust = 5516c07ba520e0066c9ac53b
		#bill = null
		def getCustBill(custID, billID)
			 url = "http://api.reimaginebanking.com:80/customers/#{custID}/bills/#{billID}?key=#{APIkey}"
			 resp = Net::HTTP.get_response(URI.parse(url))
			 data = resp.body
			 puts(data)
		end

		#Gets all accounts of a given type.
		#Possible arguments are: Savings, Credit Card, or Checking.
		def getAllAccounts(type)
			url = "http://api.reimaginebanking.com:80/accounts?type=#{type}&key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			puts(data)
		end

		def getAccById(accID)
			url = "http://api.reimaginebanking.com:80/accounts/#{accID}?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			puts(data)
		end
		#Get the customer for the given account.
		def getCustForAcc(accID)
			url = "http://api.reimaginebanking.com:80/accounts/#{accID}/customer?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			puts(data)
		end
		#Get all bills for a specific account
		def getAccBills(accID)
			url = "http://api.reimaginebanking.com:80/accounts/#{accID}/bills?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			puts(data)
		end

		#getAccBills('55173197c5749d260bb8d151')

		#get a specific bill from a specific account
		def findAccBill(accID, billID)
			url ="http://api.reimaginebanking.com:80/accounts/#{accID}/bills/#{billID}?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			puts(data)
		end
		#Find all transactions associated with an account
		def getAccTransactions(accID)
			url = "http://api.reimaginebanking.com:80/accounts/#{accID}/transactions?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			puts(data)
		end
		#Find a transaction by id for a specific accoutnt id
		def findAccTransaction(accID, tranID)
			url = "http://api.reimaginebanking.com:80/accounts/#{accID}/transactions/#{tranID}?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			puts(data)
		end

		#get all branches
		def getBranches
			url = "http://api.reimaginebanking.com:80/branches?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			puts(data)
		end

		#find branch by id
		def findBranch(branchID)
			url = "http://api.reimaginebanking.com:80/branches/#{APIkey}?key=#{APIkey}"
			resp = Net::HTTP.get_response(URI.parse(url))
			data = resp.body
			puts(data)
		end



		#PUT requests

		#update customer info

		def updateCustomer(custID, json)
			url = "http://api.reimaginebanking.com:80/customers/#{custID}?key=#{APIkey}"
			uri = URI.parse(url)
			myHash = JSON.parse(json)
			puts(myHash)
			http = Net::HTTP.new(uri.host, uri.port)
			puts(uri.host)
			puts(uri.port)
			key = "?key=#{APIkey}"
			puts(uri.path+key)
			request = Net::HTTP::Put.new(uri.path+key)
			request.set_form_data(myHash)
			http.request(request)
			puts(http.request(request))
		end

		# updateCustomer('5516c07ba520e0066c9ac53b', json)
		# getCustomer('5516c07ba520e0066c9ac53b')

		#updates an account's nickname by id with given json data. 
		def updateAccount(acctID, json)
			url = "http://api.reimaginebanking.com:80/accounts/#{acctID}?key=#{APIkey}"
			uri = URI.parse(url)
			myHash = JSON.parse(json)
			puts(myHash)
			http = Net::HTTP.new(uri.host, uri.port)
			puts(uri.host)
			puts(uri.port)
			key = "?key=#{APIkey}"
			puts(uri.path+key)
			request = Net::HTTP::Put.new(uri.path+key)
			request.set_form_data(myHash)
			http.request(request)
			puts(http.request(request))
		end


		#updateAccount('55173197c5749d260bb8d151', acctJson)

		#POST requests

		#creates a new account
		def createAcct(custID, json)
			url = "http://api.reimaginebanking.com:80/customers/#{custID}/accounts?key=#{APIkey}"
			uri = URI.parse(url)
			http = Net::HTTP.new(uri.host, uri.port)
			puts(uri.host)
			puts(uri.port)
			key = "?key=#{APIkey}"
			puts(uri.path+key)
			myHash = JSON.parse(json)
			puts(myHash)
			puts(Net::HTTP.post_form(uri, myHash))
		#	getCustAccts('5516c07ba520e0066c9ac53b')
		end
		getCustAccts("5516c07ba520e0066c9ac53b")

		#createAcct('5516c07ba520e0066c9ac53b', newAcctJson)

		#create a new bill on an associated account ID
		# def createBill(acctID, json)
		# 	url = "http://api.reimaginebanking.com:80/accounts/#{acctID}/bills?key=#{APIkey}"
		# 	uri = URI.parse(url)
		# 	http = Net::HTTP.new(uri.host, uri.port)
		# 	puts(uri.host)
		# 	puts(uri.port)
		# 	key = "?key=#{APIkey}"
		# 	puts(uri.path+key)
		# 	myHash = JSON.parse(json)
		# 	puts(myHash)
		# 	puts(Net::HTTP.post_form(uri, myHash))
		# 	puts(getAccBills('55173197c5749d260bb8d151'))
		# end
		# createBill("55173197c5749d260bb8d151", newBillJson)

		#create a new transaction between 2 accounts
		def createTransaction(toAcc, json)
			url = "http://api.reimaginebanking.com:80/accounts/#{toAcc}/transactions?key=#{APIkey}"
			uri = URI.parse(url)
			http = Net::HTTP.new(uri.host, uri.port)
			puts(uri.host)
			puts(uri.port)
			key = "?key=#{APIkey}"
			puts(uri.path+key)
			myHash = JSON.parse(json)
			puts(myHash)
			Net::HTTP.post_form(uri, myHash)
			getAccTransactions('55175197c5749d260bb8d159')
		end
		#createTransaction('5516c07ba520e0066c9ac53b', newTranJson)


		#DELETE requests

		#delete a bill by id from a given account
		def deleteBill(accID, billID)
			url = "http://api.reimaginebanking.com:80/accounts/#{accID}/bills/#{billID}?key=#{APIkey}"
			uri = URI.parse(url)
			http = Net::HTTP.new(uri.host, uri.port)
			key="?key=#{APIkey}"
			request = Net::HTTP::Delete.new(uri.path+key)
			http.request(request)
			puts('in del bill')
			puts(http.request(request))
		end

		deleteBill('546cd56d04783a02616859c9', '546cd56d04783a02616859c9')

		#delete a given account with some ID
		def deleteAcc(accID)
			url = "http://api.reimaginebanking.com:80/accounts/#{accID}?key=#{APIkey}"
			uri = URI.parse(url)
			http = Net::HTTP.new(uri.host, uri.port)
			key="?key=#{APIkey}"
			request = Net::HTTP::Delete.new(uri.path+key)
			http.request(request)
			puts('in del acc')
			puts(http.request(request))
		end

		#deleteAcc('546cd56d04783a02616859c9')

		def deleteTransaction(accID, transID)
			url = "http://api.reimaginebanking.com:80/accounts/#{accID}/transactions/#{transID}?key=#{APIkey}"
			uri = URI.parse(url)
			http = Net::HTTP.new(uri.host, uri.port)
			key="?key=#{APIkey}"
			request = Net::HTTP::Delete.new(uri.path+key)
			http.request(request)
			puts('in del transaction')
			puts(http.request(request))
		end
		deleteTransaction('546cd56d04783a02616859c9', '546cd56d04783a02616859c9')


		def setAPIKey(key)
		#	APIkey = key
		end

		def getAPIKey
			return APIkey
		end
=end
	end
end