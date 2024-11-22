# frozen_string_literal: true

# most of the 'economy' methods / systems should go here
class EconomySystem
  def sell_pellets(args)
    pellets = args.state.game_state.pellets

    args.state.game_state.pellets = 0
    args.state.game_state.money += pellets * 2

    args.state.pellet_system.clear_pellets(args)
  end

  def buy_food(args)
    food_base_cost = 4
    current_money = args.state.game_state.money
    return if current_money < food_base_cost

    max_quantity = (current_money / food_base_cost).floor
    total_cost = max_quantity * food_base_cost

    args.state.game_state.money -= total_cost
    args.state.game_state.food += max_quantity
  end
end
