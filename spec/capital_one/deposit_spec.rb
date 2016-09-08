require 'capital_one'

describe Deposit do
  
  before(:all) do
      $depositPost = Hash.new
      $depositPost["medium"] = "balance"
      $depositPost["amount"] = 100
      $depositPost["description"] = "TEST DEPOSIT"

      $depositPut = Hash.new
      $depositPut["description"] = "Updated test desc"
  end

  before(:each) do
    Config.apiKey = "98a490a765c08c70d61dc3f89feea899"
  end

  describe 'Method' do
    it 'should get the correct base url' do
      expect(Deposit.url).to eq("http://api.reimaginebanking.com:80")
    end

    it 'should get the correct base url with entity' do
      expect(Deposit.urlWithEntity).to eq("http://api.reimaginebanking.com:80/accounts")
    end   

    it 'should have an API key' do
        expect(Deposit.apiKey.class).to be(String) # passes if actual == expected
      end
    end

  describe 'POST' do
    it 'should create a new deposit' do
      VCR.use_cassette 'deposit/createDeposit' do
        accID = Account.getAll[0]["_id"]
        deposit = Deposit.createDeposit(accID, $depositPost)
        expect(deposit.class).to eq(Hash)
        expect(deposit).to include("message")
        expect(deposit).to include("code")
      end
    end
  end

    describe 'GET' do
      it 'should get all deposits by account id' do
        VCR.use_cassette 'deposit/getDepositByAcctId' do
          accID = Account.getAll[0]["_id"]
          deposit = Deposit.getAllByAccountId(accID)
          expect(deposit.class).to eq(Array)
          expect(deposit.length).to be >= 0
        end
      end

      it 'should get one deposit' do
        VCR.use_cassette 'deposit/deposit' do
          accID = Account.getAll[0]["_id"]
          depositId = Deposit.getAllByAccountId(accID)[0]["_id"]
          deposit = Deposit.getOne(depositId)
          expect(deposit.class).to eq(Hash)
          expect(deposit).to include("_id")
          expect(deposit).to include("type")
        end
      end
    end

    describe 'PUT' do
      it 'should update an existing deposit' do
        VCR.use_cassette 'deposit/updateDeposit' do
          accountID = Account.getAll[0]["_id"]
          depositID = Deposit.getAllByAccountId(accountID)[0]["_id"]
          response = Deposit.updateDeposit(depositID, $depositPut)
          expect(response.class).to be(Hash)
          expect(response).to include("message")
          expect(response).to include("code")
        end
      end
    end

    describe 'DELETE' do
      it 'Deposit for an account' do
        VCR.use_cassette 'deposit/deleteDepositByAcctId' do
          accID = Account.getAll[0]["_id"]
          deposit = Deposit.createDeposit(accID, $depositPost)
          expect(deposit.class).to eq(Hash)
          depositID = Deposit.getAllByAccountId(accID).last["_id"]
          deposit = Deposit.deleteDeposit(depositID)
          expect(deposit.class).to be(Net::HTTPNoContent)
          expect(deposit.code).to eq("204")         
        end
      end
    end
end