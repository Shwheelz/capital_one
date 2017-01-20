require 'capital_one'

describe Loan do

  before(:all) do
    Config.apiKey = "98a490a765c08c70d61dc3f89feea899"
  end

  describe 'Method' do
    it 'should get the correct base url' do
      expect(Account.url).to eq("http://api.reimaginebanking.com:80")
    end

    it 'should get the correct base url with entity' do
      expect(Account.urlWithEntity).to eq("http://api.reimaginebanking.com:80/loans")
    end

    it 'should have an API key' do
      expect(Account.apiKey.class).to be(String) # passes if actual == expected
    end
  end

  describe 'POST' do
    it 'should create a new loan' do
      VCR.use_cassette 'loan/createLoan' do

        loanPost = {
            "type"=> "auto",
            "status"=> "approved",
            "credit_score"=> 700,
            "monthly_payment"=> 200.00,
            "description"=>"test auto loan"
        }

        accountId = Account.getAll[0]["_id"]
        response = Loan.createLoan(accountId, loanPost)
        expect(response.class).to be(Hash)
        expect(response).to include("message")
        expect(response).to include("code")
      end
    end
  end

  describe 'GET' do

    it 'should get all loans by Account Number' do
      VCR.use_cassette 'loan/loansByAccountNumber' do
        accountId = Account.getAll[0]["_id"]
        loan = Loan.getLoansByAccountId(accountId)
        expect(loan.class).to be(Hash)
        expect(loan).to include("_id")
        expect(loan).to include("type")
        expect(loan).to include("creation_date")
        expect(loan).to include("status")
        expect(loan).to include("credit_score")
        expect(loan).to include("monthly_payment")
        expect(loan).to include("amount")
      end
    end

    it 'should get a single Loan' do
      VCR.use_cassette 'loan/loan' do
        accountId = Account.getAll[0]["_id"]
        loanId = Loan.getLoansByAccountId(accountId)[0]["_id"]
        loan = Loan.getLoan(loanId)
        expect(loan.class).to be(Hash)
        expect(loan).to include("_id")
        expect(loan).to include("type")
        expect(loan).to include("creation_date")
        expect(loan).to include("status")
        expect(loan).to include("credit_score")
        expect(loan).to include("monthly_payment")
        expect(loan).to include("amount")
      end
    end

  describe 'PUT' do
    it 'should update an existing loan' do
      VCR.use_cassette 'loan/updateLoan' do
        loanPut = {"type"=> "home"}
        loanId = Loan.getLoansByAccountId(accountId)[0]["_id"]
        response = Loan.updateLoan(loanId, loanPut)
        expect(response.class).to be(Hash)
        expect(response).to include("message")
        expect(response).to include("code")
      end
    end
  end

  describe 'DELETE' do
    it 'should delete a loan' do
      VCR.use_cassette 'loan/deleteLoan' do
        loanId = Loan.getLoansByAccountId(accountId)[0]["_id"]
        response = Loan.deleteLoan(loanId)
        expect(response.class).to be(Net::HTTPNoContent)
        expect(response.code).to eq("204")
      end
    end
  end

end