class EconomySystem
  def sell_pellets(args)
    pellets = args.state.game_state.pellets

    args.state.game_state.pellets = 0
    args.state.game_state.money += pellets * 0.5

    args.state.pellet_system.clear_pellets(args)
  end
end
