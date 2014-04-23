require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 1600, 900, true
    self.caption = "Gosu Tutorial Game1"
    @background_image = Gosu::Image.new(self, "../data/graphics/archer.jpg", true)

  end

  def update
    if button_down? Gosu::KbEscape  then
      close
      end
  end

  def draw
    @background_image.draw(0, 0, 0)
  end
end

def button_down(id)
  if id == Gosu::KbEscape
    close
  end
end
window = GameWindow.new
window.show