# frozen_string_literal: true

# keeps track of each animal's hunger level, items could modify rates
class HungerComponent
  attr_accessor :level, :recovery_time, :rate

  def initialize
    @level = 0
    @rate = 1
    @recovery_time = 50
  end
end
