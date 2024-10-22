class NameComponent
  attr_accessor :name

  def initialize(name:)
    @name = name
  end

  def update_name(new_name)
    @name = new_name
  end
end
