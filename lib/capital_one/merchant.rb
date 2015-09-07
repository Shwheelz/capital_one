class Merchant

	def self.urlWithEntity
		return Config.baseUrl + "/merchants"
	end

	def self.url
		return Config.baseUrl
	end

	def self.apiKey
		return Config.apiKey
	end

	# *** GET ***

	#==getAll
		# Returns all Merchants as an array of hashes
	def self.getAll
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
		return data
	end

	#==getAllByLocation
		# Returns all Merchants within a given location range
		#= Parameters: Latitude, Longitude, Radius
		# Accepts lat, lng, and rad as floats
		# Returns an array of hashes

	def self.getAllByLocation(lat, lng, rad)
		url = "#{self.urlWithEntity}?lat=#{lat}&lng=#{lng}&rad=#{rad}&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
   		data = JSON.parse(resp.body)
    	return data
	end

	#==getOne
		# Returns a single merchant for a given ID
		#= Parameters: MerchantId
		# Returns a hash

	def self.getOne(merchId)
		url = "#{self.urlWithEntity}/#{merchId}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
   		data = JSON.parse(resp.body)
    	return data
	end

	# *** PUT ***

	#==updateMerchant
		# Updates an existing Merchant
		#= Parameters: MerchantId, MerchantHash
		# MerchantHash format is as follows: 
		# 	{
		# 		"name": "string",
		# 		"address": {
		# 			"street_number": "string",
		# 			"street_name": "string",
		# 			"city": "string",
		# 			"state": "string",
		# 			"zip": "string",
		#		},
		# 		"geocode": {
		# 			"lat": 0,
		# 			"lng": 0,
		# 		}
		# 	}
		# Returns http response code

	def self.updateMerchant(merchId, merchant)
		merchantToUpdate = merchant.to_json
		url = "#{self.urlWithEntity}/#{merchId}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key = "?key=#{self.apiKey}"
		request = Net::HTTP::Put.new(uri.path+key, initheader = {'Content-Type' =>'application/json'})
		request.body = merchantToUpdate
		response = http.request(request)
		return JSON.parse(response.body)
	end

	# *** POST ***

	#==createMerchant
		# Creates a new Merchant
		#= Parameters: MerchantHash
		# MerchantHash format is as follows: 
		# 	{
		# 		"name": "string",
		# 		"address": {
		# 			"street_number": "string",
		# 			"street_name": "string",
		# 			"city": "string",
		# 			"state": "string",
		# 			"zip": "string",
		#		},
		# 		"geocode": {
		# 			"lat": 0,
		# 			"lng": 0,
		# 		}
		# 	}
		# Returns http response code
		
	def self.createMerchant(merchant)
		merchantToCreate = merchant.to_json
		url = "#{self.urlWithEntity}/?key=#{self.apiKey}"
		uri = URI.parse(url)
	    http = Net::HTTP.new(uri.host, uri.port)
	    request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' => 'application/json'})
	    request.body = merchantToCreate
	    resp = http.request(request)
	    data = JSON.parse(resp.body)
	end

end