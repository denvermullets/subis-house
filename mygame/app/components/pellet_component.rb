class PelletComponent
  attr_accessor :pellets, :last_generated, :production_rate

  def initialize
    @pellets = 0
    @last_generated = 0
    @production_rate = 3
  end
end
