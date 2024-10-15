class Animal
  attr_accessor :hunger, :product_output, :production_rate, :name

  def initialize
    @name = Time.now.to_s
    @hunger = 0
    @product_output = 0
    @production_rate = :gold
  end

  def update
    @hunger += 1
    produce
  end

  def produce
    production_rate = { bronze: 1, silver: 2, gold: 5 }

    @product_output += production_rate[@production_rate]
  end

  def collect_product
    output = @product_output
    @product_output = 0
    output
  end

  def feed
    @hunger = 0
  end

  def upgrade_production_rate
    case @production_rate
    when :bronze then @production_rate = :silver
    when :silver then @production_rate = :gold
    end
  end
end
