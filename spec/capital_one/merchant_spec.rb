require 'capital_one'

describe Merchant do 

	before(:all) do
		$merchantPost = Hash.new
		$merchantPost["name"] = "Test Name"
    $merchantPost["category"] = ["Restaurants", "Bars"]
		$merchantPost["address"] = Hash.new

		# Edit merchantPost with an address that will return something
		$merchantPost["address"]["street_number"] = "8020"
  		$merchantPost["address"]["street_name"] = "Towers crescent dr"
  		$merchantPost["address"]["city"] = "Tysons Corner"
  		$merchantPost["address"]["state"] = "TX"
  		$merchantPost["address"]["zip"] = "75288"
  	$merchantPost["geocode"] = Hash.new
  		$merchantPost["geocode"]["lat"] = 0
  		$merchantPost["geocode"]["lng"] = 0

    $merchantPut = Hash.new
    $merchantPut["name"] = "Updated Test Name"
    
    Config.apiKey = "98a490a765c08c70d61dc3f89feea899"
  end

  describe 'POST' do

    it 'should create a new merchant' do
      VCR.use_cassette 'merchant/createMerchant' do
        response = Merchant.createMerchant($merchantPost)
        expect(response.class).to be(Hash)
        expect(response).to include("message")
        expect(response).to include("code")
      end
    end
  end

  describe 'GET' do

    it 'should get all merchants' do
      VCR.use_cassette 'merchant/merchants' do
        merchants = Merchant.getAll
        expect(merchants.class).to be(Hash)
      end
    end

    it 'should get all the Merchants by page' do
      VCR.use_cassette 'merchant/merchantsWithPage' do
        atms = Atm.getAllWithPage(2)
        expect(atms.class).to be(Hash)
        expect(atms.length).to be > 0
        expect(atms.first.class).to be(Array)
      end
    end

    it 'should get all merchants within a certain location' do
      VCR.use_cassette 'merchant/merchantsByLocation' do
        merchants = Merchant.getAllByLocation(39.904218, -75.169313, 10)
        expect(merchants.class).to be(Hash)
        expect(merchants["data"][0].keys).to include("_id")
        expect(merchants["data"][0].keys).to include("name")
        expect(merchants["data"][0].keys).to include("category")
        expect(merchants["data"][0].keys).to include("geocode")
        expect(merchants["data"][0].keys).to include("address")
      end
    end

    it 'should get a single merchant' do
      VCR.use_cassette 'merchant/merchant' do
        merchant = Merchant.getOne(Merchant.getAll["data"][0]["_id"])
        expect(merchant.class).to be(Hash)
        expect(merchant).to include("_id")
        expect(merchant).to include("name")
      end
    end

  end

  describe 'PUT' do
    it 'should update a merchant' do
      VCR.use_cassette 'merchant/updateMerchant' do
          merchID = Merchant.getAll["data"][0]["_id"]
          response = Merchant.updateMerchant(merchID, $merchantPut)
          expect(response.class).to be(Hash)
          expect(response).to include("message")
          expect(response).to include("code")
      end
    end
  end
end
