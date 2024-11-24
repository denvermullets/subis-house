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

    btn = Button.create_button(path: 'assets/btn-pause.png', x: 860, y: 50, w: 160, h: 60, z: 101) do
      args.state.feeding_system.feed_animal(id: "animal_#{id_num + 1}", args: args)
      toggle_menus(menu: animal_menu, modal: modal, args: args)
      puts 'buttson'
    end
    btn.add_component(ModalComponent, modal)

    args.state.entity_manager.add_entity(btn)

    animal_menu
  end

  def self.toggle_menus(menu:, modal:, args:)
    # get current state before closing all modals / labels, then toggle
    modal_visible = modal.visible
    entities = args.state.entity_manager.find_by_component(AnimalMenuComponent)
    close_modals(entities)

    if modal_visible == true
      modal.close
      menu.where(LabelComponent).each(&:hide)
    else
      modal.open
      menu.where(LabelComponent).each(&:show)
    end
  end

  def self.close_modals(entities)
    entities.each do |entity|
      entity.where(ModalComponent).each(&:close)
      entity.where(LabelComponent).each(&:hide)
    end
  end
end
