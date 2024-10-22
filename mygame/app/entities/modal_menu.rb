class ModalMenu
  def initialize(args)
    @args = args
  end

  def create_modal
    @parent_modal_component = ModalComponent.new(visible: false)

    # main menu button - always visible
    btn_menu = Button.create_button(path: 'assets/btn-menu.png', x: 40, y: 40, w: 200, h: 60) do
      puts 'expand menu'
      @parent_modal_component.toggle
    end

    entities = [
      btn_menu, bg_modal, btn_pause, btn_buy_animal, btn_visit_work, btn_sell_product, btn_buy_food, btn_leave_work
    ]

    entities.each do |entity|
      @args.state.entity_manager.add_entity(entity)
    end
  end

  def bg_modal
    bg_modal = Entity.new(id: :modal_menu)
    bg_modal.add_component(SpriteComponent, SpriteComponent.new(path: 'assets/bg-menu.png', x: 40, y: 116, w: 380, h: 260))
    bg_modal.add_component(ModalComponent, @parent_modal_component)
    bg_modal.add_component(ZComponent, ZComponent.new(z: 100))

    bg_modal
  end

  def btn_pause
    btn = Button.create_button(path: 'assets/btn-pause.png', x: 60, y: 296, w: 160, h: 60, z: 101) do
      puts 'button pause'
      @parent_modal_component.toggle
    end
    btn.add_component(ModalComponent, @parent_modal_component)

    btn
  end

  def btn_buy_animal
    btn = Button.create_button(path: 'assets/btn-buy-animal.png', x: 60, y: 216, w: 160, h: 60, z: 101) do
      puts 'button buy animal'
      @args.state.entity_manager.add_entity(
        Animal.create(path: 'assets/sprites/subi_1.jpg', x: 180, y: 180, w: 125, h: 125, z: 0) do
          puts 'hi caminals'
        end
      )
      @parent_modal_component.toggle
    end
    btn.add_component(ModalComponent, @parent_modal_component)

    btn
  end

  def btn_visit_work
    btn = Button.create_button(path: 'assets/btn-work.png', x: 60, y: 136, w: 160, h: 60, z: 101) do
      puts 'visit work'
      @parent_modal_component.toggle
    end
    btn.add_component(ModalComponent, @parent_modal_component)

    btn
  end

  def btn_sell_product
    btn = Button.create_button(path: 'assets/btn-sell-product.png', x: 240, y: 296, w: 160, h: 60, z: 101) do
      puts 'visit work'
      @parent_modal_component.toggle
    end
    btn.add_component(ModalComponent, @parent_modal_component)

    btn
  end

  def btn_buy_food
    btn = Button.create_button(path: 'assets/btn-buy-food.png', x: 240, y: 216, w: 160, h: 60, z: 101) do
      puts 'buyfood'
      @parent_modal_component.toggle
    end
    btn.add_component(ModalComponent, @parent_modal_component)

    btn
  end

  def btn_leave_work
    btn = Button.create_button(path: 'assets/btn-leave-work.png', x: 240, y: 136, w: 160, h: 60, z: 101) do
      puts 'leave work'
      @parent_modal_component.toggle
    end
    btn.add_component(ModalComponent, @parent_modal_component)

    btn
  end
end