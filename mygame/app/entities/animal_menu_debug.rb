# frozen_string_literal: true

# this sets up the menu when a player clicks on an animal
# get last animal that exists, split by _ and then +1 the number, animal/menu id should share number
# animal_id: animal_12
# animal_menu_id: animal_menu_12
class AnimalMenuDebug
  def self.create(args:, modal:, &on_click)
    id_num = args.state.entity_manager.find_by_component(AnimalComponent)&.last&.id&.split('_')&.last.to_i || 0
    animal_menu = Entity.new(id: "animal_menu_#{id_num + 1}")
    animal_menu.add_component(SpriteComponent, SpriteComponent.new(path: 'assets/bg-menu.png', x: 860, y: 50, w: 380, h: 260))
    animal_menu.add_component(ClickableComponent, ClickableComponent.new(&on_click))
    animal_menu.add_component(ModalComponent, modal)
    animal_menu.add_component(ZComponent, ZComponent.new(z: 0))
    animal_menu.add_component(AnimalMenuComponent, AnimalMenuComponent.new)

    animal_menu
  end
end
