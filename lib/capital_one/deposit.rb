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
  #Get all deposits for a specific account
  #Returns an array of hashes.
  #Parameters: AccountID
  #Returns an array of hashes containing the deposits for that account.
  def self.getAllByAccountId(accID)
    url = "#{self.urlWithEntity}/#{accID}/deposits?key=#{self.apiKey}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)
    return data
  end

  #==getOneByAccountIdDepositId
  # Get a specific deposit from a specific account.
  #Parameters: AccountID, DepositID
  # Returns a hash with the specified deposit
  
  def self.getOneByAccountIdDepositId(accID, depositID)
    url = "#{self.urlWithEntity}/#{accID}/deposits/#{depositID}?key=#{self.apiKey}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)
  end


  # *** POST ***

  # Create a new deposit into an account
  #==createDeposit
  #Creates a new deposit.
  #Parameters: toAccountId, hashWithDepositData
  #Returns http response code. 
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


  # *** DELETE ***

  #==deleteDeposit
  #Deletes a specified deposit from a specified account.
  #Parameters: accountID, depositID
  #Returns http response code.
  #=Note:
  #This does not actually delete the deposit from the database, it only sets it's
  #status to 'cancelled'
  def self.deleteDeposit(accID, depositID)
    url = "#{self.urlWithEntity}/#{accID}/deposits/#{depositID}?key=#{self.apiKey}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    key="?key=#{self.apiKey}"
    request = Net::HTTP::Delete.new(uri.path+key)
    resp = http.request(request)
  end
end