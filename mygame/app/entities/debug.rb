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
        text: 'Game Time: ',
        x: 70, y: 630, r: 251, g: 251, b: 251, size: 1,
        id: :elapsed_game_time
      )
    )
    debug_window.add_component(
      LabelComponent,
      LabelComponent.new(
        text: 'Total Game Time: ',
        r: 251, g: 251, b: 251, x: 70, y: 600, size: 1,
        id: :total_time
      )
    )
    debug_window.add_component(
      LabelComponent,
      LabelComponent.new(
        text: 'Animals: ',
        r: 251, g: 251, b: 251, x: 70, y: 570, size: 1,
        id: :animal_count
      )
    )
    debug_window.add_component(
      LabelComponent,
      LabelComponent.new(
        text: 'Pellets: ',
        x: 70, y: 540, r: 251, g: 251, b: 251, size: 1,
        id: :pellets
      )
    )
    debug_window.add_component(
      LabelComponent,
      LabelComponent.new(
        text: 'Food: ',
        x: 70, y: 510, r: 251, g: 251, b: 251, size: 1,
        id: :food
      )
    )

    args.state.entity_manager.add_entity(debug_window)
  end
end
