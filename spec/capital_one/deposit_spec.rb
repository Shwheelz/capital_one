require 'capital_one'

describe Deposit do
  
  before(:all) do
      $depositPost = Hash.new
      $depositPost["medium"] = "balance"
      $depositPost["amount"] = 100
      $depositPost["description"] = "TEST DEPOSIT"
  end

  before(:each) do
    Config.apiKey = "3eab5d0a550c080eab8b72ccbcbde8f8"
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

    describe 'GET' do
      it 'Deposit for an account' do
        VCR.use_cassette 'deposit/getDepositByAcctId' do
          accID = Account.getAll[0]["_id"]
          deposit = Deposit.getAllByAccountId(accID)
          expect(deposit.class).to eq(Array)
          expect(deposit.length).to be >= 0
        end
      end

      it 'Specific deposit for an account AND POST for deposit' do
        VCR.use_cassette 'deposit/getSpecificDeposit' do
          accID = Account.getAll[0]["_id"]

          deposit = Deposit.createDeposit(accID, $depositPost)

          expect(deposit.class).to eq(Hash)

          depositID = Deposit.getAllByAccountId(accID)[0]["_id"]

          deposit = Deposit.getOneByAccountIdDepositId(accID, depositID)
          $globalTransID = deposit["_id"]
          expect(deposit.class).to eq(Hash)
          expect(deposit.length).to be > 0
        end
      end
    end

    describe 'DELETE' do
      it 'Deposit for an account' do
        VCR.use_cassette 'deposit/deleteDepositByAcctId' do
          accID = Account.getAll[0]["_id"]
          deposit = Deposit.createDeposit(accID, $depositPost)
          expect(deposit.class).to eq(Hash)

          # Error Check
          puts "accID: " + accID 
          puts "$depositPost: " + $depositPost.to_s
          puts "deposit: " + deposit.to_s

          depositID = Deposit.getAllByAccountId(accID)[0]["_id"]
          deposit = Deposit.deleteDeposit(accID, depositID)

          # Error check
          puts "depositID: " + depositID
          puts "deposit: " + deposit.to_s

          expect(deposit.class).to be(Net::HTTPNoContent)
          expect(deposit.code).to eq("204")         
        end
      end
    end
end