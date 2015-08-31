require 'capital_one'

describe Branch do

  before(:all) do
    Config.apiKey = "d481ae7211ed5a78cb18855ca7d40e4f"
  end

  describe 'Method' do
    
    it 'should get the correct base url' do
      expect(Branch.url).to eq("http://api.nessiebanking.com:80")
    end

    it 'should get the correct base url with entity' do
      expect(Branch.urlWithEntity).to eq("http://api.nessiebanking.com:80/branches")
    end

    it 'should have an API key' do
      expect(Branch.apiKey.class).to be(String) # passes if actual == expected
    end

  end

  describe 'GET' do
    it 'should get all Branches' do
      VCR.use_cassette 'branch/branches' do
        branches = Branch.getAll
        expect(branches.class).to be(Array)
        expect(branches.length).to be > 0
        expect(branches[0].class).to be(Hash)
       end
    end

    it 'should get a single Branch' do
      VCR.use_cassette 'branch/branch' do
        branch = Branch.getOne(Branch.getAll[0]["_id"])
        expect(branch.class).to be(Hash)
        expect(branch).to include("_id")
        expect(branch).to include("name")
      end
    end
  end

end