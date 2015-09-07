class Customer

	def self.urlWithEntity
		return Config.baseUrl + "/customers"
	end

	def self.urlWithAcctEntity
		return Config.baseUrl + "/accounts"
	end

	def self.url
		return Config.baseUrl
	end

	def self.apiKey
		return Config.apiKey
	end

	# *** GET ***

	#== getAll
		# Gets all customers the API key has acccess to.
		# Returns an array of hashes.
	
	def self.getAll
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
		return data
	end

	#== getOne
		# Gets the specified customer's information.
		#= Parameters: CustomerId
		# Returns a Hash with the customer data
	
	def self.getOne(custId)
		url = "#{self.urlWithEntity}/#{custId}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	#== getOneByAccountId
		# Get the customer for the given account.
		#= Parameters: AccountId
		# Returns a hash with the specified customer data.
	
	def self.getOneByAccountId(accID)
		url = "#{self.urlWithAcctEntity}/#{accID}/customer?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	# *** POST ***

	#==createCustomer
		# Creates a new customer with the given json data
		#= Parameters: CustomerHash
		# JSON is as follows: 
			# {
			# "first_name": "string",
			# "last_name": "string",
			# "address": {
			# 	  "street_number": "string",
			#     "street_name": "",
			#     "city": "",
			#     "state": "",
			#     "zip": ""		
			#   }
			# }
		# Returns http response code
		
	def self.createCustomer(customer)
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
		request.body = customer.to_json
		response = http.request(request)
		return JSON.parse(response.body)
	end


	# *** PUT ***
	
	#== updateCustomer
		# Updates a customer by id with given json data. 
		#= Parameters: CustomerId, CustomerHash.
		# Json is as follows: 
			# 	{
			#   "address": {
			#     "street_number": "",
			#     "street_name": "",
			#     "city": "",
			#     "state": "",
			#     "zip": ""
			#   }
			# }
		# Returns http response code. 
	
	def self.updateCustomer(custID, customer)
		customerToUpdate = customer.to_json
		url = "#{self.urlWithEntity}/#{custID}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key = "?key=#{self.apiKey}"
		request = Net::HTTP::Put.new(uri.path+key, initheader = {'Content-Type' =>'application/json'})
		request.body = customerToUpdate
		response = http.request(request)
		return JSON.parse(response.body)
	end 

end