class ScrollableSystem
  def initialize(entity_manager)
    @entity_manager = entity_manager
  end

  def update(args)
    scrollable_entities = @entity_manager.find_by_component(ScrollableComponent)

    scrollable_entities.each do |entity|
      scrollable = entity.get_component(ScrollableComponent)
      handle_input(args, scrollable)
      update_scroll_position(scrollable)
      update_label_positions(args, scrollable)
    end
  end

  private

  def handle_input(args, scrollable)
    return unless mouse_over_scroll_area?(args, scrollable)
    return unless args.inputs.mouse.wheel

    scrollable.target_scroll_position -= args.inputs.mouse.wheel.y * 20
    scrollable.target_scroll_position = scrollable.target_scroll_position.clamp(0, max_scroll(scrollable))
  end

  def update_scroll_position(scrollable)
    scrollable.scroll_position = scrollable.scroll_position.lerp(scrollable.target_scroll_position, 0.1)
  end

  def update_label_positions(args, scrollable)
    animal_entities = @entity_manager.find_by_component(NameComponent)

    visible_range(animal_entities.size, scrollable).each do |index|
      animal_entity = animal_entities[index]
      label = animal_entity.get_component(LabelComponent)
      next unless label

      if name_visible?(index, scrollable)
        label.x = scrollable.scroll_area_x + 10
        label.y = calculate_y_position(index, scrollable)
        label.visible = true
      else
        label.visible = false
      end
    end
  end

  def visible_range(animal_count, scrollable)
    start_index = [(scrollable.scroll_position - scrollable.top_padding) / scrollable.line_height, 0].max.floor
    end_index = [((scrollable.scroll_position + scrollable.scroll_area_height - scrollable.top_padding) / scrollable.line_height).ceil, animal_count - 1].min

    start_index..end_index
  end

  def name_visible?(index, scrollable)
    y_position = calculate_y_position(index, scrollable)
    y_position >= scrollable.scroll_area_y + scrollable.buffer_zone &&
      y_position - scrollable.line_height <= scrollable.scroll_area_y + scrollable.scroll_area_height - scrollable.buffer_zone
  end

  def calculate_y_position(index, scrollable)
    scrollable.scroll_area_y + scrollable.scroll_area_height - ((index + 1) * scrollable.line_height) + scrollable.scroll_position + scrollable.top_padding
  end

  def mouse_over_scroll_area?(args, scrollable)
    args.inputs.mouse.inside_rect? [scrollable.scroll_area_x, scrollable.scroll_area_y, scrollable.scroll_area_width, scrollable.scroll_area_height]
  end

  def max_scroll(scrollable)
    animal_count = @entity_manager.find_by_component(NameComponent).size
    [0, (animal_count * scrollable.line_height) - scrollable.scroll_area_height + scrollable.top_padding].max
  end
end
