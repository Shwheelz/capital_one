require 'capital_one/config'

class ATM

	def self.urlWithEntity
		return CONFIG::BASEURL + "/atms"
	end

	def url
		return CONFIG::BASEURL
	end

	def self.apiKey
		return CONFIG::APIKEY
	end

	# *** GET ***

	def self.getATMs
		url = "#{self.urlWithEntity}?key=#{APIkey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
	end

	def self.getATMById(id)
		url = "#{self.urlWithEntity}/#{id}?key=#{APIkey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = resp.body
	end
end