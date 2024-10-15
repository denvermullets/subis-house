require 'app/entities/player'
require 'app/entities/animal'
require 'app/components/modal'
require 'app/components/animal_modal'
require 'app/components/scrollable_list'
require 'app/systems/game_time'

def tick(args)
  args.outputs.labels << [10, 720, "Mouse: #{args.inputs.mouse.x}, #{args.inputs.mouse.y}", 0, 0, 0]
  args.state.player ||= Player.new(args)
  args.state.modal ||= Modal.new(args)
  args.state.animal_modal ||= AnimalModal.new(args)
  args.state.game_time ||= GameTime.new

  args.state.game_time.progress_time(args)
  args.state.modal.update(args)
  args.state.animal_modal.update(args)

  args.state.modal.render(args)
  args.state.animal_modal.render(args)
end
