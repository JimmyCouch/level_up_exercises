ENV['RACK_ENV'] = 'test'
require_relative '../overlord'
require 'rspec'
require 'capybara/rspec'
require 'rack/test'
require 'capybara/cucumber'

Capybara.app = Overlord