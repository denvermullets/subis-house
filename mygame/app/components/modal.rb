class Modal
  def initialize(args)
    @menu_bg = { x: 40, y: 116, w: 380, h: 260, sprite: 'assets/bg-menu.png' }
    @debug_bg = { x: 40, y: 430, w: 340, h: 250, sprite: 'assets/bg-debug.png' }
    @animal_options = { x: 900, y: 340, w: 340, h: 340, sprite: 'assets/bg-animal-list.png' }

    @menu = { x: 40, y: 40, w: 200, h: 60, sprite: 'assets/btn-menu.png' }

    @pause_button = { x: 60, y: 296, w: 160, h: 60, sprite: 'assets/btn-pause.png' }
    @buy_animal = { x: 60, y: 216, w: 160, h: 60, sprite: 'assets/btn-buy-animal.png' }
    @visit_work = { x: 60, y: 136, w: 160, h: 60, sprite: 'assets/btn-work.png' }
    @sell_product = { x: 240, y: 296, w: 160, h: 60, sprite: 'assets/btn-sell-product.png' }
    @buy_food = { x: 240, y: 216, w: 160, h: 60, sprite: 'assets/btn-buy-food.png' }
    @leave_work = { x: 240, y: 136, w: 160, h: 60, sprite: 'assets/btn-leave-work.png' }

    # @sell_animal = { x: 60, y: 136, w: 160, h: 60, sprite: 'assets/btn-sell.png' }

    @modal_open = false
    @scrollable_list = ScrollableList.new(
      args, [], {
        x: @animal_options[:x] + 20,
        y: @animal_options[:y] + 20,
        width: @animal_options[:w] - 20,
        height: @animal_options[:h] - 20,
        line_height: 30,
        top_padding: 20,
        buffer_zone: 30
      }
    )
  end

  def update(args)
    return unless args.inputs.mouse.click

    @modal_open = !@modal_open if click_on_button?(args, @menu)
    return unless @modal_open

    determine_click(args)
  end

  def render(args)
    render_sprites(args, [@debug_bg, @animal_options])
    @scrollable_list.update_names(args.state.player.animals.map(&:name))
    @scrollable_list.tick

    args.outputs.labels << { x: 70, y: 660, text: "Money: #{args.state.player.money}", r: 251, g: 251, b: 251 }
    args.outputs.labels << { x: 70, y: 630, text: "Game Time: #{args.state.game_time.current_game_time}", r: 251, g: 251, b: 251 }
    args.outputs.labels << { x: 70, y: 600, text: "Total Game Time: #{args.state.game_time.total_time}", r: 251, g: 251, b: 251 }
    args.outputs.labels << { x: 70, y: 570, text: "Animals: #{args.state.player.animals.count}", r: 251, g: 251, b: 251 }
    args.outputs.labels << { x: 70, y: 540, text: "Products: #{args.state.player.product_output}", r: 251, g: 251, b: 251 }
    render_sprite(args, @menu)

    return unless @modal_open

    render_sprites(args, [@menu_bg, @buy_animal, @pause_button, @visit_work, @buy_food, @leave_work, @sell_product])
  end

  private

  def determine_click(args)
    if click_on_button?(args, @buy_animal)
      args.state.player.add_animal
    elsif click_on_button?(args, @sell_animal)
      args.state.player.remove_last_animal
    elsif click_on_button?(args, @pause_button)
      args.state.game_time.pause
    end
  end

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
