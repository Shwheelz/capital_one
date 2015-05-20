require 'capital_one'

describe Atm do

  before(:all) do
    Config.apiKey = "3eab5d0a550c080eab8b72ccbcbde8f8"
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
        expect(atms.class).to be(Array)
        expect(atms.length).to be > 0
        expect(atms[0].class).to be(Hash)
      end
    end

    it 'should get all ATMs withing a certain location' do
      VCR.use_cassette 'atm/atmsByLocation' do
        atms = Atm.getAllByLocation(38.9047, -77.0164, 10)
        expect(atms.class).to be(Array)
        expect(atms.length).to be > 0
        expect(atms[0].class).to be(Hash)
      end
    end

    it 'should get a single ATM' do
      VCR.use_cassette 'atm/atm' do
        atm = Atm.getOne(Atm.getAll[0]["_id"])
        expect(atm.class).to be(Hash)
        expect(atm).to include("_id")
        expect(atm).to include("name")
      end
    end
  end

end