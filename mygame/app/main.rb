require 'app/components/name_component'
require 'app/components/sprite_component'
require 'app/components/z_component'
require 'app/components/label_component'
require 'app/components/clickable_component'
require 'app/components/modal_component'
require 'app/components/scrollable_component'
require 'app/managers/entity_manager'
require 'app/systems/render_system'
require 'app/systems/scrollable_system'
require 'app/systems/input_system'
require 'app/entities/entity'
require 'app/entities/animal'
require 'app/entities/modal_menu'
require 'app/entities/button'

def tick(args)
  args.labels << { x: 20, y: 700, text: "#{args.inputs.mouse.x} - #{args.inputs.mouse.y}", r: 0, g: 0, b: 0 }
  init(args) if args.state.tick_count.zero?

  args.state.scrollable_system.update(args)
  args.state.render_system.render_outputs(args)
  args.state.input_system.update(args)
end

def init(args)
  args.state.entity_manager ||= EntityManager.new

  ModalMenu.new(args).create_modal

  scrollable_list_entity = Entity.new(id: :scrollable_list)
  scrollable_background = SpriteComponent.new(path: 'assets/bg-animal-list.png', x: 900, y: 340, w: 340, h: 340)
  scrollable_component = ScrollableComponent.new(
    scroll_area_x: scrollable_background.x + 20,
    scroll_area_y: scrollable_background.y + 20,
    scroll_area_width: scrollable_background.w - 20,
    scroll_area_height: scrollable_background.h - 20,
    line_height: 30,
    top_padding: 20,
    buffer_zone: 30
  )

  scrollable_list_entity.add_component(
    SpriteComponent,
    scrollable_background
  )
  scrollable_list_entity.add_component(ScrollableComponent, scrollable_component)
  args.state.entity_manager.add_entity(scrollable_list_entity)

  100.times do
    animal = Animal.create(path: 'assets/sprites/subi_1.jpg', x: 180, y: 180, w: 125, h: 125, z: 0) do
      puts 'hi caminals2'
    end
    args.state.entity_manager.add_entity(animal)
  end

  args.state.render_system = RenderSystem.new(args.state.entity_manager.entities)
  args.state.scrollable_system = ScrollableSystem.new(args.state.entity_manager)
  args.state.input_system = InputSystem.new(args.state.entity_manager.entities, args.inputs)
end
