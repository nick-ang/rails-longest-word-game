require "open-URI"

class GamesController < ApplicationController
  def new
    @letters = Array.new(9) { ("A".."Z").to_a.sample }
  end

  def score
    if included?(params[:word].upcase, params[:letters])
      if english_word?(params[:word])
        score = params[:word].size
        @message = "Well done your score is #{score}"
      else
        @message = "Not an english word your score is #{score}"
      end
    else
      @message = "Not in grid your score is #{score}"
    end
  end

  def included?(word, array)
    word.upcase.each_char do |l|
      if array.include? l
        array.chars.delete_at(array.index(l))
        true
      else
        return false
      end
    end
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json["found"]
  end
end
