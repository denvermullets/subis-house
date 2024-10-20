class Animal
  def self.create(path:, x:, y:, w:, h:, z: 0, &on_click)
    animal_entity = Entity.new
    animal_name = NameComponent.new(name: "Random Name #{Time.now}")
    animal_entity.add_component(SpriteComponent, SpriteComponent.new(path: path, x: x, y: y, w: w, h: h))
    animal_entity.add_component(NameComponent, animal_name)
    animal_entity.add_component(
      LabelComponent,
      LabelComponent.new(
        text: animal_name.name,
        x: x + 50,
        y: y + 50
      )
    )
    animal_entity.add_component(ClickableComponent, ClickableComponent.new(&on_click))

    animal_entity
  end
end
