# frozen_string_literal: true

# keeps track of each animal's hunger level, items could modify rates
class HungerComponent
  attr_accessor :level, :replenish_rate, :rate, :remaining_hunger, :is_eating, :replenish_cost, :last_updated

  def initialize
    @level = 0
    @rate = 1
    # way to time how hunger grows
    @last_updated = 0
    # hunger remaining after eating food, slowly ticks down
    @remaining_hunger = 0
    @is_eating = false
    # replenish_rate is how many seconds it takes to recover a hunger point
    @replenish_rate = 0.5
    # replenish_rate is how many pieces of food replenish 1 hunger point
    @replenish_cost = 2
  end
end
