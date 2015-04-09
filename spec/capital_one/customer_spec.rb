require 'capital_one'
require 'json'

describe Customer do

	before(:all) do
    	$accountPost = Hash.new
    	$accountPost["type"] = "Credit Card"
    	$accountPost["nickname"] = "test1"
    	$accountPost["rewards"] = 100
    	$accountPost["balance"] = 100

    	$customerPost = Hash.new
    	$customerPost["address"] = Hash.new
    	$customerPost["address"]["street_number"] = "8020"
    	$customerPost["address"]["street_name"] = "Towers crescent dr"
    	$customerPost["address"]["city"] = "Tysons Corner"
    	$customerPost["address"]["state"] = "Virginia"
    	$customerPost["address"]["zip"] = "22102"
  	end

	describe 'Method' do
		it 'should get the correct base url' do
			expect(Customer.url).to eq("http://api.reimaginebanking.com:80")
		end

		it 'should get the correct base url with entity' do
			expect(Customer.urlWithEntity).to eq("http://api.reimaginebanking.com:80/customers")
		end		

		it 'should get the correct base url with account entity' do
			expect(Customer.urlWithAcctEntity).to eq("http://api.reimaginebanking.com:80/accounts")
		end

		it 'should have an API key' do
      		expect(Customer.apiKey.class).to be(String) # passes if actual == expected
    	end
	end

	# describe 'POST' do
	# 	it 'create new account' do 
	# 		$custID = Customer.getCustomers[0]["_id"]
	# 		accountBody = $accountPost.to_json
	# 		response = Account.createAcct($custID, accountBody)
	# 		hash_response = JSON.parse(response.body)
	# 	end
	# end

	describe 'GET' do 
		it 'All customers' do
			#VCR.use_cassette 'customers' do
				allCustomers = Customer.getCustomers
				expect(allCustomers.class).to be(Array)
				expect(allCustomers.length).to be(3)
				expect(allCustomers[0].class).to be(Hash)
			#end
		end

		it 'Specific customers by customer ID' do
			#VCR.use_cassette 'customer' do
				$putCustID = Customer.getCustomers[0]["_id"]
				allCustomers = Customer.getCustomer(Customer.getCustomers[0]["_id"])
				expect(allCustomers.class).to be(Hash)
				expect(allCustomers).to include("_id")
				expect(allCustomers).to include("accounts")
				expect(allCustomers).to include("first_name")
			#end
		end

		# it 'Specific customers by account ID' do
		# 	VCR.use_cassette 'customer' do
		# 		allCustomers = Customer.getCustomerByAccountId(Customer.getCustomers[0]["_id"])
		# 		expect(allCustomers.class).to be(Hash)
		# 		expect(allCustomers).to include("_id")
		# 		expect(allCustomers).to include("accounts")
		# 		expect(allCustomers).to include("first_name")
		# 	end
		# end
	end 

	describe 'PUT' do
		it '- update customer information' do
			customerBody = $customerPost.to_json
			response = Customer.updateCustomer($putCustID, customerBody)
			hash_response = JSON.parse(response.body)
			expect(hash_response.class).to be(Hash)
			expect(hash_response).to include("message")
			expect(hash_response).to include("code")
		end
	end

end