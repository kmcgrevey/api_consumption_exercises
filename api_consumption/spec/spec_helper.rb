require 'rspec'
require 'pry'
require 'dotenv'
Dotenv.load

Dir["./lib/*.rb"].each { |file| require file }
