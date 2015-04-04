require 'capital_one/config'

class Bill

	def self.accountBaseUrl
		return CONFIG::BASEURL + "/accounts"
	end

	def self.customerBaseUrl
		return CONFIG::BASEURL + "/customers"
	end

	def url
		return CONFIG::BASEURL
	end

	def self.apiKey
		return CONFIG::APIKEY
	end

	# *** GET ***


	# Get all bills for a specific customer
	def self.getBills(custID)
		url = "#{self.customerBaseUrl}/#{custID}/bills?key=#{APIkey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
		
	end

	# Get a specific bill
	def self.getCustBill(custID, billID)
		 url = "#{self.customerBaseUrl}/#{custID}/bills/#{billID}?key=#{APIkey}"
		 resp = Net::HTTP.get_response(URI.parse(url))
		 data = resp.body
		 
	end

	#Get all bills for a specific account
	def self.getBillsByAccountId(accID)
		url = "#{self.accountBaseUrl}/#{accID}/bills?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
	end

	#get a specific bill from a specific account
	def self.getBillByAccountIdBillId(accID, billID)
		url ="##{self.accountBaseUrl}/#{accID}/bills/#{billID}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
	end


	# *** POST ***

	#create a new bill on an associated account ID
	def createBill(acctID, json)
		url = "#{self.accountBaseUrl}/#{acctID}/bills?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' => 'application/json'})
		request.body = json
		resp = http.request(request)
		puts(resp.body)
		puts("in create bill")
		getAccBills(acctID)
	end


	# *** DELETE ***

	#delete a bill by id from a given account
	def self.deleteBill(accID, billID)
		url = "#{self.accountBaseUrl}/#{accID}/bills/#{billID}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		resp = http.request(request)
	end
end