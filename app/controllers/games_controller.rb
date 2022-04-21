class GamesController < ApplicationController
  def new
    @array = []
    (0..10).each { |_| @array << (rand(0..25) + 'A'.ord).chr }
  end

  def score
    html = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    html = JSON.parse(html)
    @result = valid?(params[:word], params[:array], html)
  end

  private

  def can_be_built?(word, array)
    chk = true

    word.chars do |x|
      return false if chk == false

      chk = false
      array.split.each { |y| chk = true if x == array[y].downcase }
    end

    true
  end

  def valid?(word, array, html)
    return "Sorry but #{word} can't be built of #{array.split.join(', ')}" if can_be_built?(word, array) == false

    return "Sorry but #{word} does not seem to be a valid english word..." if html['found'] == false

    "Congratulations! #{word} is a english word!"
  end
end
