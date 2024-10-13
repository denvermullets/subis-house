# Main tick method for dialogue options
def tick(args)
  args.outputs.labels << [800, 400, args.state.tick_count]
  if args.state.tick_count == 0
    # Dialogue options represented as squares with text
    args.state.options = [
      { text: 'Option 1: Talk about the weather', x: 100, y: 400, w: 600, h: 50 },
      { text: 'Option 2: Ask about the quest', x: 100, y: 340, w: 600, h: 50 },
      { text: 'Option 3: Say goodbye', x: 100, y: 280, w: 600, h: 50 },
      { text: 'Option 4: Stay silent', x: 100, y: 220, w: 600, h: 50 }
    ]
    args.state.selected_option = nil # No option selected initially
  end

  # Render the dialogue options as rectangles with text
  args.state.options.each_with_index do |option, _index|
    # Render each option rectangle
    args.outputs.solids << [option[:x], option[:y], option[:w], option[:h], 128, 128, 128]

    # Render text for each option
    args.outputs.labels << [option[:x] + 10, option[:y] + 35, option[:text]]
  end

  # Detect mouse clicks on options
  if args.inputs.mouse.click
    mouse_x = args.inputs.mouse.x
    mouse_y = args.inputs.mouse.y

    args.state.options.each do |option|
      next unless mouse_x >= option[:x] && mouse_x <= (option[:x] + option[:w]) &&
                  mouse_y >= option[:y] && mouse_y <= (option[:y] + option[:h])

      # Option selected, store which option was clicked
      args.state.selected_option = option[:text]
    end
  end

  # Display selected option (or none if nothing is selected)
  args.outputs.labels << if args.state.selected_option
                           [20, 100, "You selected: #{args.state.selected_option}"]
                         else
                           [20, 100, 'Select an option...']
                         end
end
