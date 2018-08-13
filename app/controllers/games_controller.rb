class GamesController < ApplicationController

  def new
    @letters = Array.new(8) { ('A'..'Z').to_a.sample }
  end

  def score
    @guess = params[:games].upcase.split("")
    @letters = params[:letters].split(" ")
    guess_in_letters = @guess.all? {|letter| @guess.count(letter) <= @letters.count(letter)}
    if guess_in_letters
      response = open(url)
      json = JSON.parse(response.read)
      if json("found")
        @result = "Congratulations! #{@guess} is a valid English word"
      else
        @result = "Sorry, #{@guess} is not an English word"
      end
    else
      @result = "Sorry the #{@guess} can't be build out of #{@letters}"
    end
  end
end



# require 'open-uri'
# require 'json'

# def generate_grid(grid_size)
#   Array.new(grid_size) { ('A'..'Z').to_a.sample }
# end

# def included?(guess, grid)
#   guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
# end

# def compute_score(attempt, time_taken)
#   time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
# end

# def run_game(attempt, grid, start_time, end_time)
#   result = { time: end_time - start_time }

#   score_and_message = score_and_message(attempt, grid, result[:time])
#   result[:score] = score_and_message.first
#   result[:message] = score_and_message.last

#   result
# end

# def score_and_message(attempt, grid, time)
#   if included?(attempt.upcase, grid)
#     if english_word?(attempt)
#       score = compute_score(attempt, time)
#       [score, "well done"]
#     else
#       [0, "not an english word"]
#     end
#   else
#     [0, "not in the grid"]
#   end
# end

# def english_word?(word)
#   response = open("https://wagon-dictionary.herokuapp.com/#{word}")
#   json = JSON.parse(response.read)
#   return json['found']
# end
