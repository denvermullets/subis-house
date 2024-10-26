class TimeComponent
  attr_accessor :current_game_time, :elapsed_time, :paused, :total_time, :last_update_time

  def initialize
    @paused = false
    @current_game_time = 0
    @elapsed_time = 0
    @last_update_time = Time.now.to_f
    @total_time = 0
  end
end
