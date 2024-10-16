class Player
  attr_accessor :money, :animals, :product_output

  def initialize(args)
    @money = 0
    @animals = []
    @product_output = 0
    @args = args
  end

  def add_animal
    @animals << Animal.new(@args)
  end

  def sell_animal(animal)
    @money += 5
    animal.sell(@animals)
  end

  def update_animals
    @animals.each(&:update)
  end

  def sell_product
    value = @product_output * 8
    @product_output = 0
    @money += value
  end

  def collect_products
    @animals.each do |animal|
      @product_output += animal.collect_product
    end
  end
end
