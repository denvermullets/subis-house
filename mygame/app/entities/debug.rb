# frozen_string_literal: true

# outputs some debug info to keep track during dev
class Debug
  def self.create(args)
    debug_window = Entity.new(id: :debug_window)
    debug_window.add_component(
      SpriteComponent,
      SpriteComponent.new(x: 40, y: 430, w: 340, h: 250, path: 'assets/bg-debug.png')
    )
    debug_window.add_component(
      LabelComponent,
      LabelComponent.new(
        text: 'Money: ',
        r: 251, g: 251, b: 251, x: 70, y: 660, size: 1,
        id: :money
      )
    )
    debug_window.add_component(
      LabelComponent,
      LabelComponent.new(
        text: "Game Time: #{args.state.game_time.current_game_time}",
        x: 70, y: 630, r: 251, g: 251, b: 251, size: 1,
        id: :elapsed_game_time
      )
    )
    debug_window.add_component(
      LabelComponent,
      LabelComponent.new(
        text: "Total Game Time: #{args.state.game_time.total_time}",
        r: 251, g: 251, b: 251, x: 70, y: 600, size: 1,
        id: :total_time
      )
    )
    debug_window.add_component(
      LabelComponent,
      LabelComponent.new(
        text: "Animals: #{args.state.player.animals.count}",
        r: 251, g: 251, b: 251, x: 70, y: 570, size: 1,
        id: :animal_count
      )
    )
    debug_window.add_component(
      LabelComponent,
      LabelComponent.new(
        text: "Pellets: #{args.state.player.pellets_output}",
        x: 70, y: 540, r: 251, g: 251, b: 251, size: 1,
        id: :pellets
      )
    )

    args.state.entity_manager.add_entity(debug_window)
  end
end
