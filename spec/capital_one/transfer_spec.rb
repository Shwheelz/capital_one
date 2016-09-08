require 'capital_one'

describe Transfer do
	
	before(:all) do
		$transferPost = Hash.new
		$transferPost["medium"] = "balance"
		$transferPost["amount"] = 20
    $transferPost["transaction_date"] = "2016-09-08"
		$transferPost["description"] = "test transfer"

		$transferPut = Hash.new
		$transferPut["description"] = "updated transfer"

		Config.apiKey = '98a490a765c08c70d61dc3f89feea899'
	end

	describe 'Method' do
	    it 'should get the correct base url' do
	      expect(Transfer.url).to eq("http://api.reimaginebanking.com:80")
	    end

	    it 'should get the correct base url with entity' do
	      expect(Transfer.urlWithEntity).to eq("http://api.reimaginebanking.com:80/accounts")
	    end

	    it 'should have an API key' do
	      expect(Transfer.apiKey.class).to be(String) # passes if actual == expected
	    end
    end

	describe 'POST' do
		it 'should create a new transfer' do
			VCR.use_cassette 'transfer/createTransfer' do
				p accID = Account.getAll()[0]["_id"]
        p $transferPost["payee_id"] = Account.getAll()[1]["_id"]
				transfer = Transfer.createTransfer(accID, $transferPost)
				expect(transfer.class).to be(Hash)
				expect(transfer).to include("message")
				expect(transfer).to include("code")
			end
		end
	end

	describe 'GET' do
		it 'should get all transfers for an account' do
			VCR.use_cassette 'transfer/transfers' do
				p accID = Account.getAll()[0]["_id"]
				transfers = Transfer.getAll(accID)
				expect(transfers.class).to be(Array)
				expect(transfers.length).to be > 0
				expect(transfers[0].class).to be(Hash)
			end
		end

		it 'should get all transfers of one type for an account' do
			VCR.use_cassette 'transfer/transferByType' do
				accID = Account.getAll()[0]["_id"]
				type = "payer"
				transfers = Transfer.getAllByType(accID, type)
				expect(transfers.class).to be(Array)
				expect(transfers.length).to be > 0
				expect(transfers[0].class).to be(Hash)
			end
		end

		it 'should get one transfer' do
			VCR.use_cassette 'transfer/transfer' do
				accID = Account.getAll()[0]["_id"]
				transferID = Transfer.getAll(accID)[0]["_id"]
				transfer = Transfer.getOne(transferID)
				expect(transfer.class).to be(Hash)
				expect(transfer).to include("_id")
				expect(transfer).to include("type")
			end
		end
	end
	describe 'PUT' do
		it 'should update an existing transfer' do
			VCR.use_cassette 'transfer/updateTransfer' do
		        accID = Account.getAll()[0]["_id"]
		        transferID = Transfer.getAll(accID)[0]["_id"]
		        response = Transfer.updateTransfer(transferID, $transferPut)
		        expect(response.class).to be(Hash)
		        expect(response).to include("message")
		        expect(response).to include("code")
			end
		end
	end

	describe 'DELETE' do
		it 'should delete a transfer' do
			VCR.use_cassette 'transfer/deleteTransfer' do
		        accID = Account.getAll()[0]["_id"]
		        $transferPost["payee_id"] = Account.getAll()[1]["_id"]
		        transfer = Transfer.createTransfer(accID, $transferPost)
		        transferID = Transfer.getAll(accID).last["_id"]
		        response = Transfer.deleteTransfer(transferID)
		        expect(response.class).to be(Net::HTTPNoContent)
		        expect(response.code).to eq("204")
			end
		end
	end
end