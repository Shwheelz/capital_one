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
		# Returns all ATMs as an array of hashes.

	def self.getAll
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	#==getAllByLocation
		# Get all ATMs withing a certain radius of a geocoordinate
		# Returns an array of hashes within the radius of the geocoordinate.  Each hash has an ATM.
	
	def self.getAllByLocation(lat, lng, rad)
		url = "#{self.urlWithEntity}?lat=#{lat}&lng=#{lng}&rad=#{rad}&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
	
	#==getOne
		# Parameters: ATMid
		# Returns the ATM that has the given ID. 
	
	def self.getOne(id)
		url = "#{self.urlWithEntity}/#{id}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
end

