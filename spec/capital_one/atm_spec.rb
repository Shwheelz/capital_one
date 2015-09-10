require 'capital_one'

describe Atm do

  before(:all) do
    Config.apiKey = "ff1fbfb0f1bfaefb769e25299805ddf1"
  end

  describe 'Method' do

    it 'should get the correct base url' do
      expect(Atm.url).to eq("http://api.reimaginebanking.com:80")
    end

    it 'should get the correct base url with entity' do
      expect(Atm.urlWithEntity).to eq("http://api.reimaginebanking.com:80/atms")
    end

    it 'should have an API key' do
      expect(Atm.apiKey.class).to be(String) # passes if actual == expected
    end

  end

  describe 'GET' do
    it 'should get all ATMS' do
      VCR.use_cassette 'atm/atms' do
        atms = Atm.getAll
        expect(atms.class).to be(Hash)
        expect(atms.length).to be > 0
        expect(atms.first.class).to be(Array)
      end
    end

    it 'should get all ATMs within a certain location' do
      VCR.use_cassette 'atm/atmsByLocation' do
        atms = Atm.getAllByLocation(38.9047, -77.0164, 10)
        expect(atms.class).to be(Hash)
        expect(atms.length).to be > 0
        expect(atms.first.class).to be(Array)
      end
    end

    it 'should get a single ATM' do
      VCR.use_cassette 'atm/atm' do
        atm = Atm.getOne(Atm.getAll["data"][0]["_id"])
        expect(atm.class).to be(Hash)
        expect(atm).to include("_id")
        expect(atm).to include("name")
      end
    end
  end

end