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
	def self.getAll
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
		return data
	end

	def self.getAllByLocation(lat, lng, rad)
		url = "#{self.urlWithEntity}?lat=#{lat}&lng=#{lng}&rad=#{rad}&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
   		data = JSON.parse(resp.body)
    	return data
	end

	def self.getOne(merchId)
		url = "#{self.urlWithEntity}/#{merchId}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
   		data = JSON.parse(resp.body)
    	return data
	end

	# *** PUT ***
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