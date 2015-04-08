require 'capital_one/config'

class Atm

	def self.urlWithEntity
		return CONFIG::BASEURL + "/atms"
	end

	def self.url
		return CONFIG::BASEURL
	end

	def self.apiKey
		return CONFIG::APIKEY
	end

	# *** GET ***
		#tested
	def self.getAtms
		url = "#{self.urlWithEntity}?key=#{apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
		#tested
	def self.getAtm(id)
		url = "#{self.urlWithEntity}/#{id}?key=#{apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
end

