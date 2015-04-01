require 'net/http'
require 'json'

require 'capital_one/accounts'
require 'capital_one/atms'
require 'capital_one/bills'
require 'capital_one/branches'
require 'capital_one/customers'
require 'capital_one/config'
require 'capital_one/transactions'

class CapitalOne

=begin 
Depending on the access level/type of API key supplied, some of
these methods will return 403 error codes(forbidden). Enterprise level
API keys have access to any/all of the GET requests, but nothing else. 
Customer level API keys have access to GET, POST, PUT, and DELETE, but only
for valid accounts which are associated with the customer API key. 
=end

=begin
Testing data
DELETION ACCT ID(because I don't want to
break all the other testing data): 546cd56d04783a02616859c9
Note: This won't actually delete anything as it isn't a valid customer account ID associated with the API key included here. 
Customer ID: 5516c07ba520e0066c9ac53b
^That customer's bank account ID: 55173197c5749d260bb8d151	
More cust ids w/ account ids:
cust: 5516c07ba520e0066c9ac53b
acct: 55175197c5749d260bb8d159

cust: 5516c07ba520e0066c9ac53b
acct: 5517614cc5749d260bb8d160

Json for updating cusomter data: 	
myJson ='{
 		 "address": {
  		   "street_number": "424 Waupelani Drive",
    	   "street_name": "",
  		   "city": "state college",
   		   "state": "PA",
    	   "zip": "16801"
  		}
	}'

Json for updating Account data:
{
	"type":"Savings",
	"nickname":"test",
	"rewards":10,
	"balance":1000,
	"customer":"5516c07ba520e0066c9ac53b",
	"_id":"55173197c5749d260bb8d151"
	}

Json for creating a new account:
{
  "type": "Savings",
  "nickname": "TomP"1,
  "rewards": 2,
  "balance": 300
}

Json for creating a new bill: 
{
  "status": "",
  "payment_date": "",
  "recurring_date": 0,
  "payment_amount": 0
}

Json for creating a new transaction:
{
  "transaction type": "cash",
  "payee id": "5517614cc5749d260bb8d160",
  "amount": 50
}

=end
#Test Data:

	APIkey = 'CUSTf52dd79967987b3ba94904e83cc26e47'
	baseURL = 'http://api.reimaginebanking.com:80'

		json ='{
	 		 "address": {
	  		   "street_number": "424 Waupelani Drive",
	    	   "street_name": "",
	  		   "city": "state college",
	   		   "state": "PA",
	    	   "zip": "16801"
	  		}
		}'

		acctJson =	'{
			"nickname":"myTest"
		}'

		newAcctJson = '{
		  "type": "",
		  "nickname": "",
		  "rewards": 0,
		  "balance": 0
		}'

		newBillJson = '{
		  "status": "Pending",
		  "payment_amount": 1000
		}'

		newTranJson = '{
		  "transaction type": "cash",
		  "payee id": "5517614cc5749d260bb8d160",
		  "amount": 50
		}'

#End Test Data
#getCustAccts('5516c07ba520e0066c9ac53b')


#updateAccount('55173197c5749d260bb8d151', acctJson)

# updateCustomer('5516c07ba520e0066c9ac53b', json)
# getCustomer('5516c07ba520e0066c9ac53b')


#deleteBill('546cd56d04783a02616859c9', '546cd56d04783a02616859c9')

#deleteAcc('546cd56d04783a02616859c9')

#deleteTransaction('546cd56d04783a02616859c9', '546cd56d04783a02616859c9')

end
