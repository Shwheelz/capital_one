class Transfer

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
		url = "#{self.urlWithEntity}/#{accID}/transfers?&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	def self.getAllByType(accId, type)
		url = "#{self.urlWithEntity}/#{accID}/transfers?type=#{type}&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	def self.getOne(id)
		url = "#{self.url}/transfers/#{id}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	# *** POST ***
	def self.createTransfer(accId, transfer)
		transferToCreate = transfer.to_json
		url = "#{self.urlWithEntity}/#{accId}/transfers?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
		request.body = transferToCreate
		response = http.request(request)
		return JSON.parse(response.body)
	end

	# *** PUT ***
	def self.updateTransfer(id, transfer)
		transferToUpdate = transfer.to_json
		url = "#{self.url}/transfers/#{id}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key = "?key=#{self.apiKey}"
		request = Net::HTTP::Put.new(uri.path+key, initheader = {'Content-Type' =>'application/json'})
		request.body = transferToUpdate
		response = http.request(request)
		return JSON.parse(response.body)
	end

	# *** DELETE ***
	def self.deleteTransfer(id)
		url = "#{self.url}/transfers/#{id}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		response = http.request(request)
	end
end