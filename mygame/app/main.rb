# main.rb
require 'app/player'
require 'app/animal'
require 'app/modal'

def tick(args)
  args.state.player ||= Player.new
  args.state.modal ||= Modal.new(args)

  args.state.player.update
  args.state.modal.update(args)

  args.state.modal.render(args)
end
