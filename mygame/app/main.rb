# main.rb
require 'app/player'
require 'app/animal'
require 'app/ui'

def tick(args)
  args.state.player ||= Player.new
  args.state.ui ||= UI.new(args)

  args.state.player.update
  args.state.ui.update(args)

  args.state.ui.render(args)
end
