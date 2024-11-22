# this system will sort labels and sprites by zIndex and then render them
# sprites render first, then labels

class RenderSystem
  def initialize(entities)
    @entities = entities
  end

  def render_outputs(args)
    @entities = args.state.entity_manager.entities
    render_sprites(args)
    render_labels(args)
  end

  private

  def render_sprites(args)
    sort_sprites.each do |entity|
      if entity.component?(ModalComponent)
        modal = entity.get_component(ModalComponent)
        next unless modal.visible
      end

      sprite = entity.get_component(SpriteComponent)
      args.outputs.sprites << { x: sprite.x, y: sprite.y, w: sprite.w, h: sprite.h, path: sprite.path }
    end
  end

  def render_labels(args)
    sort_labels.each do |entity|
      label = entity.where(LabelComponent)
      label.each do |single_label|
        next unless single_label.visible

        args.outputs.labels << {
          x: single_label.x,
          y: single_label.y,
          text: single_label.text,
          size_enum: single_label.size,
          r: single_label.r,
          g: single_label.g,
          b: single_label.b,
          a: single_label.a
        }
      end
    end
  end

  def sort_sprites
    sprite_entities = @entities.select { |entity| entity.component?(SpriteComponent) }

    # sort both by z-index, or default to 0 if ZComponent is missing
    sprite_entities.sort_by do |entity|
      entity.component?(ZComponent) ? entity.get_component(ZComponent).z : 0
    end
  end

  def sort_labels
    label_entities = @entities.select { |entity| entity.component?(LabelComponent) }

    label_entities.sort_by do |entity|
      entity.component?(ZComponent) ? entity.get_component(ZComponent).z : 0
    end
  end
end
