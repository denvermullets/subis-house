#  frozen_string_literal: true

# this modal component keeps track of if the parent entity should be visible or not
# originally used for modals but has expanded to other things
class ModalComponent
  attr_accessor :visible, :buttons

  def initialize(visible: false)
    @visible = visible
  end

  def toggle
    @visible = !@visible
  end

  def close
    @visible = false
  end

  def closed?
    @visible == false
  end

  def open
    @visible = true
  end

  def open?
    @visible == true
  end
end
