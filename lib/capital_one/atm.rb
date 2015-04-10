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
	#Returns all ATMs as an array of hashes.

	def self.getAll
		url = "#{self.urlWithEntity}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
	
	#==getOne
	#Parameters: ATMid
	#Returns the ATM that has the given ID. 
	def self.getOne(id)
		url = "#{self.urlWithEntity}/#{id}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
end

