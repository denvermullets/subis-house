# frozen_string_literal: true

class InputSystem
  def initialize(entities, inputs)
    @entities = entities
    @inputs = inputs
  end

  def update(args)
    @entities = args.state.entity_manager.entities
    return unless args.inputs.mouse.click

    sprite_click
    label_click
  end

  def sprite_click
    @entities.each do |entity|
      next unless entity.component?(SpriteComponent) && entity.component?(ClickableComponent)
      next if entity.component?(ModalComponent) && entity.get_component(ModalComponent).visible == false

      sprite = entity.get_component(SpriteComponent)
      next unless within_sprite_bounds?(@inputs.mouse.x, @inputs.mouse.y, sprite)

      handle_click(entity)
    end
  end

  def label_click
    @entities.each do |entity|
      next unless entity.component?(LabelComponent) && entity.component?(ClickableComponent)
      next if entity.component?(ModalComponent) && entity.get_component(ModalComponent).visible == false

      label = entity.get_component(LabelComponent)
      next unless within_label_bounds?(@inputs.mouse.x, @inputs.mouse.y, label)

      handle_click(entity)
    end
  end

  def within_sprite_bounds?(mouse_x, mouse_y, sprite)
    mouse_x >= sprite.x && mouse_x <= sprite.x + sprite.w &&
      mouse_y >= sprite.y && mouse_y <= sprite.y + sprite.h
  end

  def within_label_bounds?(mouse_x, mouse_y, label)
    # Calculate label width based on text length and size_enum
    label_width = calculate_text_width(label.text, label.size_enum)
    label_height = calculate_text_height(label.size_enum)  # Height based on size_enum

    # Assume labels are drawn from the bottom-left corner
    mouse_x >= label.x && mouse_x <= label.x + label_width &&
      mouse_y >= label.y && mouse_y <= label.y + label_height
  end

  def calculate_text_width(text, size_enum)
    # rough calculation for text width based on character count and size_enum.
    text.length * 10 * (1 + size_enum / 10.0)
  end

  def calculate_text_height(size_enum)
    20 * (1 + size_enum / 10.0)
  end

  def handle_click(entity)
    clickable = entity.get_component(ClickableComponent)
    clickable.on_click.call(entity)
  end
end
