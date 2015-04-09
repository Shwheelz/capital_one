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

	# Get all the branches
	#tested - returns an array of hashes. Each hash is a branch.
	def self.getAll
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
		
	end

	# Get a branch by it's id
	#tested - returns a hash with the specified branch.
	def self.getOne(id)
		url = "#{self.urlWithEntity}/#{id}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
		
	end
end