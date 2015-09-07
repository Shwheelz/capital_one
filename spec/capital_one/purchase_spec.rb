require 'capital_one'

describe Purchase do

	before(:all) do
		$purchasePost = Hash.new
		$purchasePost["purchase_date"] = "2015-09-05"
		$purchasePost["amount"] = 5
		$purchasePost["status"] = "pending"
		$purchasePost["description"] = "test purchase"

		$purchasePut = Hash.new
		$purchasePut["description"] = "updated test desc"

    Config.apiKey = "330681dbf73436832cafac4f11622452"
	end

	describe 'Method' do
	    it 'should get the correct base url' do
	      expect(Purchase.url).to eq("http://api.nessiebanking.com:80")
	    end

	    it 'should get the correct base url with entity' do
	      expect(Purchase.urlWithEntity).to eq("http://api.nessiebanking.com:80/accounts")
	    end

	    it 'should have an API key' do
	      expect(Purchase.apiKey.class).to be(String) # passes if actual == expected
	    end
  	end

  	describe 'GET' do
  		it 'should get all purchases for an account' do
  			VCR.use_cassette 'purchase/purchases' do
  				accID = Account.getAll()[0]["_id"]
  				purchases = Purchase.getAll(accID)
  				expect(purchases.class).to be(Array)
  				expect(purchases.length).to be > 0
  				expect(purchases[0].class).to be(Hash)
  			end
  		end

  		it 'should get one purchase' do
  			VCR.use_cassette 'purchase/purchase' do
  				accID = Account.getAll()[0]["_id"]
  				purchase = Purchase.getAll(accID)[0]
  				expect(purchase.class).to be(Hash)
  				expect(purchase).to include("_id")
  				expect(purchase).to include("type")
  			end
  		end
  	end

  	describe 'POST' do
  		it 'should create a new purchase' do
  			VCR.use_cassette 'purchase/createPurchase' do
  				accID = Account.getAll()[0]["_id"]
          $purchasePost["merchant_id"] = Merchant.getAll[0]["_id"]
  				response = Purchase.createPurchase(accID, $purchasePost)
  				expect(response.class).to be(Hash)
        	expect(response).to include("message")
        	expect(response).to include("code")
  			end
  		end
  	end

  	describe 'PUT' do
  		it 'should update an existing purchase' do
  			VCR.use_cassette 'purchase/updatePurchase' do
   				accID = Account.getAll()[0]["_id"]
   				purchaseID = Purchase.getAll(accID)[0]["_id"]
   				response = Purchase.updatePurchase(purchaseID, $purchasePut)
   				expect(response.class).to be(Hash)
          expect(response).to include("message")
          expect(response).to include("code")
  			end
  		end
  	end

  	describe 'DELETE' do
  		it 'should delete a purchase' do
  			VCR.use_cassette 'purchase/deletePurchase' do
  				accID = Account.getAll()[0]["_id"]
   				purchaseID = Purchase.getAll(accID)[0]["_id"]
   				response = Purchase.deletePurchase(purchaseID)
   				expect(response.class).to be(Net::HTTPNoContent)
       		expect(response.code).to eq("204")
  			end
  		end
  	end

end