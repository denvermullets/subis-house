# frozen_string_literal: true

# handles the instantiation of animals
module AnimalFactory
  def self.create_animal(args)
    # find position of existing animals and offset
    # currently only handling x axis offset for now
    animals = args.state.entity_manager.find_by_component(AnimalComponent)
    sprite = animals.count.zero? ? nil : animals.last.get_component(SpriteComponent)

    animal = Animal.create(
      path: 'assets/sprites/subi_1.jpg', args: args,
      x: sprite.nil? ? 10 : sprite.x + 140, y: 175, w: 125, h: 125, z: 0,
      name: "Random Name #{Random.rand(1000)}"
    ) do
      puts 'hi caminals'
    end

    args.state.entity_manager.add_entity(animal)
  end
end
