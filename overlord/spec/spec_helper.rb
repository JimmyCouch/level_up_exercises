ENV['RACK_ENV'] = 'test'
require_relative '../overlord'
require 'rspec'
require 'capybara/rspec'

Capybara.app = Overlord