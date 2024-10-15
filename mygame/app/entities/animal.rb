class Animal
  attr_accessor :hunger, :product_output, :production_rate, :name

  def initialize(args)
    @name = "Animal #{args.state.player.animals.count + 1}"
    @hunger = 0
    @product_output = 0
    @production_rate = :gold
    @args = args
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

  def sell(animals)
    animals.delete(self)
  end

  def upgrade_production_rate
    case @production_rate
    when :bronze then @production_rate = :silver
    when :silver then @production_rate = :gold
    end
  end
end
