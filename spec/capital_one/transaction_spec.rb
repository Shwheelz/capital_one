require 'capital_one'

describe Transaction do
	
	before(:all) do
  		$transactionPost = Hash.new
	    $transactionPost["medium"] = "balance"
	    $transactionPost["payee_id"] = "" # sets this in the test
	    $transactionPost["amount"] = 100
      $transactionPost["description"] = "TEST TRANSACTION"
	end

	before(:each) do
		Config.apiKey = "3eab5d0a550c080eab8b72ccbcbde8f8"
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
  			VCR.use_cassette 'transactions/getTransactionsByAcctId' do
	  			accID = Account.getAll[0]["_id"]
	  			transaction = Transaction.getAllByAccountId(accID)
	  			expect(transaction.class).to eq(Array)
	  			expect(transaction.length).to be >= 0
	  		end
  		end

      it 'Transactions for an account as payer' do
        VCR.use_cassette 'transactions/getTransactionsByAcctIdPayer' do
          accID = Account.getAll[0]["_id"]
          transaction = Transaction.getAllByAccountIdPayer(accID)
          expect(transaction.class).to eq(Array)
          expect(transaction.length).to be >= 0
        end
      end

      it 'Transactions for an account as payee' do
        VCR.use_cassette 'transactions/getTransactionsByAcctIdPayee' do
          accID = Account.getAll[0]["_id"]
          transaction = Transaction.getAllByAccountIdPayee(accID)
          expect(transaction.class).to eq(Array)
          expect(transaction.length).to be >= 0
        end
      end

  		it 'Specific transaction for an account AND POST for transaction' do
  			VCR.use_cassette 'transactions/getSpecificTransaction' do
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

    describe 'POST' do
      it 'should create a Transaction' do
        VCR.use_cassette 'transactions/createTransaction' do
          response = Transaction.createTransaction($accountId, $transactionPost)
          expect(response.class).to be(Hash)
          expect(response).to include("message")
          expect(response).to include("code")
        end
      end
    end

  	describe 'DELETE' do
  		it 'Transaction for an account' do
  			VCR.use_cassette 'transactions/deleteTransactionsByAcctId' do
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