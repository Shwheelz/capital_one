require 'capital_one'

describe Config do

  it 'should have the correct base URL' do
    expect(Config.baseUrl).to eq("http://api.reimaginebanking.com:80")
  end

  it 'should set the api key' do
    Config.apiKey = "API_KEY"
    expect(Config.apiKey).to eq("API_KEY")
  end

  it 'should be able to change the api key' do
    Config.apiKey = "NEW_KEY"
    expect(Config.apiKey).to eq("NEW_KEY")
  end


end