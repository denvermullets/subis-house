# on each predefined time advancement, each subi will generate their own pellets
# based on quality, other modifiers will go here as well

class PelletSystem
  def update(args)
    animals = load_animals(args)

    animals.each do |animal|
      pellet_comp = animal.get_component(PelletComponent)
      quality = animal.get_component(AnimalComponent).quality

      pellet_comp.pellets += generate_pellets(quality)
      args.state.game_state.pellets += generate_pellets(quality)
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

  def generate_pellets(quality)
    types = { gold: 1.5, silver: 1, bronze: 0.5 }
    types[quality]
  end
end
