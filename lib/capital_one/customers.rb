require 'capital_one/config'


class Customer

	def self.urlWithEntity
		return CONFIG::BASEURL + "/customers"
	end

	def self.urlWithAcctEntity
		return CONFIG::BASEURL + "/accounts"
	end

	def url
		return CONFIG::BASEURL
	end

	def self.apiKey
		return CONFIG::APIKEY
	end

	# *** GET ***

	#Returns all customers that the API key used has access to.
	#tested - Returns an array of hashes.
	def self.getCustomers
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
		return data
		
	end
	#Gets the specified customer's information.
	#tested - Returns a hash.
	def self.getCustomer(custId)
		url = "#{self.urlWithEntity}/#{custId}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	#Get the customer for the given account.
	#tested - Returns a hash with the specified customer data.
	def self.getCustomerByAccountId(accID)
		url = "#{self.urlWithAcctEntity}/#{accID}/customer?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end


	# *** PUT ***

	def self.updateCustomer(custID, json)
		url = "#{self.urlWithEntity}/#{custID}?key=#{self.apiKey}"
		uri = URI.parse(url)
		myHash = JSON.parse(json)
		http = Net::HTTP.new(uri.host, uri.port)
		key = "?key=#{self.apiKey}"
		puts(uri.path+key)
		request = Net::HTTP::Put.new(uri.path+key)
		request.set_form_data(myHash)
		http.request(request)
	end

	# 

end