require 'capital_one'

describe Bill do

  before(:all) do
    $billPost = Hash.new
    $billPost["status"] = "pending"
    $billPost["payment_date"] = "2015-04-20"
    $billPost["recurring_date"] = 15
    $billPost["payment_amount"] = 100

    Config.apiKey = "fc6fe1207d2bb88d137db7e96f91b732"
    
    $accountId = ""
    VCR.use_cassette 'bill/testCreateBill' do
      account = Account.getAll[0]
      $accountId = account["_id"]
      $customerId = account["customer"]
      response = Bill.createBill($accountId, $billPost)

      $billId = Bill.getAllByAccountId($accountId)[0]["_id"]
    end
  end

  describe 'Method' do

    it 'should get the correct base url' do
      expect(Bill.url).to eq("http://api.reimaginebanking.com:80")
    end

    it 'should get the correct account base url with entity ' do
      expect(Bill.accountBaseUrl).to eq("http://api.reimaginebanking.com:80/accounts")
    end

    it 'should get the correct customer base url with entity ' do
      expect(Bill.customerBaseUrl).to eq("http://api.reimaginebanking.com:80/customers")
    end

    it 'should have an API key' do
      expect(Bill.apiKey.class).to be(String) # passes if actual == expected
    end

  end

  describe 'GET' do
    it 'should get all Bills by customer id' do
      VCR.use_cassette 'bill/billsByCustomerId' do
        bills = Bill.getAllByCustomerId($customerId)
        expect(bills.class).to be(Array)
        expect(bills.length).to be > 0
        expect(bills[0].class).to be(Hash)
      end
    end

    it 'should get one Bills by customer id' do
      VCR.use_cassette 'bill/billByCustomerId' do
        bill = Bill.getOneByCustomerIdBillId($customerId, $billId)
        expect(bill.class).to be(Hash)
        expect(bill).to include("status")
      end
    end

    it 'should get all Bills by account id' do
      VCR.use_cassette 'bill/billsByAccountId' do
        bills = Bill.getAllByAccountId($accountId)
        expect(bills.class).to be(Array)
        expect(bills.length).to be > 0
        expect(bills[0].class).to be(Hash)
      end
    end

    it 'should get one Bills by account id' do
      VCR.use_cassette 'bill/billByAccountId' do
        bill = Bill.getOneByAccountIdBillId($accountId, $billId)
        expect(bill.class).to be(Hash)
        expect(bill).to include("status")
      end
    end
  end

  describe 'PUT' do
    it 'should update a Bill' do
      VCR.use_cassette 'bill/updateBill' do
        response = Bill.updateBill($accountId, $billId, $billPost)
        expect(response.class).to be(Hash)
        expect(response).to include("message")
        expect(response).to include("code")
      end
    end
  end

  describe 'POST' do
    it 'should create a Bill' do
      VCR.use_cassette 'bill/createBill' do
        response = Bill.createBill($accountId, $billPost)
        expect(response.class).to be(Hash)
        expect(response).to include("message")
        expect(response).to include("code")
      end
    end
  end


  describe 'DELETE' do
    it 'should delete a Bill' do
      VCR.use_cassette 'bill/deleteBill' do
        response = Bill.deleteBill($accountId, $billId)
        expect(response.class).to be(Net::HTTPNoContent)
        expect(response.code).to eq("204")
      end
    end
  end

end