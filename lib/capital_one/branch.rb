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

	#==getAll
		# Gets all branches
		# Returns an array of Hashes with the branch data

	def self.getAll
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
		
	#==getOne
		# Gets one branch for a given ID
		#= Parameters: AtmId
		# Returns a hash with the ATM data

	def self.getOne(id)
		url = "#{self.urlWithEntity}/#{id}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)	
	end
end