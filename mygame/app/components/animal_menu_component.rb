# frozen_string_literal: true

# component that lets us tell when to kick elements to the modal renderer
class AnimalMenuComponent
  attr_accessor :visible

  def initialize
    @visible = true
  end
end
