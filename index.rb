require 'rubygems'
require 'httparty'

# API
# https://randomstoicquotesapi.herokuapp.com/
# API Docs
# https://github.com/jimmerioles/random-stoic-quotes-api

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
    num >=0 && num <= (@num_of_quotes - 1) ? @request[num]["attributes"]["text"] : nil
  end

  def random_quote
    num = rand(0..(@num_of_quotes - 1))
    @request[num]["attributes"]["text"] 
  end
end

stoic_quotes = StoicQuotes.new

puts "\nStoic Quote Generator\n\n"
puts "What would you like to do?\n\n"
puts "R = Get a Random Quote",
     "X = Exit"

prompt = "> "

print prompt
input = gets.strip

until input == "X" || input == "x"
  if input == "R" || input == "r"
    puts "\n", stoic_quotes.random_quote, "\n"
    print prompt
    input = gets.strip
  else
    puts "Please enter 'R' (random quote) or 'X' (exit)."
    print prompt
    input = gets.strip
  end
end
