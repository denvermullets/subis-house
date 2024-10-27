class AnimalComponent
  attr_accessor :quality

  def initialize(quality: nil)
    @quality = quality || quality_types.sample
  end

  def quality_types
    %i[gold silver bronze]
  end
end
