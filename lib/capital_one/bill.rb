class Bill

	def self.accountBaseUrl
		return Config.baseUrl + "/accounts"
	end

	def self.customerBaseUrl
		return Config.baseUrl + "/customers"
	end

	def self.url
		return Config.baseUrl
	end

	def self.apiKey
		return Config.apiKey
	end

	# *** GET ***

	#tested -returns array of hashes
	# Get all bills for a specific customer
	def self.getAllByCustomerId(customerId)
		url = "#{self.customerBaseUrl}/#{customerId}/bills?key=#{self.apiKey}"
		response = Net::HTTP.get_response(URI.parse(url))
		return JSON.parse(response.body)
	end
	#tested - returns array of hashes
	# Get a specific bill
	def self.getOneByCustomerIdBillId(customerId, billId)
		url = "#{self.customerBaseUrl}/#{customerId}/bills/#{billId}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
	#tested - returns an array of hashes with the bills for that account in it.
	#Get all bills for a specific account
	def self.getAllByAccountId(accountId)
		url = "#{self.accountBaseUrl}/#{accountId}/bills?key=#{self.apiKey}"
		response = Net::HTTP.get_response(URI.parse(url))
		return JSON.parse(response.body)
	end
	
	#get a specific bill from a specific account
	def self.getOneByAccountIdBillId(accountId, billId)
		url ="#{self.accountBaseUrl}/#{accountId}/bills/#{billId}?key=#{self.apiKey}"
		response = Net::HTTP.get_response(URI.parse(url))
		return JSON.parse(response.body)
	end

	# *** POST ***

	# need PUT method here

	# *** POST ***

	#create a new bill on an associated account ID
	def self.createBill(accountId, bill)
		url = "#{self.accountBaseUrl}/#{accountId}/bills?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' => 'application/json'})
		request.body = bill.to_json
		response = http.request(request)
		return JSON.parse(response.body)
	end


	# *** DELETE ***

	#delete a bill by id from a given account
	def self.deleteBill(accountId, billId)
		url = "#{self.accountBaseUrl}/#{accountId}/bills/#{billId}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		response = http.request(request)
		return JSON.parse(response)
	end
end