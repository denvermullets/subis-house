class AnimalModal
  def initialize(_args)
    @menu_bg = { x: 1040, y: 40, w: 200, h: 260, sprite: 'assets/bg-animal-options.png' }
    @btn_rename = { x: 1060, y: 220, w: 160, h: 60, sprite: 'assets/btn-rename.png' }
    @btn_pet = { x: 1060, y: 140, w: 160, h: 60, sprite: 'assets/btn-pet.png' }
    @btn_sell = { x: 1060, y: 60, w: 160, h: 60, sprite: 'assets/btn-sell.png' }
    @modal_open = false
    @selected_animal = nil
  end

  def open(animal)
    @selected_animal = animal
    @modal_open = true
  end

  def update(args)
    return unless @modal_open && args.inputs.mouse.click

    if click_on_button?(args, @btn_sell)
      args.state.player.sell_animal(@selected_animal)
      @modal_open = false
    elsif click_on_button?(args, @btn_rename)
      puts 'do nothing'
    elsif click_on_button?(args, @btn_pet)
      puts 'do nothing 2'
    end
  end

  def render(args)
    return unless @modal_open

    render_sprites(args, [@menu_bg, @btn_rename, @btn_pet, @btn_sell])
  end

  private

  def click_on_button?(args, button)
    args.inputs.mouse.point.inside_rect? button
  end

  def render_sprite(args, sprite)
    args.outputs.sprites << [sprite[:x], sprite[:y], sprite[:w], sprite[:h], sprite[:sprite]]
  end

  def render_sprites(args, sprites)
    sprites.map do |sprite|
      args.outputs.sprites << [sprite[:x], sprite[:y], sprite[:w], sprite[:h], sprite[:sprite]]
    end
  end
end
