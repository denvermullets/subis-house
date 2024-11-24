# frozen_string_literal: true

# animals get hungry and it progresses here
class HungerSystem
  def update(args)
    animals = load_animals(args)
    animals.map do |animal_entity|
      hunger = animal_entity.get_component(HungerComponent)
      next if hunger.is_eating == true

      verify_hunger(hunger)
    end
  end

  def verify_hunger(hunger)
    # seconds for each hunger tick
    hunger_time = 5
    if hunger.last_updated >= hunger_time
      update_hunger(hunger)

      hunger.last_updated = 0
    else
      hunger.last_updated += 1
    end
  end

  def update_hunger(hunger)
    if hunger.level >= 100
      # animal is STARVING
      # kick off pass out mechanic
    else
      hunger.level += hunger.rate
    end
  end

  def load_animals(args)
    args.state.entity_manager.find_by_component(HungerComponent)
  end
end
