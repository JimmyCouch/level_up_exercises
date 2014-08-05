#!/usr/bin/ruby
require 'rubygems'
require 'json'
require './Cohort'

class Experiement < Cohort

	attr_accessor :json_file, :results, :cohort_array


	def initialize(cohort_array, json_file)
		cohort_array.each {|user| super(user) }
		@cohort_array = cohort_array
		@json_file = json_file
	end

	def leader
		@cohort_array.max_by do |cohort|
			cohort.conversion_rate
			cohort.stdv
		end
	end

	def loser
		@cohort_array.min_by do |cohort|
			cohort.conversion_rate
			cohort.stdv
		end
	end

	def parse
		@json_file.each do |row|
			cohort_name = row['cohort']
			result = row['result']
			@cohort_array.each do |cohort|
				if cohort.name == cohort_name
					cohort.increment_total
					cohort.increment_found if result == 1
				end
			end
		end
	end

	def chi_squared

		a = @cohort_array[0].found.to_f
		b = @cohort_array[0].total - @cohort_array[0].found.to_f
		c = @cohort_array[1].found.to_f
		d = @cohort_array[1].total - @cohort_array[1].found.to_f

		(((a * d - b * c)**2 * (a + b + c + d)) / ((a + b) * (c + d) * (b + d) * (a + c))).round(2)
	end


	def analyze
		{
			:leader => leader.to_hash,
			:loser => loser.to_hash,
			:chi_squared => chi_squared
		}
	end
end