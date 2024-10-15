require 'app/entities/player'
require 'app/entities/animal'
require 'app/components/modal'
require 'app/components/scrollable_list'
require 'app/systems/game_time'

def tick(args)
  args.state.player ||= Player.new
  args.state.modal ||= Modal.new(args)
  args.state.game_time ||= GameTime.new

  args.state.game_time.progress_time(args)
  args.state.modal.update(args)

  args.state.modal.render(args)
end
