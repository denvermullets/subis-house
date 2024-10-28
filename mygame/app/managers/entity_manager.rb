class EntityManager
  attr_accessor :entities

  def initialize
    @entities = []
  end

  def find_by_id(id)
    @entities.find { |entity| entity.id == id }
  end

  # maybe we ad a find_by_group_id?

  # returns array of entities
  def find_by_component(component_class)
    @entities.select { |entity| entity.component?(component_class) }
  end

  def add_entity(entity)
    @entities << entity
  end
end
