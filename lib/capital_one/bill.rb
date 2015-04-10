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

	#==getAllByCustomerId
	# Get all bills for a specific customer
	#Parameters: customerId
	#Returns the customer as a hash array.
	def self.getAllByCustomerId(customerId)
		url = "#{self.customerBaseUrl}/#{customerId}/bills?key=#{self.apiKey}"
		response = Net::HTTP.get_response(URI.parse(url))
		return JSON.parse(response.body)
	end

	#==getOneByCustomerIdBillId
	# Get a specific bill from a specific customer.
	#Parameters: customerId, BillId
	#Returns the specified bill as a hash array
	def self.getOneByCustomerIdBillId(customerId, billId)
		url = "#{self.customerBaseUrl}/#{customerId}/bills/#{billId}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	#==getAllByAccountId
	#Get all bills for a specific account
	#Parameters: accountId
	#Returns an array of hashes containing the bills. 
	def self.getAllByAccountId(accountId)
		url = "#{self.accountBaseUrl}/#{accountId}/bills?key=#{self.apiKey}"
		response = Net::HTTP.get_response(URI.parse(url))
		return JSON.parse(response.body)
	end
	#==getOneByAccountIdBillId
	#Get a specific bill from a specific account
	#Parameters: AccountId, BillId
	#Returns a hash array with the bill. 
	def self.getOneByAccountIdBillId(accountId, billId)
		url ="#{self.accountBaseUrl}/#{accountId}/bills/#{billId}?key=#{self.apiKey}"
		response = Net::HTTP.get_response(URI.parse(url))
		return JSON.parse(response.body)
	end

	# *** POST ***
	#==updateBill
	#Updates an account's nickname by id with given json data. 
	#Parameters: AccountId, BillId, BillJson
	#Json format is as follows: 
		# 	{
		#   "status": "",
		#   "payee": "",
		#   "nickname": "",
		#   "payment_date": "",
		#   "recurring_date": 0,
		#   "payment_amount": 0
		# }
	#Returns http response code. 

	def self.updateBill(accountId, billId, bill)
		url = "#{self.accountBaseUrl}/#{accountId}/bills/#{billId}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key = "?key=#{self.apiKey}"
		request = Net::HTTP::Put.new(uri.path+key)
		request.set_form_data(bill)
		response = http.request(request)
		return JSON.parse(response.body)
	end

	# *** POST ***
	#==createBill
	#create a new bill on an associated account ID
	#Parameters: AccountId, BillJson
	#Json is as follows:
		# 	{
		#   "status": "",
		#   "payee": "",
		#   "nickname": "",
		#   "payment_date": "",
		#   "recurring_date": 0,
		#   "payment_amount": 0
		# }
	#Returns http response code. 
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
	#delete a bill by id from a given account.
	#Parameters: Accountid, billid.
	#Returns http response code. 
	def self.deleteBill(accountId, billId)
		url = "#{self.accountBaseUrl}/#{accountId}/bills/#{billId}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		response = http.request(request)
	end
end