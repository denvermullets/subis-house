class DebugInfoSystem
  def update(args)
    debug = args.state.entity_manager.find_by_id(:debug_window)

    debug.get_all_components(LabelComponent).map do |label|
      case label.id
      when :total_time
        label.text = "Total Game Time: #{args.state.game_time.total_time}"
      when :elapsed_game_time
        label.text = "Game Time: #{args.state.game_time.current_game_time}"
      when :animal_count
        # entities = args.state.entity_manager.find_by_component(AnimalComponent)
        label.text = "Animals: #{args.state.game_state.total_animals}"
      when :product
        animals = args.state.entity_manager.find_by_component(PelletComponent)
        total_pellets = 0
        animals.each do |animal|
          total_pellets += animal.get_component(PelletComponent).pellets
        end

        label.text = "Product: #{total_pellets}"
      end
    end
  end
end
