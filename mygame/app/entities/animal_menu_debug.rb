# frozen_string_literal: true

# this sets up the menu when a player clicks on an animal
# requires taking in an animal_entity
class AnimalMenuDebug
  # rubocop:disable Metrics/MethodLength
  def self.create(args:, modal:, &on_click)
    animal_menu = Entity.new(id: 'animal_menu_id')
    animal_menu.add_component(SpriteComponent, SpriteComponent.new(path: 'assets/bg-menu.png', x: 860, y: 50, w: 380, h: 260))
    # x: 860, y: 50
    # animal_menu.add_component(
    #   LabelComponent,
    #   LabelComponent.new(
    #     text: 'label 1',
    #     x: 885,
    #     y: 280,
    #     size: 1,
    #     visible: false
    #   )
    # )
    # animal_menu.add_component(
    #   LabelComponent,
    #   LabelComponent.new(
    #     text: 'label 2',
    #     x: 550,
    #     y: 570,
    #     size: 1,
    #     visible: false
    #   )
    # )
    animal_menu.add_component(ClickableComponent, ClickableComponent.new(&on_click))
    animal_menu.add_component(ModalComponent, modal)
    animal_menu.add_component(ZComponent, ZComponent.new(z: 0))

    animal_menu
  end
  # rubocop:enable Metrics/MethodLength
end
