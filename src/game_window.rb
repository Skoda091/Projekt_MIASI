require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480, false
    self.caption = "Gosu Tutorial Game1"
    @background_image = Gosu::Image.new(self, "../data/graphics/archer.jpg", true)

  end

  def update
  end

  def draw
    @background_image.draw(0, 0, 0)
  end
end

window = GameWindow.new
window.show