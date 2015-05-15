require 'capital_one'

describe Transaction do
  
  before(:all) do
      $transactionPost = Hash.new
      $transactionPost["transaction_type"] = "cash"
      #$transactionPost["payee_id"] = ""
      $transactionPost["amount"] = 100
  end

  before(:each) do
    Config.apiKey = "fc6fe1207d2bb88d137db7e96f91b732"
  end

  describe 'Method' do
    it 'should get the correct base url' do
      expect(Transaction.url).to eq("http://api.reimaginebanking.com:80")
    end

    it 'should get the correct base url with entity' do
      expect(Transaction.urlWithEntity).to eq("http://api.reimaginebanking.com:80/accounts")
    end   

    it 'should have an API key' do
        expect(Transaction.apiKey.class).to be(String) # passes if actual == expected
      end
    end

    describe 'GET' do
      it 'Transactions for an account' do
        VCR.use_cassette 'Transactions/getTransactionsByAcctId' do
          accID = Account.getAll[0]["_id"]
          transaction = Transaction.getAllByAccountId(accID)
          expect(transaction.class).to eq(Array)
          expect(transaction.length).to be >= 0
        end
      end

      it 'Specific transaction for an account AND POST for transaction' do
        VCR.use_cassette 'Transactions/getSpecificTransaction' do
          payee_accID = Account.getAll[2]["_id"]
          $transactionPost["payee_id"] = payee_accID
          transactionPostJson = $transactionPost.to_json
          accID = Account.getAll[0]["_id"]

          trans = Transaction.createTransaction(accID, transactionPostJson)

          expect(trans.class).to eq(Hash)

          transID = Transaction.getAllByAccountId(accID)[0]["_id"]

          transaction = Transaction.getOneByAccountIdTransactionId(accID, transID)
          $globalTransID = transaction["_id"]
          expect(transaction.class).to eq(Hash)
          expect(transaction.length).to be > 0
        end
      end
    end

    describe 'DELETE' do
      it 'Transaction for an account' do
        VCR.use_cassette 'Transactions/deleteTransactionsByAcctId' do
          payee_accID = Account.getAll[2]["_id"]
          $transactionPost["payee_id"] = payee_accID
          transactionPostJson = $transactionPost.to_json
          accID = Account.getAll[0]["_id"]

          trans = Transaction.createTransaction(accID, transactionPostJson)

          expect(trans.class).to eq(Hash)

          transID = Transaction.getAllByAccountId(accID)[0]["_id"]

          transaction = Transaction.deleteTransaction(accID, transID)
          expect(transaction.class).to be(Net::HTTPNoContent)
            expect(transaction.code).to eq("204")         
        end
      end
    end
end