class ModalMenu
  def self.create_modal
    parent_modal_component = ModalComponent.new(visible: false)

    btn_menu = Button.create_button(path: 'assets/btn-menu.png', x: 40, y: 40, w: 200, h: 60) do
      puts 'expand menu'
      parent_modal_component.toggle
    end

    bg_modal = Entity.new(id: :modal_menu)

    bg_modal.add_component(SpriteComponent, SpriteComponent.new(path: 'assets/bg-menu.png', x: 40, y: 116, w: 380, h: 260))
    bg_modal.add_component(ModalComponent, parent_modal_component)

    btn_pause = Button.create_button(path: 'assets/btn-pause.png', x: 60, y: 296, w: 160, h: 60) do
      puts 'button pause'
      parent_modal_component.toggle
    end
    btn_pause.add_component(ModalComponent, parent_modal_component)

    btn_buy_animal = Button.create_button(path: 'assets/btn-buy-animal.png', x: 60, y: 136, w: 160, h: 60) do
      puts 'button buy animal'
      parent_modal_component.toggle
    end
    btn_buy_animal.add_component(ModalComponent, parent_modal_component)

    [btn_menu, bg_modal, btn_pause, btn_buy_animal]
  end
end
