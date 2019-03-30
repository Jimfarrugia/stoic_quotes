require 'rubygems'
require 'httparty'

# API
# https://randomstoicquotesapi.herokuapp.com/
# API Docs
# https://github.com/jimmerioles/random-stoic-quotes-api

@display = nil

class StoicQuotes
  include HTTParty
  base_uri "randomstoicquotesapi.herokuapp.com"

  def initialize
    @request = self.class.get('/api/v1/quotes')["data"]
    @num_of_quotes = @request.length
  end

  def num_of_quotes
    @num_of_quotes
  end
  
  def first_quote
    @request[0]["attributes"]["text"]
  end

  def last_quote
    @request[-1]["attributes"]["text"]
  end

  def pick_quote num
    num >=0 && num <= @num_of_quotes ? @request[num]["attributes"]["text"] : nil
  end

  def random_quote
    num = rand(0..@num_of_quotes)
    @request[num]["attributes"]["text"] 
  end
end

stoic_quotes = StoicQuotes.new

puts "First Quote: " + stoic_quotes.first_quote
puts "Last Quote: " + stoic_quotes.last_quote
if stoic_quotes.pick_quote(33)
  puts "Chosen Quote: " + stoic_quotes.pick_quote(33)
end
puts "Random Quote: " + stoic_quotes.random_quote