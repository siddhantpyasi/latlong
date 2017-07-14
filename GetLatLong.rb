require 'json'
require 'typhoeus'
require 'pry'
require_relative 'GetAdd'

class GetLatLong
	# Function that gets the address entered
	def self.fetch

		# The address is called 'item'
		puts "Enter the address below > "
		item = gets.chomp
			
		# Replaces whitespaces or commas and whitespaces with a + sign
		item.gsub!(/,\s|\s/, '+')
		
		# This is the standard URL that must be called by the program, contains
		# the address and my API key
		url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{item}&key=AIzaSyCoUlZyuktIbzR3pJ50MsYiPjgqKEmY1d0"
		
		# Makes a request to the link, link sends back a JSON
		doc = Typhoeus.get(url)
		# The JSON is converted into a hash of arrays
		# So there's a big hash, that contains arrays, and those arrays
		# contain hashes
		maal = JSON.parse(doc.response_body)
		
		# Print the necessary items
		puts
		puts "*****"
		puts "Latitude > #{maal["results"][0]["geometry"]["location"]["lat"]}" 
		puts "Longitude > #{maal["results"][0]["geometry"]["location"]["lng"]}"
		puts "*****"
		puts

		latLong = ""
		latLong << maal["results"][0]["geometry"]["location"]["lat"].to_s << "," << maal["results"][0]["geometry"]["location"]["lng"].to_s
		puts 
		puts "*****"
		puts "VERIFYING"
		GetAdd.fetch(latLong)
	end
	
	# An infinite loop that runs the program. Type 2 to exit, type 1 to get latitude and longitude
	loop do
		puts 
		puts "***   ***   ***"
		puts "Welcome to the LatLong Service"
		puts 
		puts "1. Get latitude and longitude"
		puts "2. Exit"
		print "Choose an option(1 or 2) > "
		option = gets.chomp.to_i

		case option
		when 1 then fetch
		when 2 then break 
		else
			puts "Enter a valid option"
		end
	end

end



 
