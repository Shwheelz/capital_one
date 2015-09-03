class Purchase

	def self.urlWithEntity
		return Config.baseUrl + "/accounts"
	end

	def self.url
		return Config.baseUrl
	end

	def self.apiKey
		return Config.apiKey
	end

	# *** GET ***
	def self.getAll(accId)
		url = "#{self.urlWithEntity}/#{accId}/purchases?&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	def self.getOne(id)
		url = "#{self.url}/purchases/#{id}?&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	# *** POST ***
	def self.createPurchase(accId, purchase)
		purchaseToCreate = purchase.to_json
		url = "#{self.urlWithEntity}/accId/purchases?&key=#{self.apiKey}"
		uri = URI.parse(url)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
		request.body = purchaseToCreate
		response = http.request(request)
		return JSON.parse(response.body)
	end

	# *** PUT ***
	def self.updatePurchase(id, purchase)
		purchaseToUpdate = purchase.to_json
		url = "#{self.url}/purchases/#{id}?&key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key = "?key=#{self.apiKey}"
		request = Net::HTTP::Put.new(uri.path+key, initheader = {'Content-Type' =>'application/json'})
		request.body = purchaseToUpdate
		response = http.request(request)
		return JSON.parse(response.body)
	end

	# *** DELETE ***
	def self.deletePurchase(id)
		url = "#{self.url}/purchases/#{id}?&key={#self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		response = http.request(request)
	end
end