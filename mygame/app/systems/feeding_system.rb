# frozen_string_literal: true

# animals get hungry and feed actions happen here
class FeedingSystem
  def update(args)
    animals = args.state.entity_manager.find_by_component(HungerComponent)
    animals.each do |animal|
      hunger = animal.get_component(HungerComponent)
      next unless hunger.is_eating == true

      puts "eating: #{hunger.is_eating}"
      puts "eating: #{hunger.remaining_hunger}"

      hunger.remaining_hunger -= 1
      hunger.is_eating = false if hunger.remaining_hunger <= 0
      # next unless (hunger.remaining_hunger % 2).zero?

      hunger.level -= 1 if hunger.level.positive?
    end
  end

  def feed_animal(id:, args:)
    animal = args.state.entity_manager.find_by_id(id)
    hunger = animal.get_component(HungerComponent)
    # i want a 2 pieces of food for 1 hunger level
    food = args.state.game_state.food
    return if food.zero?
    return if hunger.is_eating == true

    # amount of food needed to replenish to 0 hunger
    max_food_needed = (hunger.level * hunger.replenish_cost)
    puts "max food: #{max_food_needed}"

    if food >= max_food_needed
      # max_food_needed = 200, current_food = 210, remaining_hunger = 100
      args.state.game_state.food -= max_food_needed
      hunger.remaining_hunger = (max_food_needed * hunger.replenish_rate).floor
    else
      hunger.remaining_hunger = (food * hunger.replenish_rate).floor
      args.state.game_state.food -= food
    end
    puts "remaining: #{hunger.remaining_hunger}"

    hunger.is_eating = true
  end

  def load_animals(args)
    args.state.entity_manager.find_by_component(HungerComponent)
  end
end
