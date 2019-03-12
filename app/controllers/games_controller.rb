require 'json'
require 'open-uri'
class GamesController < ApplicationController
  def new
    random_array = Array.new(10) { ('a'..'z').to_a.sample }
    @letters = random_array
  end

  def score
    @letters = params['letters'].split(" ")
    @word = params[:word]
    @included = included?(@word, @letters)
    @valid_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open('https://wagon-dictionary.herokuapp.com/' + word).read
    dictionary = JSON.parse(response)
    dictionary["found"]
    # API CALL AND RETURN THE JSON[FOUND]
  end
end
