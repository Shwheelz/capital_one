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
  #Get all withdrawals for a specific account
  #Returns an array of hashes.
  #Parameters: AccountID
  #Returns an array of hashes containing the withdrawals for that account.
  def self.getAllByAccountId(accID)
    url = "#{self.urlWithEntity}/#{accID}/withdrawals?key=#{self.apiKey}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)
    return data
  end

  #==getOneByAccountIdWithdrawalId
  # Get a specific withdrawal from a specific account.
  #Parameters: accountID, withdrawalID
  # Returns a hash with the specified withdrawal
  
  def self.getOneByAccountIdWithdrawalId(accID, withdrawalID)
    url = "#{self.urlWithEntity}/#{accID}/withdrawals/#{withdrawalID}?key=#{self.apiKey}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)
  end


  # *** POST ***

  # Create a new withdrawal into an account
  #==createWithdrawal
  #Creates a new withdrawal.
  #Parameters: toAccountId, hashWithWithdrawalData
  #Returns http response code. 
  def self.createWithdrawal(toAcc, json)
    url = "#{self.urlWithEntity}/#{toAcc}/withdrawals?key=#{self.apiKey}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' => 'application/json'})
    request.body = json
    resp = http.request(request)
    data = JSON.parse(resp.body)
  end


  # *** DELETE ***

  #==deleteWithdrawal
  #Deletes a specified withdrawal from a specified account.
  #Parameters: accountID, withdrawalID
  #Returns http response code.
  #=Note:
  #This does not actually delete the withdrawal from the database, it only sets it's
  #status to 'cancelled'
  def self.deleteWithdrawal(accID, withdrawalID)
    url = "#{self.urlWithEntity}/#{accID}/withdrawals/#{withdrawalID}?key=#{self.apiKey}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    key="?key=#{self.apiKey}"
    request = Net::HTTP::Delete.new(uri.path+key)
    resp = http.request(request)
  end
end