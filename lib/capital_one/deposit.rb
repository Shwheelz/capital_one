class Deposit

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
    # Get all deposits for a specific account
    #= Parameters: AccountID
    # Returns an array of hashes containing the deposits for that account.

  def self.getAllByAccountId(accID)
    url = "#{self.urlWithEntity}/#{accID}/deposits?key=#{self.apiKey}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)
    return data
  end


  #==getOne
    # Returns a deposit for a given ID
    #= Parameters: DepositId
    # Returns a hash with the deposit data
  def self.getOne(id)
    url = "#{self.url}/deposits/#{id}?key=#{self.apiKey}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)
  end


  # *** POST ***

  #==createDeposit
    # Creates a new deposit.
    # Parameters: toAccountId, DepositHash
    # DepositHash is formatted as follows: 
    # {
    #   "medium": "balance",
    #   "transaction_date": "string",
    #   "status": "pending",
    #   "amount": 0,
    #   "description": "string"
    # }
    # Returns http response code. 

  def self.createDeposit(toAcc, deposit)
    depositToCreate = deposit.to_json
    url = "#{self.urlWithEntity}/#{toAcc}/deposits?key=#{self.apiKey}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' => 'application/json'})
    request.body = depositToCreate
    resp = http.request(request)
    data = JSON.parse(resp.body)
  end


  # *** PUT ***

  #==updateDeposit
    # Updates an existing deposit
    #= Parameters: DepositId, DepositHash
    # DepositHash is formatted as follows: 
    # {
    #   "medium": "balance",
    #   "transaction_date": "string",
    #   "status": "pending",
    #   "amount": 0,
    #   "description": "string"
    # }
    # Returns http response code

  def self.updateDeposit(id, deposit)
    url = "#{self.url}/deposits/#{id}?key=#{self.apiKey}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    key = "?key=#{self.apiKey}"
    request = Net::HTTP::Put.new(uri.path+key, initheader = {'Content-Type' =>'application/json'})
    request.body = deposit.to_json
    response = http.request(request)
    return JSON.parse(response.body)
  end

  # *** DELETE ***

  #==deleteDeposit
    # Deletes an existing deposit
    #= Parameters: DepositId
    # Returns http response code

  def self.deleteDeposit(id)
    url = "#{self.url}/deposits/#{id}?key=#{self.apiKey}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    key="?key=#{self.apiKey}"
    request = Net::HTTP::Delete.new(uri.path+key)
    resp = http.request(request)
  end
end