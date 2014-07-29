 #!/usr/bin/ruby
require 'csv'
require 'hirb'


class Dinosaur

	attr_accessor :properties

	def initialize(options = {})
		@properties = options

	end

	def self.find(dinos, params={})
		results = []
		dinos.each do |dino|
			results << dino if params.all? {|term| dino.properties.value?(term.strip.to_s)}
		end

		# puts results.to_s
		print_out(results)

	end


	def self.print_out(dinos)
		# temp = []
		dinos.each do |dino|
			dino.properties.keys.each {|k| puts "#{k}:    #{dino.properties[k]}" if !dino.properties[k].nil?}
			puts ""
			# temp << dino.properties.values
			puts "*****************************************************************************************"
		end
		# puts Hirb::Helpers::AutoTable.render(temp,:headers => %w(NAME PERIOD CONTINENT DIET WEIGHT WALKING DESCRIPTION))



	end

	def to_s
		 self.inspect
	end

	def translate
		translation = {
		"Genus" => "NAME",
		"Period" => "PERIOD",
		"Carnivore" => "DIET",
		"WEIGHT_IN_LBS" => "WEIGHT",
		"Weight" => "WEIGHT",
		"Walking" => "WALKING"
		}

		@properties = Hash[@properties.map do |key,val|
			if key == "Carnivore" && val == "Yes"
				val = "Carnivore"
			elsif val == "No"
				val=nil
			end
			[translation[key] || key, val]
			end
		]
	end

end







