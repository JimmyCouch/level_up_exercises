#!/usr/bin/ruby
require './Dinosaur'

puts "**************************************************"
puts "Welcome, please enter a search term for a dinosaur"
puts "separate queries by a ,"
puts "**************************************************"

search_terms_array = gets.split(",")

dinos = []

Dir.glob('*.csv').each do|f|
 	CSV.foreach(f, :headers => true) do |row|
		dino_hash = Dinosaur.new(row.to_hash)
		dino_hash.translate
		dinos << dino_hash
	end
end


# dinos.find(search_terms_array)
Dinosaur.find(dinos,search_terms_array)



