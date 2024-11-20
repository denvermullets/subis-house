# frozen_string_literal: true

# System handles progression of time
# keeps track of
class TimeSystem
  def initialize(game_state)
    @game_state = game_state
  end

  def progress_time(args)
    set_clock
    # once time hits 1 second update internal time
    return unless @game_state.elapsed_time >= 1.0

    update_clock
    # if game is not paused trigger updates
    return unless @game_state.paused == false

    @game_state.current_game_time += 1
    update_systems(args)
  end

  private

  def pause
    @game_state.paused = !@game_state.paused
  end

  def set_clock
    @current_time = Time.now.to_f
    @game_state.elapsed_time = @current_time - @game_state.last_update_time.to_f
  end

  def update_clock
    @game_state.total_time += 1
    @game_state.last_update_time = @current_time
  end

  def update_systems(args)
    # systems could +1 on each update and maintain their own state
    args.state.pellet_system.update(args)
    args.state.hunger_system.update(args)
    # args.state.player.update_animals
    # args.state.player.collect_products
  end
end
