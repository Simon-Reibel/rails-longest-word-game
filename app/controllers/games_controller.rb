
require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @randLet = Array.new(10) { Array('A'..'Z').sample }
  end

  def score
    
    @answer = params[:answer]

    response = open("https://wagon-dictionary.herokuapp.com/#{@answer}")
    json = JSON.parse(response.read)

    @final = []
    if json['found'] == false
      @reponse = json['error']
    elsif json['found'] == true 
      @parameters = params[:lettres].upcase.split
      @parameters.each do |letter|
        if @answer.include?(letter)
          @final << letter
        end
      end
      if @final.length == @parameters.length
        @reponse = "Ce mot peut bien être créer avec les lettres données"
      else
        @reponse = "ce mot ne peut pas etre construit avec les lettres données"
      end
    end
  end
end
