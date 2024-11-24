# frozen_string_literal: true

# each subi generates pellets according to their own stats
# based on quality, other modifiers will go here as well
class PelletSystem
  def update(args)
    animals = load_animals(args)
    animals.each do |entity|
      pellet_comp = entity.get_component(PelletComponent)
      animal_entity = entity.get_component(AnimalComponent)
      # check hunger level and skip accrual if animal is starving
      hunger_comp = entity.get_component(HungerComponent)
      next if hunger_comp.level == 100

      pellet_comp.last_generated += 1
      next unless pellet_comp.last_generated >= pellet_comp.production_rate

      pellet_comp.pellets += generate_pellets(animal_entity.quality, hunger_comp.level)
      args.state.game_state.pellets += generate_pellets(animal_entity.quality, hunger_comp.level)
      pellet_comp.last_generated = 0
    end
  end

  def clear_pellets(args)
    animals = load_animals(args)

    animals.each do |animal|
      pellet_comp = animal.get_component(PelletComponent)

      pellet_comp.pellets = 0
    end
  end

  private

  def load_animals(args)
    args.state.entity_manager.find_by_component(PelletComponent)
  end

  def generate_pellets(quality, hunger)
    # could add a linear decrease in production as hunger rises
    types = { gold: 8, silver: 4, bronze: 2 }
    hunger >= 50 ? types[quality] / 2 : types[quality]
  end
end
