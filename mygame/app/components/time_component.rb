# frozen_string_literal: true

# we're storing most of the time related data here, time_system triggers updates
class TimeComponent
  attr_gtk
  attr_accessor :current_game_time, :elapsed_time, :paused, :total_time, :last_update_time
  attr_accessor :hour

  def initialize
    @paused = false
    @current_game_time = 0
    @elapsed_time = 0
    @last_update_time = Time.now.to_f
    @hour = 0
    @total_time = 0
  end
end
