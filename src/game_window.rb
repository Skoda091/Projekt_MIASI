require 'gosu'

load '../src/classes/unit.rb'


class GameWindow < Gosu::Window
  def initialize
    @z=0
    super 1600, 900, true
    self.caption = "Gosu Tutorial Game1"
    @background_image = Gosu::Image.new(self, "../data/graphics/archer.jpg", true)
    @u=Unit.new(0,800,self,"left","swordsman")

  end

  def update
    if button_down? Gosu::KbEscape  then
      close
    end
    @u.move()
  end

  def draw
    @background_image.draw(0, 0, 0)
    @u.draw()
  end
end

def button_down(id)
  if id == Gosu::KbEscape
    close
  end
end
window = GameWindow.new
window.show