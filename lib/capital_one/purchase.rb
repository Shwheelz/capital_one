class Purchase

	def self.urlWithEntity
		return Config.baseUrl + "/accounts"
	end

	def self.url
		return Config.baseUrl
	end

	def self.apiKey
		return Config.apiKey
	end

	# *** GET ***

	#==getAll
		# Returns all purchases for a given account
		#= Parameters: AccountId
		# Returns an array of hashes

	def self.getAllByAccountId(accId)
		url = "#{self.urlWithEntity}/#{accId}/purchases?&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	#==getOne
		# Returns a purchase for a given ID
		#= Parameters: PurchaseId
		# Returns a hash

	def self.getOne(id)
		url = "#{self.url}/purchases/#{id}?&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	# *** POST ***
	#==createPurchase
		# Creates a new purchase for a given account
		#= Parameters: AccountId, PurchaseHash
		# PurchaseHash is formatted as follows:
		# {
		# 	"merchant_id": "string",
		# 	"medium": "balance",
		# 	"purchase_date": "string",
		# 	"amount": 0,
		# 	"status": "pending",
		# 	"description": "string"
		# }
		# Returns http response code
	def self.createPurchase(accId, purchase)
		purchaseToCreate = purchase.to_json
		url = "#{self.urlWithEntity}/#{accId}/purchases?&key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
		request.body = purchaseToCreate
		response = http.request(request)
		return JSON.parse(response.body)
	end

	# *** PUT ***

	#==updatePurchase
		# Updates an existing purchase
		#= Parameters: PurchaseId, PurchaseHash
		# PurchaseHash is formatted as follows:
		# {
		# 	"merchant_id": "string",
		# 	"medium": "balance",
		# 	"purchase_date": "string",
		# 	"amount": 0,
		# 	"status": "pending",
		# 	"description": "string"
		# }
		# Returns http response code

	def self.updatePurchase(id, purchase)
		purchaseToUpdate = purchase.to_json
		url = "#{self.url}/purchases/#{id}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key = "?key=#{self.apiKey}"
		request = Net::HTTP::Put.new(uri.path+key, initheader = {'Content-Type' =>'application/json'})
		request.body = purchaseToUpdate
		response = http.request(request)
		return JSON.parse(response.body)
	end

	# *** DELETE ***

	#==deletePurchase
		# Deletes a purchase for a given ID
		#= Parameters: PurchaseId
		# Returns http response code
		
	def self.deletePurchase(id)
		url = "#{self.url}/purchases/#{id}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		response = http.request(request)
	end
end