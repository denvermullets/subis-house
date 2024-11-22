# frozen_string_literal: true

# updates the labels in the animal menu modal
class AnimalMenuSystem
  def update(args)
    animal_menus = args.state.entity_manager.find_by_component(AnimalMenuComponent)

    animal_menus.map do |animal_menu|
      id_num = animal_menu.id.split('_').last
      animal = args.state.entity_manager.find_by_id("animal_#{id_num}")
      animal_menu.where(LabelComponent).map do |label|
        process_id(label, animal)
      end
    end
  end

  def process_id(label, animal)
    case label.id
    when :pellets
      label.text = "Pellets: #{animal.get_component(PelletComponent).pellets}"
    when :hunger
      label.text = "Hunger: #{animal.get_component(HungerComponent).level}"
    when :name
      label.text = "Name: #{animal.get_component(NameComponent).name}"
    end
  end
end
