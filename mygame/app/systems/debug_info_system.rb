class DebugInfoSystem
  def initialize(args)
    @args = args
  end

  def update(args)
    @args = args

    debug = @args.state.entity_manager.find_by_id(:debug_window)

    debug.get_all_components(LabelComponent).map do |label|
      case label.id
      when :current_money
      when :total_time
        label.text = "Total Game Time: #{@args.state.game_time.total_time}"
      when :elapsed_game_time
        label.text = "Game Time: #{@args.state.game_time.current_game_time}"
      when :animal_count
        label.text = "Aminals: #{@args.state.entity_manager.entities.count}"
      end
    end
  end
end
