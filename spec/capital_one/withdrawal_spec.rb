require 'capital_one'

describe Withdrawal do
  
  before(:all) do
      $withdrawalPost = Hash.new
      $withdrawalPost["medium"] = "balance"
      $withdrawalPost["amount"] = 100
      $withdrawalPost["description"] = "TEST WITHDRAWAL"
  end

  before(:each) do
    Config.apiKey = "fc6fe1207d2bb88d137db7e96f91b732"
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
          withdrawalPostJson = $withdrawalPost.to_json
          accID = Account.getAll[0]["_id"]

          withdrawal = Withdrawal.createWithdrawal(accID, withdrawalPostJson)

          expect(withdrawal.class).to eq(Hash)

          withdrawalID = Withdrawal.getAllByAccountId(accID)[0]["_id"]

          withdrawal = Withdrawal.getOneByAccountIdWithdrawalId(accID, withdrawalID)
          $globalTransID = withdrawal["_id"]
          expect(withdrawal.class).to eq(Hash)
          expect(withdrawal.length).to be > 0
        end
      end
    end

    describe 'DELETE' do
      it 'Withdrawal for an account' do
        VCR.use_cassette 'withdrawal/deleteWithdrawalByAcctId' do
          withdrawalPostJson = $withdrawalPost.to_json
          accID = Account.getAll[0]["_id"]

          withdrawal = Withdrawal.createWithdrawal(accID, withdrawalPostJson)

          expect(withdrawal.class).to eq(Hash)

          withdrawalID = Withdrawal.getAllByAccountId(accID)[0]["_id"]

          withdrawal = Withdrawal.deleteWithdrawal(accID, withdrawalID)

          expect(withdrawal.class).to be(Net::HTTPNoContent)
          expect(withdrawal.code).to eq("204")         
        end
      end
    end
end