# ui.rb
class UI
  def initialize(_args)
    @purchase_button = { x: 10, y: 410, w: 200, h: 50, text: 'Purchase Animal' }
    @remove_button = { x: 220, y: 410, w: 150, h: 50, text: 'Remove Animals' }
  end

  def update(args)
    return unless args.inputs.mouse.click

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

    args.outputs.solids << [@purchase_button.values_at(:x, :y, :w, :h), 255, 0, 0]
    args.outputs.labels << [@purchase_button[:x] + 10, @purchase_button[:y] + 30, @purchase_button[:text]]

    args.outputs.solids << [@remove_button.values_at(:x, :y, :w, :h), 0, 0, 255]
    args.outputs.labels << [@remove_button[:x] + 10, @remove_button[:y] + 30, @remove_button[:text]]
  end

  private

  def click_on_button?(args, button)
    args.inputs.mouse.point.inside_rect? button
  end
end
