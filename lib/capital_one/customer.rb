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

	#Returns all customers that the API key used has access to.
	#tested - Returns an array of hashes.
	def self.getAll
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
		return data
	end
	#Gets the specified customer's information.
	#tested - Returns a hash.
	def self.getOne(custId)
		url = "#{self.urlWithEntity}/#{custId}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	#Get the customer for the given account.
	#tested - Returns a hash with the specified customer data.
	def self.getOneByAccountId(accID)
		url = "#{self.urlWithAcctEntity}/#{accID}/customer?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end


	# *** PUT ***

	def self.updateCustomer(custID, customer)
		url = "#{self.urlWithEntity}/#{custID}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key = "?key=#{self.apiKey}"
		request = Net::HTTP::Put.new(uri.path+key)
		request.set_form_data(customer)
		response = http.request(request)
		return JSON.parse(response.body)
	end

	# 

end