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
require 'app/entities/scrollable_list'

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
  ScrollableList.create_list(args)

  args.state.render_system = RenderSystem.new(args.state.entity_manager.entities)
  args.state.scrollable_system = ScrollableSystem.new(args.state.entity_manager)
  args.state.input_system = InputSystem.new(args.state.entity_manager.entities, args.inputs)
end
