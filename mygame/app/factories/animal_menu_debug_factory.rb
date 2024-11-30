# frozen_string_literal: true

# handles the instantiation of animals with their click logic for displaying stats
module AnimalMenuDebugFactory
  def self.create_animal(args)
    animals = args.state.entity_manager.find_by_component(AnimalComponent)
    return if animals.count >= 12

    modal = ModalComponent.new(visible: false)
    plots = determine_plot(animals)
    animal_menu = create_animal_menu(args, modal)
    animal = create_animal_instance(args, plots, modal, animal_menu)

    x = 920
    animal_menu.add_component(
      LabelComponent,
      LabelComponent.new(
        text: "ID: #{animal.id}", x: x, y: 660, size: 1, visible: false, id: :animal_id
      )
    )
    animal_menu.add_component(
      LabelComponent,
      LabelComponent.new(
        text: 'Name: ', x: x, y: 630, size: 1, visible: false, id: :name
      )
    )
    animal_menu.add_component(
      LabelComponent,
      LabelComponent.new(
        text: 'Hunger: ', x: x, y: 600, size: 1, visible: false, id: :hunger
      )
    )
    animal_menu.add_component(
      LabelComponent,
      LabelComponent.new(
        text: 'Pellets: ', x: x, y: 570, size: 1, visible: false, id: :pellets
      )
    )
    animal_menu.add_component(
      LabelComponent,
      LabelComponent.new(
        text: "Quality: #{animal.get_component(AnimalComponent).quality}",
        x: x, y: 540, size: 1, visible: false, id: :quality
      )
    )

    args.state.entity_manager.add_entity(animal)
    args.state.entity_manager.add_entity(animal_menu)
  end

  def self.create_animal_menu(args, modal)
    AnimalMenuDebug.create(args: args, modal: modal) do |menu|
      # toggle_proc(menu, modal, args).call
    end
  end

  def self.create_animal_instance(args, plots, modal, animal_menu)
    animals = args.state.entity_manager.find_by_component(AnimalComponent)
    id_num = animals&.last&.id&.split('_')&.last.to_i || 0

    Animal.create(
      path: 'assets/sprites/subi_1.jpg', args: args,
      x: plots[:x], y: plots[:y], w: 125, h: 125, z: 0,
      name: "Animal ##{id_num + 1}"
    ) do
      toggle_proc(animal_menu, modal, args).call
    end
  end

  def self.determine_plot(animals)
    # 2 rows of 6 animals allowed currently
    sprite = animals.count.zero? ? nil : animals.last.get_component(SpriteComponent)
    return { x: 430, y: 150 } if sprite.nil?
    return { x: 430, y: 10 } if animals.count == 6

    if (animals.count + 1) <= 6
      { x: (animals.count * 140) + 430, y: 150 }
    elsif animals.count + 1 > 6
      { x: ((animals.count - 6) * 140) + 430, y: 10 }
    end
  end

  def self.toggle_proc(animal_menu, modal, args)
    lambda do
      # get current state before closing all modals / labels, then toggle
      modal_visible = modal.visible
      entities = args.state.entity_manager.find_by_component(AnimalMenuComponent)

      entities.each do |entity|
        entity.where(ModalComponent).each(&:close)
        entity.where(LabelComponent).each(&:hide)
      end

      if modal_visible == true
        modal.close
        animal_menu.where(LabelComponent).each(&:hide)
      else
        modal.open
        animal_menu.where(LabelComponent).each(&:show)
      end
    end
  end
end
