# frozen_string_literal: true

# sets up the ScrollableList component
# basic idea is that the list will find all ANIMALS and put their LabelComponent in the list
class ScrollableList
  def self.create_list(args)
    scrollable_list_entity = Entity.new(id: :scrollable_list)
    scrollable_background = SpriteComponent.new(path: 'assets/bg-animal-list.png', x: 900, y: 340, w: 340, h: 340)
    scrollable_component = ScrollableComponent.new(
      scroll_area_x: scrollable_background.x + 20,
      scroll_area_y: scrollable_background.y + 20,
      scroll_area_width: scrollable_background.w - 20,
      scroll_area_height: scrollable_background.h - 20,
      line_height: 30,
      top_padding: 20,
      buffer_zone: 30
    )

    scrollable_list_entity.add_component(
      SpriteComponent,
      scrollable_background
    )
    scrollable_list_entity.add_component(ScrollableComponent, scrollable_component)
    args.state.entity_manager.add_entity(scrollable_list_entity)
  end
end
