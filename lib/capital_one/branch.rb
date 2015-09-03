class Branch

	def self.url
		return Config.baseUrl
	end

	def self.urlWithEntity
		return Config.baseUrl + "/branches"
	end

	def self.apiKey
		return Config.apiKey
	end

	# *** GET ***

	def self.getAll
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
		
	def self.getOne(id)
		url = "#{self.urlWithEntity}/#{id}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)	
	end
end