class Transfer

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
	#= getAll
		# Returns an array of hashes getting all the transfers for an account.
		# Each index in the array is the hash of an individual transfer.
	def self.getAll(accId)
		url = "#{self.urlWithEntity}/#{accId}/transfers?&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	#== getAllByType
		# Gets all transfers of a given type and account.
		#= Parameters:
		# Accepts a string of the transfer type. 2 possbilities: payer or payee
		# Returns an array of hashes with the transfers.
	def self.getAllByType(accId, type)
		url = "#{self.urlWithEntity}/#{accId}/transfers?type=#{type}&key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	#== getOne
		# Returns the transfer specified by its transfer ID.
		#= Parameters:
		# Accepts a string of the transfer ID. 
		# Returns a hash with the transfer info.
	def self.getOne(id)
		url = "#{self.url}/transfers/#{id}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	# *** POST ***
	#== createAccount
		# Creates a new transfer
		# Parameters: AccountID, TransferHash
		# Returns the http response code. 
	def self.createTransfer(accId, transfer)
		transferToCreate = transfer.to_json
		url = "#{self.urlWithEntity}/#{accId}/transfers?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
		request.body = transferToCreate
		response = http.request(request)
		return JSON.parse(response.body)
	end

	# *** PUT ***
	#==updateAccount
		# Updates a transfer's info.
		# Parameters: TransferId, TransferHash
		# Returns the http response code.
	def self.updateTransfer(id, transfer)
		transferToUpdate = transfer.to_json
		url = "#{self.url}/transfers/#{id}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key = "?key=#{self.apiKey}"
		request = Net::HTTP::Put.new(uri.path+key, initheader = {'Content-Type' =>'application/json'})
		request.body = transferToUpdate
		response = http.request(request)
		return JSON.parse(response.body)
	end

	# *** DELETE ***
	#== deleteAccount
		# delete a given transfer by TransferId.
		# Parameters: TransferId.
		# Returns the http response code. 
	def self.deleteTransfer(id)
		url = "#{self.url}/transfers/#{id}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		response = http.request(request)
	end
end