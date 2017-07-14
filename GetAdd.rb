require 'typhoeus'
require 'pry'
require 'json'

class GetAdd

	def self.fetch(latLong)
		latLong.gsub!(/\s/, "")
		url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{latLong}&key=AIzaSyCoUlZyuktIbzR3pJ50MsYiPjgqKEmY1d0"
		
		doc = Typhoeus.get(url)
		maal = JSON.parse(doc.response_body)
		
		allResults = []

		maal["results"].each do |row|
			address = ""
			row["address_components"].each do |element|
				address << element["long_name"] << "\n"
			end	
			allResults << address
		end

		puts
		puts "*** ***"
		puts "This is a list of addresses that turned up when you put in only the Latitude and Longitude: "
		allResults.each do |address|
			puts address.to_s
			puts
		end
		puts "*** ***"
	end

=begin	
	def self.party 

		puts "Enter Latitude and Longitude below, separated by a comma > "
		latLong = gets.chomp
		fetch(latLong)

	end	

	party	
=end
end

