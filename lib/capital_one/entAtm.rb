require 'capital_one/config'

class EntAtm

	def self.urlWithEntity
		return CONFIG::BASEURL + "/atms"
	end

	def self.url
		return CONFIG::BASEURL
	end

	def self.apiKey
		return CONFIG::ENTAPIKEY
	end

	# *** GET ***
	def self.getAll
		url = "#{self.urlWithEntity}?key=#{apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
	
	def self.getOne(id)
		url = "#{self.urlWithEntity}/#{id}?key=#{apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end
end

