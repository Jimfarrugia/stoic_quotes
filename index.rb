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

end

stoic_quotes = StoicQuotes.new

puts stoic_quotes.first_quote
puts stoic_quotes.last_quote
puts stoic_quotes.num_of_quotes