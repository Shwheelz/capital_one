class Loan
	def self.urlWithEntity
		return Config.baseUrl + "/loans"
	end

	def self.url
		return Config.baseUrl
	end

	def self.apiKey
		return Config.apiKey
	end

	def self.getLoansByAccountId(accountId)
		url = "#{self.url}/accounts/#{accountId}/loans?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	def self.getLoans(loanId)
		url = "#{self.urlWithEntity}/#{loanId}?key=#{self.apiKey}"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
	end

	def self.createLoan(accountId, loan)
		loanToCreate = loan.to_json
		url = "#{self.url}/accounts/#{accountId}/loans?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
		request.body = loanToCreate
		response = http.request(request)
		return JSON.parse(response.body)
	end

	def self.updateLoan(loanId, loan)
		loanToUpdate = account.to_json
		url = "#{self.urlWithEntity}/#{loanId}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key = "?key=#{self.apiKey}"
		request = Net::HTTP::Put.new(uri.path+key, initheader = {'Content-Type' =>'application/json'})
		request.body = loanToUpdate
		response = http.request(request)
		return JSON.parse(response.body)
	end

	def self.deleteLoan(loanId)
		url = "#{self.urlWithEntity}/#{loanId}?key=#{self.apiKey}"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		key="?key=#{self.apiKey}"
		request = Net::HTTP::Delete.new(uri.path+key)
		response = http.request(request)
	end
end