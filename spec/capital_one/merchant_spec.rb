require 'capital_one'

describe Merchant do 

	before(:all) do
		$merchantPost = Hash.new
		$merchantPost["name"] = "Test Name"
		$merchantPost["address"] = Hash.new

		# Edit merchantPost with an address that will return something
		$merchantPost["address"]["street_number"] = "8020"
  		$merchantPost["address"]["street_name"] = "Towers crescent dr"
  		$merchantPost["address"]["city"] = "Tysons Corner"
  		$merchantPost["address"]["state"] = "Virginia"
  		$merchantPost["address"]["zip"] = "22102"
  	$merchantPost["geocode"] = Hash.new
  		$merchantPost["geocode"]["lat"] = 0
  		$merchantPost["geocode"]["lng"] = 0

    $merchantPut = Hash.new
    $merchantPut["name"] = "Updated Test Name"
    
    Config.apiKey = "330681dbf73436832cafac4f11622452"
  end

  describe 'GET' do

    it 'should get all merchants' do
      VCR.use_cassette 'merchant/merchants' do
        merchants = Merchant.getAll
        expect(merchants.class).to be(Array)
        # expect(merchants.length).to be > 0
        # expect(merchants[0].class).to be(Hash)
      end
    end

    it 'should get all merchants within a certain location' do
      VCR.use_cassette 'merchant/merchantsByLocation' do
        merchants = Merchant.getAllByLocation(38.9047, -77.0164, 10)
        expect(merchants.class).to be(Array)
        expect(merchants.length).to be > 0
        expect(merchants[0].class).to be(Hash)
      end
    end

    it 'should get a single merchant' do
      VCR.use_cassette 'merchant/merchant' do
        merchant = Merchant.getOne(Merchant.getAll[0]["_id"])
        expect(merchant.class).to be(Hash)
        expect(merchant).to include("_id")
        expect(merchant).to include("name")
      end
    end

  end

  describe 'POST' do

    it 'should create a new merchant' do
      VCR.use_cassette 'merchant/createMerchant' do
        merchID = Merchant.getAll[0]["_id"]
        response = Merchant.createMerchant($merchantPost)
        expect(response.class).to be(Hash)
        expect(response).to include("message")
        expect(response).to include("code")
      end
    end
  end

  describe 'PUT' do
    it 'should update a merchant' do
      VCR.use_cassette 'merchant/updateMerchant' do
          merchID = Merchant.getAll[0]["_id"]
          response = Merchant.updateMerchant(merchID, $merchantPut)
          expect(response.class).to be(Hash)
          expect(response).to include("message")
          expect(response).to include("code")
      end
    end
  end
end
