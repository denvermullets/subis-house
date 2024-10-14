class GameTime
  attr_accessor :current_game_time, :elasped_time, :paused, :total_time

  def initialize
    @paused = false
    @current_game_time = 0
    @elapsed_time = 0
    @last_update_time = 0
    @total_time = 0
  end

  def progress_time(args)
    current_time = Time.now.to_f
    @elapsed_time = current_time - @last_update_time.to_f
    return unless @elapsed_time >= 1.0

    @total_time += 1
    @last_update_time = current_time
    return unless @paused == false

    @current_game_time += 1
    args.state.player.update_animals
    args.state.player.collect_products
  end

  def pause
    @paused = !@paused
  end
end
