class Atm

	def self.urlWithEntity
		return Config.baseUrl + "/atms"
	end

	def self.url
		return Config.baseUrl
	end

	def self.apiKey
		return Config.apiKey
	end

	# *** GET ***
	
	#==getAll
		# Returns all ATMs as a hash (first page only)
		# Pagination was implemented to break up the size of the hash

	def self.getAll
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	#==getAll(page)
		# Returns all ATMs for a given response page
		#= Parameters: page as an integer
		# Returns a hash of ATM details 

	def self.getAllWithPage(page)
		url = "#{self.urlWithEntity}?key=#{self.apiKey}&page=#{page}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	#==getAllByLocation
		# Get all ATMs withing a certain radius of a geocoordinate
		#= Paremeters: latitude, longitude, radius
		# Accepts lat, lng, and rad as floats
		# Returns an array of hashes within the radius of the geocoordinate.  Each hash has an ATM.
	
	def self.getAllByLocation(lat, lng, rad)
		url = "#{self.urlWithEntity}?lat=#{lat}&lng=#{lng}&rad=#{rad}&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
	
	#==getAllByLocationWithPage
		# Returns all ATMs within a certain radius for a given response page
		#= Parameters: lat, lng, and rad as floats; page as int
		# Returns a hash of ATM details

	def self.getAllByLocationWithPage(lat, lng, rad, page)
		url = "#{self.urlWithEntity}?lat=#{lat}&lng=#{lng}&rad=#{rad}&key=#{self.apiKey}&page=#{page}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end


	#==getOne
		# Gets one ATM for a given ID
		# Parameters: AtmId
		# Returns the ATM that has the given ID. 
	
	def self.getOne(id)
		url = "#{self.urlWithEntity}/#{id}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
end

