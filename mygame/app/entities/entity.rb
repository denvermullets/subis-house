# frozen_string_literal: true

# main entity for the game
# example usage:
### player_entity = Entity.new
### player_entity.add_component(
###   SpriteComponent, SpriteComponent.new(path: 'sprites/square/blue.png', x: 100, y: 100, w: 50, h: 50))
class Entity
  attr_accessor :components, :id

  def initialize(id: nil)
    @components = Hash.new { |hash, key| hash[key] = [] }
    @id = id
  end

  def add_component(type, component)
    @components[type] << component
  end

  def get_component(type)
    @components[type].first
  end

  # get_all_components by type in entity
  def where(type)
    @components[type]
  end

  def component?(type)
    @components.key?(type) && !@components[type].empty?
  end

  def remove_component(type, component)
    @components[type].delete(component)
  end
end
