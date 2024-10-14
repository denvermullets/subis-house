class Modal
  def initialize(_args)
    @menu_bg = { x: 40, y: 116, w: 200, h: 260, sprite: 'assets/bg-menu.png' }
    @toggle_modal_button = { x: 40, y: 40, w: 200, h: 60, sprite: 'assets/btn-menu.png' }
    @pause_button = { x: 60, y: 296, w: 160, h: 60, sprite: 'assets/btn-pause.png' }
    @purchase_button = { x: 60, y: 216, w: 160, h: 60, sprite: 'assets/btn-buy-animal.png' }
    @remove_button = { x: 60, y: 136, w: 160, h: 60, sprite: 'assets/btn-sell-animal.png' }
    @stats_background = { x: 40, y: 427, w: 342, h: 253, sprite: 'assets/bg-animal-list.png' }
    @modal_open = false
  end

  def update(args)
    return unless args.inputs.mouse.click

    @modal_open = !@modal_open if click_on_button?(args, @toggle_modal_button)
    return unless @modal_open

    if click_on_button?(args, @purchase_button)
      args.state.player.add_animal
    elsif click_on_button?(args, @remove_button)
      args.state.player.remove_last_animal
    end
  end

  def render(args)
    player = args.state.player
    text_color = [251, 251, 251]
    render_sprite(args, @stats_background)
    args.outputs.labels << [70, 660, "Money: #{player.money}", text_color]
    args.outputs.labels << [70, 630, "Game Time: #{player.game_time}", text_color]
    args.outputs.labels << [70, 600, "Animals: #{player.animals.count}", text_color]
    args.outputs.labels << [70, 570, "Products: #{player.product_output}", text_color]
    render_sprite(args, @toggle_modal_button)

    return unless @modal_open

    render_sprite(args, @menu_bg)
    render_sprite(args, @purchase_button)
    render_sprite(args, @pause_button)
    render_sprite(args, @remove_button)
  end

  private

  def click_on_button?(args, button)
    args.inputs.mouse.point.inside_rect? button
  end

  def render_sprite(args, sprite)
    args.outputs.sprites << [sprite[:x], sprite[:y], sprite[:w], sprite[:h], sprite[:sprite]]
  end
end
