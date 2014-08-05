
class Cohort 

	attr_accessor :name, :total, :found, :conversion_rate, :confidence, :stdv, :chi_value
	 C = 1.96
	 Z_VALUE = 3.841

	def initialize(name)
		@name = name
		@total = 0
		@found = 0
		@conversion_rate = 0
		@stdv = 0
	end


	def increment_total
		@total += 1
	end

	def increment_found
		@found += 1
	end

	def conversion_rate
		@conversion_rate = (@found / @total.to_f * 100).round(2)
	end

	def stdv
		raw_rate = @found / @total.to_f
		raw_stdv =  Math.sqrt(raw_rate * (1-raw_rate) / @total)

		@stdv = "#{((raw_rate - C * raw_stdv)*100).round(2)}% - #{((raw_rate + C * raw_stdv)*100).round(2)}%"

	end

	def to_hash
		hash = {}
		instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
	    hash
	end

end