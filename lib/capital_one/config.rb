module CONFIG
 	APIKEY = 'CUSTf52dd79967987b3ba94904e83cc26e47'
	BASEURL = 'http://api.reimaginebanking.com:80'

	def self.hashFormatting(json)
		JSON.parse(json)
	end


end
