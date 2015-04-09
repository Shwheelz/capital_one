class Transaction

	def self.urlWithEntity
		return CONFIG::BASEURL + "/accounts"
	end

	def url
		return CONFIG::BASEURL
	end

	def self.apiKey
		return CONFIG::APIKEY
	end


	# *** GET ***

	# Get all transactions for a specific account
	#tested - Returns an array of hashes.
	def self.getTransactionsByAccountId(accID)
		url = "#{self.urlWithEntity}/#{accID}/transactions?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	# Get a specific transaction
	# tested - Returns a hash with the specified transaction
	def self.getTransactionByAccountIdTransactionId(accID, tranID)
		url = "#{self.urlWithEntity}/#{accID}/transactions/#{tranID}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end


	# *** POST ***

	# Create a new transaction between 2 accounts
	def createTransaction(toAcc, json)
		url = "#{self.urlWithEntity}/#{toAcc}/transactions?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' => 'application/json'})
		request.body = json
		resp = http.request(request)
	end


	# *** DELETE ***

	def self.deleteTransaction(accID, transID)
		url = "#{self.urlWithEntity}/#{accID}/transactions/#{transID}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		resp = http.request(request)
	end
end