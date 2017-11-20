require 'open-uri'
require 'json'

class PagesController < ApplicationController


  def game
    grid = ("A".."Z").to_a
    compteur = (1..9).to_a
    @grid = []
      compteur.each do |_|
      @grid << grid.sample(1)
    end
  return @grid
  end

  def score
  grid_ok = " "
  reponse = params[:query].upcase.chars
  filepath = "https://wagon-dictionary.herokuapp.com/" + params[:query]
  reponse_serialized = open(filepath).read
    puts "0"

  reponse_dico = JSON.parse(reponse_serialized)
  longueur = params[:query].size
  validation = reponse_dico["found"]
    puts "1"

  reponse.each do |lettre|
    if reponse.count(lettre) <= params[:grid].count(lettre)
      grid_ok = true
    else
      grid_ok = false
    end
  end
  puts "2"
  @score = scorefinal(validation, grid_ok, longueur)
  puts "hello"
  @message = message(@score, validation, grid_ok)
  puts "3"
  end

  def scorefinal(validation, grid_ok, longueur)
    if validation == true && grid_ok == true
      score =  longueur
    else
      score = 0
    end
      return score
  end

  def message(score, validation, grid_ok)
    if validation == true && grid_ok == true
      message =  "Well Done!"
    elsif validation == false && grid_ok == true
      message =  "Not an english word"
    elsif validation == true && grid_ok == false
      message = "Not in the grid"
    elsif validation == false && grid_ok == false
      message = "Not in the grid"
    end
    return message
  end
end
