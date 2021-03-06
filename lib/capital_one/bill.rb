class Bill

	def self.accountBaseUrl
		return Config.baseUrl + "/accounts"
	end

	def self.customerBaseUrl
		return Config.baseUrl + "/customers"
	end

	def self.urlWithEntity
		return Config.baseUrl + "/bills"
	end

	def self.url
		return Config.baseUrl
	end

	def self.apiKey
		return Config.apiKey
	end

	# *** GET ***

	#==getAllByAccountId
		# Get all bills for a specific account
		# Parameters: accountId
		# Returns an array of hashes containing the bills. 

	def self.getAllByAccountId(accountId)
		url = "#{self.accountBaseUrl}/#{accountId}/bills?key=#{self.apiKey}"
		response = Net::HTTP.get_response(URI.parse(url))
		return JSON.parse(response.body)
	end

	#==getAllByCustomerId
		# Get all bills for a specific customer
		# Parameters: customerId
		# Returns the customer as a hash array.

	def self.getAllByCustomerId(customerId)
		url = "#{self.customerBaseUrl}/#{customerId}/bills?key=#{self.apiKey}"
		response = Net::HTTP.get_response(URI.parse(url))
		return JSON.parse(response.body)
	end

	#==getOne
		# Gets one bill for a specific billId
		# Parameters: billId
		# Returns a hash with the bill data

	def self.getOne(id)
		url = "#{self.urlWithEntity}/#{id}?key=#{self.apiKey}"
		response = Net::HTTP.get_response(URI.parse(url))
		return JSON.parse(response.body)
	end

	# *** POST ***

	#==updateBill
		# Updates an account's information by id with given json data. 
		# Parameters: BillId, BillJson
		# Json format is as follows: 
			# 	{
			#   "status": "",
			#   "payee": "",
			#   "nickname": "",
			#   "payment_date": "",
			#   "recurring_date": 0,
			#   "payment_amount": 0
			# }
		# Returns http response code. 

	def self.updateBill(billId, bill)
		billToUpdate = bill.to_json
		url = "#{self.urlWithEntity}/#{billId}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key = "?key=#{self.apiKey}"
		request = Net::HTTP::Put.new(uri.path+key, initheader = {'Content-Type' =>'application/json'})
		request.body = billToUpdate
		response = http.request(request)
		return JSON.parse(response.body)
	end

	#==createBill
		# create a new bill on an associated account ID
		# Parameters: AccountId, BillJson
		# Json is as follows:
			# 	{
			#   "status": "",
			#   "payee": "",
			#   "nickname": "",
			#   "payment_date": "",
			#   "recurring_date": 0,
			#   "payment_amount": 0
			# }
		# Returns http response code. 

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
	#==deleteBill
		# delete a bill by its id
		# Parameters: BillId
		# Returns http response code
		
	def self.deleteBill(billId)
		url = "#{self.urlWithEntity}/#{billId}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		response = http.request(request)
	end
end