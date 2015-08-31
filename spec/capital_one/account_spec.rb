require 'capital_one'

describe Account do

  before(:all) do
    $accountPost = Hash.new
    $accountPost["type"] = "Credit Card"
    $accountPost["nickname"] = "test1"
    $accountPost["rewards"] = 100
    $accountPost["balance"] = 100

    $accountPut = Hash.new
    $accountPut["nickname"] = "test1"

    $accountId = "";

    Config.apiKey = "d481ae7211ed5a78cb18855ca7d40e4f"
  end

  describe 'Method' do

    it 'should get the correct base url' do
      expect(Account.url).to eq("http://api.nessiebanking.com:80")
    end

    it 'should get the correct base url with entity' do
      expect(Account.urlWithEntity).to eq("http://api.nessiebanking.com:80/accounts")
    end

    it 'should have an API key' do
      expect(Account.apiKey.class).to be(String) # passes if actual == expected
    end

  end

  describe 'GET' do
    it 'should get all Accounts' do
      VCR.use_cassette 'account/accounts' do
        accounts = Account.getAll
        expect(accounts.class).to be(Array)
        expect(accounts.length).to be > 0
        expect(accounts[0].class).to be(Hash)
      end
    end

    it 'should get all Accounts with a Credit Card type' do
      VCR.use_cassette 'account/accountsByType' do
        accounts = Account.getAllByType("Credit%20Card")
        expect(accounts.class).to be(Array)
        expect(accounts.length).to be > 0
        expect(accounts[0].class).to be(Hash)
        expect(accounts[0]).to include("type" => "Credit Card")
      end
    end

    it 'should get a single Account' do
      VCR.use_cassette 'account/account' do
        account = Account.getOne(Account.getAll[0]["_id"])
        expect(account.class).to be(Hash)
        expect(account).to include("_id")
        expect(account).to include("nickname")
      end
    end

    it 'should get all accounts for a customer' do
      VCR.use_cassette 'account/accountsByCustomerId' do
        customerId = "";
        customers = Customer.getAll
        customers.each do |customer|
          if customer["account_ids"].length > 0 #find a customer with an account
            customerId = customer["_id"]
            break
          end
        end

        accounts = Account.getAllByCustomerId(customerId)
        expect(accounts.class).to be(Array)
        expect(accounts[0].class).to be(Hash)
        expect(accounts[0]).to include("_id")
        expect(accounts[0]).to include("nickname")
        expect(accounts[0]).to include("customer_id" => "#{customerId}")
      end
    end
  end

  describe 'PUT' do
    it 'should update an existing account' do
      VCR.use_cassette 'account/updateAccount' do
        # get an account we have permission to update
        customers = Customer.getAll
        customers.each do |customer|
          if customer["account_ids"].length > 0 #find a customer with an account
            $accountId = customer["account_ids"][0]
            break
          end
        end

        # update the account
        if $accountId != ""
          response = Account.updateAccount($accountId, $accountPut)
          expect(response.class).to be(Hash)
          expect(response).to include("message")
          expect(response).to include("code")
        end
      end
    end
  end

  describe 'POST' do
    it 'should create a new account' do
      VCR.use_cassette 'account/createAccount' do
        custID = Customer.getAll[0]["_id"]
        response = Account.createAccount(custID, $accountPost)
        expect(response.class).to be(Hash)
        expect(response).to include("message")
        expect(response).to include("code")
      end
    end
  end

  describe 'DELETE' do
    it 'should delete an account' do
      VCR.use_cassette 'account/deleteAccount' do
        response = Account.deleteAccount($accountId)
        expect(response.class).to be(Net::HTTPNoContent)
        expect(response.code).to eq("204")
      end
    end
  end

end