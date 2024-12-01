# frozen_string_literal: true

# main modal menu for game actions
class ModalMenu
  def create_modal(args)
    @parent_modal_component = ModalComponent.new(visible: false)

    # main menu button - always visible
    btn_menu = Button.create_button(path: 'assets/btn-menu.png', x: 40, y: 40, w: 200, h: 60) do
      puts 'expand menu'
      @parent_modal_component.toggle
    end

    args.state.entity_manager.add_entity(btn_menu)
    create_entities(args)
  end

  def create_entities(args)
    bg_modal(args)
    btn_pause(args)
    btn_buy_animal(args)
    btn_visit_work(args)
    btn_sell_product(args)
    btn_buy_food(args)
    btn_leave_work(args)
  end

  def bg_modal(args)
    bg_modal = Entity.new(id: :modal_menu)
    bg_modal.add_component(SpriteComponent, SpriteComponent.new(path: 'assets/bg-menu.png', x: 40, y: 116, w: 380, h: 260))
    bg_modal.add_component(ModalComponent, @parent_modal_component)
    bg_modal.add_component(ZComponent, ZComponent.new(z: 100))

    args.state.entity_manager.add_entity(bg_modal)
  end

  def btn_pause(args)
    btn = Button.create_button(path: 'assets/btn-pause.png', x: 60, y: 296, w: 160, h: 60, z: 101) do
      args.state.time_system.pause
      @parent_modal_component.toggle
    end
    btn.add_component(ModalComponent, @parent_modal_component)

    args.state.entity_manager.add_entity(btn)
  end

  def btn_buy_animal(args)
    btn = Button.create_button(path: 'assets/btn-buy-animal.png', x: 60, y: 216, w: 160, h: 60, z: 101) do
      puts 'button buy animal'
      btn_buy_animal_click(args)
      @parent_modal_component.toggle
    end
    btn.add_component(ModalComponent, @parent_modal_component)

    args.state.entity_manager.add_entity(btn)
  end

  def btn_buy_animal_click(args)
    # check if player has money and charge them for buying animal
    if args.state.entity_manager.find_by_component(AnimalComponent).count.zero?
      puts 'free animal'
      AnimalMenuDebugFactory.create_animal(args)
    elsif args.state.game_state.money >= 500
      puts 'expensive animal'
      args.state.game_state.money -= 500
      AnimalMenuDebugFactory.create_animal(args)
    end
  end

  def btn_visit_work(args)
    btn = Button.create_button(path: 'assets/btn-work.png', x: 60, y: 136, w: 160, h: 60, z: 101) do
      puts 'visit work'
      @parent_modal_component.toggle
    end
    btn.add_component(ModalComponent, @parent_modal_component)

    args.state.entity_manager.add_entity(btn)
  end

  def btn_sell_product(args)
    btn = Button.create_button(path: 'assets/btn-sell-product.png', x: 240, y: 296, w: 160, h: 60, z: 101) do
      puts 'sold product'
      args.state.economy_system.sell_pellets(args)
      @parent_modal_component.toggle
    end
    btn.add_component(ModalComponent, @parent_modal_component)

    args.state.entity_manager.add_entity(btn)
  end

  def btn_buy_food(args)
    btn = Button.create_button(path: 'assets/btn-buy-food.png', x: 240, y: 216, w: 160, h: 60, z: 101) do
      puts 'buyfood'
      args.state.economy_system.buy_food(args)
      @parent_modal_component.toggle
    end
    btn.add_component(ModalComponent, @parent_modal_component)

    args.state.entity_manager.add_entity(btn)
  end

  def btn_leave_work(args)
    btn = Button.create_button(path: 'assets/btn-leave-work.png', x: 240, y: 136, w: 160, h: 60, z: 101) do
      puts 'leave work'
      @parent_modal_component.toggle
    end
    btn.add_component(ModalComponent, @parent_modal_component)

    args.state.entity_manager.add_entity(btn)
  end
end
