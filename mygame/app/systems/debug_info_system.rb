# frozen_state_literal: true

# this is what updates the debug menu labels
class DebugInfoSystem
  def update(args)
    debug = args.state.entity_manager.find_by_id(:debug_window)

    debug.where(LabelComponent).map do |label|
      case label.id
      when :total_time
        label.text = "Total Game Time: #{args.state.game_time.total_time}"
      when :elapsed_game_time
        label.text = "Game Time: #{args.state.game_time.current_game_time}"
      when :animal_count
        label.text = "Animals: #{args.state.game_state.total_animals}"
      when :pellets
        label.text = "Pellets: #{args.state.game_state.pellets}"
      when :money
        label.text = "Money: #{args.state.game_state.money}"
      when :food
        label.text = "Food: #{args.state.game_state.food}"
      when :hour
        label.text = "Hour: #{args.state.game_time.hour}"
      end
    end
  end
end
