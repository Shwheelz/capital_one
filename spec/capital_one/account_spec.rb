require 'capital_one'

describe Account do

  before(:all) do
    Config.apiKey = "3e07f628fb1c458d3c2959ec5d87b8dd"
  end

  describe 'Method' do
    it 'should get the correct base url' do
      expect(Account.url).to eq("http://api.reimaginebanking.com:80")
    end

    it 'should get the correct base url with entity' do
      expect(Account.urlWithEntity).to eq("http://api.reimaginebanking.com:80/accounts")
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
        customerID = Customer.getAll[0]["_id"]
        accounts = Account.getAllByCustomerId(customerID)
        expect(accounts.class).to be(Array)
        expect(accounts[0].class).to be(Hash)
        expect(accounts[0]).to include("_id")
        expect(accounts[0]).to include("nickname")
      end
    end
  end

  describe 'PUT' do
    it 'should update an existing account' do
      VCR.use_cassette 'account/updateAccount' do
        accountPut = {"nickname"=> "testPut"}
        accountID = Account.getAll[0]["_id"]
        response = Account.updateAccount(accountID, accountPut)
        expect(response.class).to be(Hash)
        expect(response).to include("message")
        expect(response).to include("code")
      end
    end
  end

  describe 'POST' do
    it 'should create a new account' do
      VCR.use_cassette 'account/createAccount' do

        accountPost = {
          "type"=> "Credit Card",
          "nickname"=> "testPost",
          "rewards"=> 100,
          "balance"=> 100
        }
        
        custID = Customer.getAll[0]["_id"]
        response = Account.createAccount(custID, accountPost)
        expect(response.class).to be(Hash)
        expect(response).to include("message")
        expect(response).to include("code")
      end
    end
  end

  describe 'DELETE' do
    it 'should delete an account' do
      VCR.use_cassette 'account/deleteAccount' do
        custID = Customer.getAll[0]["_id"]
        accountId = Account.getAllByCustomerId(custID)[0]["_id"]
        response = Account.deleteAccount(accountId)
        expect(response.class).to be(Net::HTTPNoContent)
        expect(response.code).to eq("204")
      end
    end
  end

end