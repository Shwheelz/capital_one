require 'capital_one/config'

class Account

	def self.urlWithEntity
		return CONFIG::BASEURL + "/accounts"
	end

	def self.url
		return CONFIG::BASEURL
	end

	def self.apiKey
		return CONFIG::APIKEY
	end

	# *** GET ***
#http://api.reimaginebanking.com:80/customers/5516c07ba520e0066c9ac53b/accounts?key=CUSTf52dd79967987b3ba94904e83cc26e47
	#tested - returns array of hashes
	# Gets all accounts based on the customer ID.
	def self.getCustAccounts(custID)
		url = "#{self.url}/customers/#{custID}/accounts?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		puts("in get Accounts")
		data = JSON.parse(resp.body)
		puts(data)
		return data
	end

	#Gets all accounts of a given type.
	#Possible arguments are: Savings, Credit Card, or Checking.
	#tested, credit card doesn't work, returns array of hashes.
	def self.getAccounts(type)
		url = "#{self.urlWithEntity}?type=#{type}&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)

	end
		#Returns the account specified by it's account ID.
		#tested - returns a hash with the account info.
	def self.getAccount(accID)
		url = "#{self.urlWithEntity}/#{accID}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
		#Gets all accounts associated with a given customer ID. 
		#tested - returns an array of hashes.
	def self.getAccountsByCustomerId(custID)
		url = "#{self.url}/customers/#{custID}/accounts?key=#{apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end


	# *** PUT ***

	#updates an account's nickname by id with given json data. 
	def self.updateAccount(acctID, json)
		url = "#{self.urlWithEntity}/#{acctID}?key=#{self.apiKey}"
		uri = URI.parse(url)
		myHash = JSON.parse(json)
		http = Net::HTTP.new(uri.host, uri.port)
		key = "?key=#{self.apiKey}"
		request = Net::HTTP::Put.new(uri.path+key)
		request.set_form_data(myHash)
		http.request(request)
	end


	# *** POST ***

	#creates a new account
	def self.createAcct(custID, json)
		url = "#{self.url}/customers/#{custID}/accounts?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
		request.body = json
		resp = http.request(request)
		puts(resp.body)
		getCustAccts('5516c07ba520e0066c9ac53b')
	end


	# *** DELETE ***

	#delete a given account with some ID
	def self.deleteAcc(accID)
		url = "#{self.urlWithEntity}/#{accID}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		resp = http.request(request)
	end
end