require 'rubygems'
require 'httparty'
require 'colorize'

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

def title_border
  @title.length.times do
    print "*".colorize(:red)
  end
  print "\n"
end

def clear_terminal
  Gem.win_platform? ? (system "cls") : (system "clear")
end

stoic_quotes = StoicQuotes.new

@title = "Stoic Quote Generator"

menu  = "What would you like to do?\n\n"
menu += "R = Print a Random Quote\n"
menu += "L = List All Stoic Quotes\n"
menu += "X = Exit \n\n"
     
prompt = "> "

clear_terminal
puts "\n"
title_border
puts @title.colorize(:red)
title_border
puts "\n"

puts menu
print prompt

while input = gets.strip

  case input
  when "R", "r"
    clear_terminal
    puts "\n", stoic_quotes.random_quote.colorize(:green), "\n"
    puts menu
    print prompt
  when "L", "l"
    clear_terminal
    num_of_quotes = stoic_quotes.num_of_quotes
    i = 0
    until i >= (num_of_quotes - 1)
      if i.even?
        puts stoic_quotes.pick_quote(i).colorize(:magenta), "\n"
      else
        puts stoic_quotes.pick_quote(i).colorize(:green), "\n"
      end
      i += 1
    end
    puts menu
    print prompt
  when "X", "x"
    exit
  else
    puts "\n", "Please enter 'R' (random quote), 'L' (list all) or 'X' (exit)."
    print prompt
  end

end
