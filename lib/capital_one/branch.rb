require 'capital_one/config'

class Branch

	def self.url
		return CONFIG::BASEURL
	end

	def self.urlWithEntity
		return CONFIG::BASEURL + "/branches"
	end

	def self.apiKey
		return CONFIG::APIKEY
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