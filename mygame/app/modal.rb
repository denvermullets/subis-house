class Modal
  def initialize(_args)
    @toggle_modal_button = { x: 10, y: 10, w: 300, h: 50, text: 'Open Menu' }
    @purchase_button = { x: 20, y: 110, w: 200, h: 40, text: 'Purchase Animal' }
    @remove_button = { x: 230, y: 110, w: 200, h: 40, text: 'Remove Animals' }
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
    args.outputs.labels << [10, 680, "Money: #{player.money}"]
    args.outputs.labels << [10, 650, "Game Time: #{player.game_time}"]
    args.outputs.labels << [10, 620, "Animals: #{player.animals.count}"]
    args.outputs.labels << [10, 590, "Products: #{player.product_output}"]

    render_button(args, @toggle_modal_button, 29, 234, 207)

    return unless @modal_open

    # background for the modal
    args.outputs.solids << [10, 100, 430, 100, 52, 55, 57]
    render_button(args, @purchase_button, 233, 29, 71)
    render_button(args, @remove_button, 29, 162, 234)
  end

  private

  def click_on_button?(args, button)
    args.inputs.mouse.point.inside_rect? button
  end

  def render_button(args, button, r, g, b)
    args.outputs.solids << [button.values_at(:x, :y, :w, :h), r, g, b]
    args.outputs.labels << [button[:x] + 10, button[:y] + 30, button[:text]]
  end
end
