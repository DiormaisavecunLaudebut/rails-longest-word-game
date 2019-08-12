require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = ("A".."Z").to_a.sample(7)
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters]
    response = open("https://wagon-dictionary.herokuapp.com/#{@answer}")
    json = JSON.parse(response.read)
    test = @answer.chars.map {|i| @letters.split(' ').include?(i.upcase)}.include?(false)
    if test == true
      @display = "Sorry but TEST can't be build out of #{@answer.upcase.split(' ').join()}"
    elsif json['found'] == false
      @display = "Sorry but #{@answer} does not seem to be a valid english word"
    else
      @display = "Congratulations, #{@answer} is a valid english word"
    end
  end
end
