class Withdrawal

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

  #==getAllByAccountId
    # Get all withdrawals for a specific account
    #= Parameters: AccountID
    # Returns an array of hashes containing the withdrawals for that account.

  def self.getAllByAccountId(accID)
    url = "#{self.urlWithEntity}/#{accID}/withdrawals?key=#{self.apiKey}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)
  end

  #==getOne
    # Get a single withdrawal for a given ID
    #= Parameters: WithdrawalId
    # Returns a hash

  def self.getOne(id)
    url = "#{self.url}/withdrawals/#{id}?key=#{self.apiKey}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)
  end

  # *** POST ***

  #==createWithdrawal
    # Creates a new withdrawal
    #= Parameters: toAccountId, WithdrawalHash
    # WithdrawalHash formatted as follows: 
    # {
    #   "medium": "balance",
    #   "transaction_date": "string",
    #   "status": "pending",
    #   "amount": 0,
    #   "desciption": "string"
    # }
    # Returns http response code

  def self.createWithdrawal(toAcc, withdrawal)
    withdrawalToCreate = withdrawal.to_json
    url = "#{self.urlWithEntity}/#{toAcc}/withdrawals?key=#{self.apiKey}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' => 'application/json'})
    request.body = withdrawalToCreate
    resp = http.request(request)
    data = JSON.parse(resp.body)
  end

  # *** PUT ***

  #==updateWithdrawal
    # Updates an existing withdrawal
    #= Parameters: WithdrawalId, WithdrawalHash
    # WithdrawalHash formatted as follows: 
    # {
    #   "medium": "balance",
    #   "transaction_date": "string",
    #   "status": "pending",
    #   "amount": 0,
    #   "desciption": "string"
    # }
    # Returns http response code

  def self.updateWithdrawal(id, withdrawal)
    url = "#{self.url}/withdrawals/#{id}?key=#{self.apiKey}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    key = "?key=#{self.apiKey}"
    request = Net::HTTP::Put.new(uri.path+key, initheader = {'Content-Type' =>'application/json'})
    request.body = withdrawal.to_json
    response = http.request(request)
    return JSON.parse(response.body)
  end


  # *** DELETE ***

  #==deleteWithdrawal
    # Deletes a specified withdrawal from a specified account.
    # Parameters: WithdrawalID
    # Returns http response code.
    #= Note: This does not actually delete the withdrawal from the database, it only sets its status to 'cancelled'
  
  def self.deleteWithdrawal(id)
    url = "#{self.url}/withdrawals/#{id}?key=#{self.apiKey}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    key="?key=#{self.apiKey}"
    request = Net::HTTP::Delete.new(uri.path+key)
    resp = http.request(request)
  end
end