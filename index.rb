require 'rubygems'
require 'httparty'

# API
# https://randomstoicquotesapi.herokuapp.com/
# API Docs
# https://github.com/jimmerioles/random-stoic-quotes-api

class Request
  include HTTParty
  base_uri "randomstoicquotesapi.herokuapp.com"

  def quotes
    self.class.get('/api/v1/quotes')
  end
end

request = Request.new

request.quotes.each do |item|
  puts item
end