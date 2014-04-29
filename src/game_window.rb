require 'gosu'

load '../src/classes/unit.rb'


class GameWindow < Gosu::Window
  def initialize
    @z=0
    super 1600, 900, true
    self.caption = "Gosu Tutorial Game1"
    @background_image = Gosu::Image.new(self, "../data/graphics/archer.jpg", true)

    @units=Array.new


    end
  end

  def update
    if button_down? Gosu::KbEscape  then
      close
    end
    if rand(100)<10
      end

  end

  def draw
    @background_image.draw(0, 0, 0)
    @u.draw()
    @t.draw()
  end
end

def button_down(id)
  if id == Gosu::KbEscape
    close
  end
end
window = GameWindow.new
window.show