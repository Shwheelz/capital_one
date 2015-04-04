require 'capital_one'

describe Account do
	it "should return a string" do						# This is the name of our test. It can be anything
		account = Account.getAccount("Checking")		
		account.class.should == String					# Tests whether the API returns a String
	end
end