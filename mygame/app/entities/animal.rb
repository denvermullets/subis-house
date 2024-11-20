# frozen_string_literal: true

# core Subi class
class Animal
  # rubocop:disable Metrics/ParameterLists
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def self.create(args:, path:, x:, y:, w:, h:, z: 0, name:, &on_click)
    animal_name = NameComponent.new(name: name)
    animal_entity = Entity.new(id: animal_name.name)
    animal_entity.add_component(SpriteComponent, SpriteComponent.new(path: path, x: x, y: y, w: w, h: h))
    animal_entity.add_component(NameComponent, animal_name)
    animal_entity.add_component(
      LabelComponent,
      LabelComponent.new(
        text: animal_name.name,
        x: x,
        y: y,
        size: 1,
        visible: false
      )
    )
    animal_entity.add_component(ClickableComponent, ClickableComponent.new(&on_click))
    animal_entity.add_component(ZComponent, ZComponent.new(z: z))
    animal_entity.add_component(AnimalComponent, AnimalComponent.new)
    animal_entity.add_component(PelletComponent, PelletComponent.new)
    animal_entity.add_component(HungerComponent, HungerComponent.new)

    args.state.game_state.total_animals += 1
    animal_entity
  end
  # rubocop:enable Metrics/ParameterLists
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
end
