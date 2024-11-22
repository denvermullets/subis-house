# frozen_string_literal: true

# we store 'player' gamestate here
class GameStateComponent
  attr_accessor :total_animals, :pellets_sold, :pellets, :money, :food

  def initialize
    @total_animals = 0
    @pellets_sold = 0
    @pellets = 0
    @money = 0
    @food = 0
  end
end
