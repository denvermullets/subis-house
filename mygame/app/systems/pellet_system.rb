# on each predefined time advancement, each subi will generate their own pellets
# based on quality, other modifiers will go here as well

class PelletSystem
  def update(args)
    animals = args.state.entity_manager.find_by_component(PelletComponent)

    animals.each do |animal|
      # next unless animal.component?()

      pellet_comp = animal.get_component(PelletComponent)
      quality = animal.get_component(AnimalComponent).quality

      pellet_comp.pellets += generate_pellets(quality)
    end
  end

  def generate_pellets(quality)
    types = { gold: 3, silver: 2, bronze: 1 }
    types[quality]
  end
end
