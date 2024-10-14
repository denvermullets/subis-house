# player.rb
class Player
  attr_accessor :money, :game_time, :animals, :product_output

  def initialize
    @money = 0
    @game_time = 0
    @animals = []
    @product_output = 0
    @last_update_time = 0
  end

  def update
    current_time = Time.now.to_f
    elapsed_time = current_time - @last_update_time.to_f
    return unless elapsed_time >= 1.0

    @game_time += 1
    update_animals
    collect_products
    @last_update_time = current_time
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
