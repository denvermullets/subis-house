require 'app/managers/entity_manager'
require 'app/entities/entity'
require 'app/entities/debug'
require 'app/entities/animal'
require 'app/entities/animal_menu_debug'
require 'app/entities/modal_menu'
require 'app/entities/button'
require 'app/entities/scrollable_list'
require 'app/factories/animal_menu_debug_factory'
require 'app/components/animal_menu_component'
require 'app/components/game_state_component'
require 'app/components/hunger_component'
require 'app/components/name_component'
require 'app/components/sprite_component'
require 'app/components/z_component'
require 'app/components/label_component'
require 'app/components/clickable_component'
require 'app/components/modal_component'
require 'app/components/scrollable_component'
require 'app/components/time_component'
require 'app/components/animal_component'
require 'app/components/pellet_component'
require 'app/systems/render_system'
require 'app/systems/hunger_system'
require 'app/systems/scrollable_system'
require 'app/systems/input_system'
require 'app/systems/time_system'
require 'app/systems/debug_info_system'
require 'app/systems/pellet_system'
require 'app/systems/animal_menu_system'
require 'app/systems/economy_system'
require 'app/systems/feeding_system'

def tick(args)
  args.labels << { x: 20, y: 700, text: "#{args.inputs.mouse.x} - #{args.inputs.mouse.y}", r: 0, g: 0, b: 0 }
  init(args) if args.state.tick_count.zero?

  args.state.input_system.update(args)
  args.state.scrollable_system.update(args)
  args.state.time_system.progress_time(args)
  args.state.debug_info.update(args)
  args.state.animal_menu_system.update(args)
  args.state.render_system.render_outputs(args)
end

def init(args)
  args.state.entity_manager ||= EntityManager.new
  args.state.game_state ||= GameStateComponent.new
  args.state.economy_system ||= EconomySystem.new
  args.state.pellet_system ||= PelletSystem.new
  args.state.hunger_system ||= HungerSystem.new
  args.state.feeding_system ||= FeedingSystem.new
  args.state.game_time ||= TimeComponent.new
  args.state.animal_menu_system ||= AnimalMenuSystem.new
  args.state.time_system ||= TimeSystem.new(args.state.game_time)

  ModalMenu.new.create_modal(args)
  ScrollableList.create_list(args)
  Debug.create(args)

  args.state.input_system = InputSystem.new(args.state.entity_manager.entities, args.inputs)
  args.state.scrollable_system = ScrollableSystem.new(args.state.entity_manager)
  args.state.debug_info = DebugInfoSystem.new
  args.state.render_system = RenderSystem.new(args.state.entity_manager.entities)
end
