class Player
  attr_accessor :money, :animals, :product_output

  def initialize
    @money = 0
    @animals = []
    @product_output = 0
  end

  def add_animal
    @animals << Animal.new
  end

  def remove_last_animal
    @animals.pop
  end

  def update_animals
    @animals.each(&:update)
  end

  def collect_products
    @animals.each do |animal|
      @product_output += animal.collect_product
    end
  end
end
