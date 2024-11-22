# frozen_string_literal: true

# handles the instantiation of animals with their click logic for displaying stats
module AnimalMenuDebugFactory
  def self.create_animal(args)
    # find position of existing animals and offset, currently only handling x axis offset for now
    animals = args.state.entity_manager.find_by_component(AnimalComponent)
    sprite = animals.count.zero? ? nil : animals.last.get_component(SpriteComponent)
    modal = ModalComponent.new(visible: false)

    animal_menu = create_animal_menu(args, modal)
    animal = create_animal_instance(args, sprite, modal, animal_menu)

    animal_menu.add_component(
      LabelComponent,
      LabelComponent.new(
        text: "ID: #{animal.id}",
        x: 885,
        y: 280,
        size: 1,
        visible: false,
        id: :animal_id
      )
    )
    animal_menu.add_component(
      LabelComponent,
      LabelComponent.new(
        text: "Name: #{animal.get_component(NameComponent).name}",
        x: 885,
        y: 250,
        size: 1,
        visible: false,
        id: :name
      )
    )
    animal_menu.add_component(
      LabelComponent,
      LabelComponent.new(
        text: 'Hunger: ',
        x: 885,
        y: 220,
        size: 1,
        visible: false,
        id: :hunger
      )
    )
    animal_menu.add_component(
      LabelComponent,
      LabelComponent.new(
        text: 'Pellets: ',
        x: 885,
        y: 190,
        size: 1,
        visible: false,
        id: :pellets
      )
    )

    args.state.entity_manager.add_entity(animal)
    args.state.entity_manager.add_entity(animal_menu)
  end

  def self.create_animal_menu(args, modal)
    AnimalMenuDebug.create(args: args, modal: modal) do |menu|
      toggle_proc(menu, modal).call
    end
  end

  def self.create_animal_instance(args, sprite, modal, animal_menu)
    id_num = args.state.entity_manager.find_by_component(AnimalComponent)&.last&.id&.split('_')&.last.to_i || 0
    Animal.create(
      path: 'assets/sprites/subi_1.jpg', args: args,
      x: sprite.nil? ? 10 : sprite.x + 140, y: 175, w: 125, h: 125, z: 0,
      name: "Animal ##{id_num + 1}"
    ) do
      toggle_proc(animal_menu, modal).call
    end
  end

  def self.toggle_proc(animal_menu, modal)
    lambda do
      # animal_menu.where(ModalComponent).each(&:close)
      animal_menu.where(LabelComponent).each(&:toggle)
      modal.toggle
    end
  end
end