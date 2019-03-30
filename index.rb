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
  end
  
  def first_quote
    @request[0]["attributes"]["text"]
  end

  

end

stoic_quotes = StoicQuotes.new

puts stoic_quotes.first_quote
#request.quotes.each do |item|
#  p item
#  puts "\n\n"
#end