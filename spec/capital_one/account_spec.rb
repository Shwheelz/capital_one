require 'capital_one'

describe Account do

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
      VCR.use_cassette 'accounts' do
        accounts = Account.getAll
        expect(accounts.class).to be(Array)
        expect(accounts.length).to be > 0
        expect(accounts[0].class).to be(Hash)
      end
    end

    it 'should get all Accounts with a Credit Card type' do
      VCR.use_cassette 'accountsByType' do
        accounts = Account.getAllByType("Credit Card")
        expect(accounts.class).to be(Array)
        expect(accounts.length).to be > 0
        expect(accounts[0].class).to be(Hash)
        expect(accounts[0]).to include("type" => "Credit Card")
      end
    end

    it 'should get a single Account' do
      VCR.use_cassette 'account' do
        account = Account.getOne(Account.getAll[0]["_id"])
        expect(account.class).to be(Hash)
        expect(account).to include("_id")
        expect(account).to include("nickname")
      end
    end
  end

end