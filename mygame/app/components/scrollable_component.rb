class ScrollableComponent
  attr_accessor :scroll_area_x, :scroll_area_y, :scroll_area_width, :scroll_area_height,
                :line_height, :top_padding, :buffer_zone, :scroll_position, :target_scroll_position

  def initialize(scroll_area_x:, scroll_area_y:, scroll_area_width:, scroll_area_height:, line_height:, top_padding:, buffer_zone:)
    @scroll_area_x = scroll_area_x
    @scroll_area_y = scroll_area_y
    @scroll_area_width = scroll_area_width
    @scroll_area_height = scroll_area_height
    @line_height = line_height
    @top_padding = top_padding
    @buffer_zone = buffer_zone
    @scroll_position = 0
    @target_scroll_position = 0
  end
end
