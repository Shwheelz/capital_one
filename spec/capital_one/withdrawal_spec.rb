require 'capital_one'

describe Withdrawal do
  
  before(:all) do
      $withdrawalPost = Hash.new
      $withdrawalPost["medium"] = "balance"
      $withdrawalPost["amount"] = 100
      $withdrawalPost["description"] = "TEST WITHDRAWAL"

      $withdrawalPut = Hash.new
      $withdrawalPut["description"] = "TEST UPDATE"
  end

  before(:each) do
    Config.apiKey = "98a490a765c08c70d61dc3f89feea899"
  end

  describe 'Method' do
    it 'should get the correct base url' do
      expect(Withdrawal.url).to eq("http://api.reimaginebanking.com:80")
    end

    it 'should get the correct base url with entity' do
      expect(Withdrawal.urlWithEntity).to eq("http://api.reimaginebanking.com:80/accounts")
    end   

    it 'should have an API key' do
        expect(Withdrawal.apiKey.class).to be(String) # passes if actual == expected
      end
    end

    describe 'GET' do
      it 'Withdrawal for an account' do
        VCR.use_cassette 'withdrawal/getWithdrawalByAcctId' do
          accID = Account.getAll[0]["_id"]
          withdrawal = Withdrawal.getAllByAccountId(accID)
          expect(withdrawal.class).to eq(Array)
          expect(withdrawal.length).to be >= 0
        end
      end

      it 'Specific withdrawal for an account AND POST for withdrawal' do
        VCR.use_cassette 'withdrawal/getSpecificWithdrawal' do
          accID = Account.getAll[0]["_id"]
          withdrawal = Withdrawal.createWithdrawal(accID, $withdrawalPost)
          expect(withdrawal.class).to eq(Hash)
          withdrawalID = Withdrawal.getAllByAccountId(accID)[0]["_id"]
          withdrawal = Withdrawal.getOne(withdrawalID)
          $globalTransID = withdrawal["_id"]
          expect(withdrawal.class).to eq(Hash)
          expect(withdrawal.length).to be > 0
        end
      end
    end

    describe 'POST' do
      it 'should create a new withdrawal' do
        VCR.use_cassette 'withdrawal/createWithdrawal' do
          accID = Account.getAll[0]["_id"]
          withdrawal = Withdrawal.createWithdrawal(accID, $withdrawalPost)
          expect(withdrawal.class).to eq(Hash)
          expect(withdrawal).to include("message")
          expect(withdrawal).to include("code")
        end
      end
    end 

    describe 'PUT' do
      it 'should update a withdrawal' do 
        VCR.use_cassette 'withdrawal/updateWithdrawal' do
          accID = Account.getAll[0]["_id"]
          withdrawalID = Withdrawal.getAllByAccountId(accID)[0]["_id"]
          response = Withdrawal.updateWithdrawal(withdrawalID, $withdrawalPut)
          expect(response.class).to eq(Hash)
          expect(response).to include("message")
          expect(response).to include("code")
        end
      end
    end

    describe 'DELETE' do
      it 'Withdrawal for an account' do
        VCR.use_cassette 'withdrawal/deleteWithdrawalByAcctId' do
          accID = Account.getAll[0]["_id"]
          withdrawalID = Withdrawal.getAllByAccountId(accID).last["_id"]
          withdrawal = Withdrawal.deleteWithdrawal(withdrawalID)
          expect(withdrawal.class).to be(Net::HTTPNoContent)
          expect(withdrawal.code).to eq("204")         
        end
      end
    end
end