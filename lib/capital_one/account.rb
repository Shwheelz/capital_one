class Account

	def self.urlWithEntity
		return Config.baseUrl + "/accounts"
	end

	def self.url
		return Config.baseUrl
	end

	def self.apiKey
		return Config.apiKey
	end

	# *** GET ***
	#= getAll
		# Returns an array of hashes getting all the customers.
		# Each index in the array is the hash of an individual customer. 

	def self.getAll
		url = "#{self.urlWithEntity}?&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	#== getAllByType
		# Gets all accounts of a given type.
		#= Parameters: type
		# Accepts a string of the account type. 3 possbilities: Credit Card, Savings, Checking.
		# Returns an array of hashes with the accounts.

	def self.getAllByType(type)
		url = "#{self.urlWithEntity}?type=#{type}&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end


	#== getOne
		# Returns the account specified by its account ID.
		#= Parameters: AccountId
		# Accepts a string of the account ID. 
		# Returns a hash with the account info.
	def self.getOne(id)
		url = "#{self.urlWithEntity}/#{id}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
	
	#== getAllByCustomerId
		# Returns all accounts associated with a given customer ID as an array of hashes. 
		#= Parameters: CustomerId
		# Accepts a string of the customer ID

	def self.getAllByCustomerId(customerId)
		url = "#{self.url}/customers/#{customerId}/accounts?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end


	# *** PUT ***
	
	#==updateAccount
		# Updates an account's nickname.
		#= Parameters: AccountID, AccountHash
		# Returns the http response code.
	
	def self.updateAccount(accountId, account)
		accountToUpdate = account.to_json
		url = "#{self.urlWithEntity}/#{accountId}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key = "?key=#{self.apiKey}"
		request = Net::HTTP::Put.new(uri.path+key, initheader = {'Content-Type' =>'application/json'})
		request.body = accountToUpdate
		response = http.request(request)
		return JSON.parse(response.body)
	end


	# *** POST ***
	
	#== createAccount
	# Creates a new account
	# Parameters: CustomerID, accountHash
	# Returns the http response code. 
	
	def self.createAccount(custID, account)
		accountToCreate = account.to_json
		url = "#{self.url}/customers/#{custID}/accounts?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
		request.body = accountToCreate
		response = http.request(request)
		return JSON.parse(response.body)
	end


	# *** DELETE ***
	
	#== deleteAccount
		# delete a given account by accountId.
		# Parameters: AccountId.
		# Returns the http response code. 
	
	def self.deleteAccount(accountId)
		url = "#{self.urlWithEntity}/#{accountId}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		response = http.request(request)
	end
end
