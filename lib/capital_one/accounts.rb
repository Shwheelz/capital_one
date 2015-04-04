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

	# This method doesn't work.  It expects an argument
	def self.getAccounts
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
	end

	#Gets all accounts of a given type.
	#Possible arguments are: Savings, Credit Card, or Checking.
	def self.getAccounts(type)
		url = "#{self.urlWithEntity}?type=#{type}&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
	end

	def self.getAccount(accID)
		url = "#{self.urlWithEntity}/#{accID}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
	end

	def self.getAccountsByCustomerId(custID)
		url = "#{self.url}/customers/#{custID}/accounts?key=#{APIkey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
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