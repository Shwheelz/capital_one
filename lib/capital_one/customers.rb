require 'capital_one/config'

class Customer

	def self.urlWithEntity
		return CONFIG::BASEURL + "/customers"
	end

	def url
		return CONFIG::BASEURL
	end

	def self.apiKey
		return CONFIG::APIKEY
	end

	# *** GET ***

	def self.getCustomers
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
		
	end

	def self.getCustomer(id)
		url = "#{self.urlWithEntity}/#{id}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
	end

	#Get the customer for the given account.
	def self.getCustomerByAccountId(accID)
		url = "#{self.url}/#{accID}/customer?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
	end


	# *** PUT ***

	def self.updateCustomer(custID, json)
		url = "#{self.urlWithEntity}/#{custID}?key=#{self.apiKey}"
		uri = URI.parse(url)
		myHash = JSON.parse(json)
		http = Net::HTTP.new(uri.host, uri.port)
		key = "?key=#{APIkey}"
		puts(uri.path+key)
		request = Net::HTTP::Put.new(uri.path+key)
		request.set_form_data(myHash)
		http.request(request)
	end
end