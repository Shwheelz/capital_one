require 'capital_one/config'

class Branch

	def self.urlWithEntity
		return CONFIG::BASEURL + "/branches"
	end

	def url
		return CONFIG::BASEURL
	end

	def self.apiKey
		return CONFIG::APIKEY
	end

	# *** GET ***

	# Get all the branches
	def self.getBranches
		url = "#{self.urlWithEntity}?key=#{APIkey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
		
	end

	# Get a branch by it's id
	def self.getBranch(branchID)
		url = "#{self.urlWithEntity}/#{branchID}?key=#{APIkey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
		
	end
end