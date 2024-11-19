class HealthComponent
  attr_accessor :health_level, :illness, :illness_type, :recovery_time

  def initialize
    @health_level = 100
    @illness = nil
    @illness_type = nil
    @recovery_time = nil
  end
end
