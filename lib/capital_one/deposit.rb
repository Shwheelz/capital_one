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
  def self.getAllByAccountId(accID)
    url = "#{self.urlWithEntity}/#{accID}/deposits?key=#{self.apiKey}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)
    return data
  end

  def self.getOne(id)
    url = "#{self.url}/deposits/#{id}?key=#{self.apiKey}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body)
  end


  # *** POST ***
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
  def self.deleteDeposit(id)
    url = "#{self.url}/deposits/#{id}?key=#{self.apiKey}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    key="?key=#{self.apiKey}"
    request = Net::HTTP::Delete.new(uri.path+key)
    resp = http.request(request)
  end
end