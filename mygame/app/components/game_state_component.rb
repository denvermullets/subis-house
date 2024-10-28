class GameStateComponent
  attr_accessor :total_animals, :pellets_sold, :pellets, :money

  def initialize
    @total_animals = 0
    @pellets_sold = 0
    @pellets = 0
    @money = 0
  end
end
