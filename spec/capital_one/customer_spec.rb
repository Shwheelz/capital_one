require 'capital_one'

describe Customer do

	before(:all) do
	  	$customerPost = Hash.new
	  	$customerPost["address"] = Hash.new
	  	$customerPost["address"]["street_number"] = "8020"
	  	$customerPost["address"]["street_name"] = "Towers crescent dr"
	  	$customerPost["address"]["city"] = "Tysons Corner"
	  	$customerPost["address"]["state"] = "Virginia"
	  	$customerPost["address"]["zip"] = "22102"

	  	$customerPut = Hash.new
	  	$customerPut["address"] = Hash.new
	  	$customerPut["address"]["street_name"] = "New test street"
	end

	before(:each) do
		Config.apiKey = "330681dbf73436832cafac4f11622452"
	end

	describe 'Method' do
		it 'should get the correct base url' do
			expect(Customer.url).to eq("http://api.nessiebanking.com:80")
		end

		it 'should get the correct base url with entity' do
			expect(Customer.urlWithEntity).to eq("http://api.nessiebanking.com:80/customers")
		end		

		it 'should get the correct base url with account entity' do
			expect(Customer.urlWithAcctEntity).to eq("http://api.nessiebanking.com:80/accounts")
		end

		it 'should have an API key' do
    		expect(Customer.apiKey.class).to be(String) # passes if actual == expected
  	end
	end

	describe 'GET' do 
		it 'All customers' do
			VCR.use_cassette 'customer/customers' do
				allCustomers = Customer.getAll
				expect(allCustomers.class).to be(Array)
				expect(allCustomers.length).to be(3)
				expect(allCustomers[0].class).to be(Hash)
			end
		end

		it 'Specific customers by customer ID' do
			VCR.use_cassette 'customer/customer' do
				putCustID = Customer.getAll[0]["_id"]
				customer = Customer.getOne(putCustID)
				expect(customer.class).to be(Hash)
				expect(customer).to include("_id")
				expect(customer).to include("first_name")
			end
		end

		it 'Specific customer by account ID' do
			VCR.use_cassette 'customer/customerByAccountId' do
				accountId = Account.getAll[0]["_id"]
				customer = Customer.getOneByAccountId(accountId)
				expect(customer.class).to be(Hash)
				expect(customer).to include("_id")
				expect(customer).to include("first_name")
			end
		end
	end 

	describe 'POST' do
		it 'should create a new customer' do
			VCR.use_cassette 'customer/newCustomer' do
				response = Customer.createCustomer($customerPost)
				expect(response.class).to be(Hash)
				expect(response).to include("message")
				expect(response).to include("code")
			end
		end
	end

	describe 'PUT' do
		it 'Update customer information' do
			VCR.use_cassette 'customer/updateCustomer' do
				putCustID = Customer.getAll[0]["_id"]
				response = Customer.updateCustomer(putCustID, $customerPut)
				expect(response.class).to be(Hash)
				expect(response).to include("message")
				expect(response).to include("code")
			end
		end
	end

end