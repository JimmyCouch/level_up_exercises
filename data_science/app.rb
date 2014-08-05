require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'json'
require 'Date'
require "./experiment"
require './cohort'

before do
    content_type 'application/json'
end


get "/" do
    content_type 'html'
    erb :index
end

get "/results.json" do

	json_file = JSON.parse(File.read('source_data.json'))

	userA = Cohort.new("A")
	userB = Cohort.new("B")

	cohort_array = []
	cohort_array << userA
	cohort_array << userB

	experiment = Experiement.new(cohort_array, json_file)
	experiment.parse
	experiment.analyze.to_json

end
