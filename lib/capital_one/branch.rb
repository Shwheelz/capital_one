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
	# Get all the branches
	#Returns an array of hashes. Each hash is a branch.
	def self.getAll
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	#==getAllByLocation
	# Get all Branches withing a certain radius of a geocoordinate
	# Returns an array of hashes within the radius of the geocoordinate.  Each hash has a branch.
	def self.getAllByLocation(lat, lng, rad)
		url = "#{self.urlWithEntity}?lat=#{lat}&lng=#{lng}&rad=#{rad}&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	#==getOne
	#Get a branch by it's id
	#Parameters: BranchId
	#Returns a hash with the specified branch.
	def self.getOne(id)
		url = "#{self.urlWithEntity}/#{id}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
		
	end
end