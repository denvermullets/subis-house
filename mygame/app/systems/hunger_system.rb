# frozen_string_literal: true

# animals get hungry and it progresses here
class HungerSystem
  def update(args)
    animals = load_animals(args)
    animals.map do |animal_entity|
      animal = animal_entity.get_component(HungerComponent)
      if animal.level >= 100
        # animal is STARVING
        # kick off pass out mechanic
      else
        animal.level += animal.rate
      end
    end
  end

  def load_animals(args)
    args.state.entity_manager.find_by_component(HungerComponent)
  end
end
