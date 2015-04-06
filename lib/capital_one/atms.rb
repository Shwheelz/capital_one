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
		#tested
	def self.getATMs
		url = "#{self.urlWithEntity}?key=#{apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
		#tested
	def self.getATMById(id)
		url = "#{self.urlWithEntity}/#{id}?key=#{apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
end

