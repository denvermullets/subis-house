class LabelComponent
  attr_accessor :text, :x, :y, :size, :r, :g, :b, :a, :visible, :size_enum, :id

  def initialize(
    text:, x:, y:, size: 4, r: 255, g: 255, b: 255, a: 255, visible: true, id: nil
  )
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
    @id = id
  end

  def toggle
    @visible = !@visible
  end

  def show
    @visible = true
  end

  def hide
    @visible = false
  end
end
