class LabelComponent
  attr_accessor :text, :x, :y, :size, :r, :g, :b, :a, :visible, :size_enum

  def initialize(text:, x:, y:, size: 4, r: 255, g: 255, b: 255, a: 255, visible:)
    @text = text
    @x = x
    @y = y
    @size = size
    @r = r
    @g = g
    @b = b
    @a = a
    @visible = visible
    @size_enum = @size
  end
end