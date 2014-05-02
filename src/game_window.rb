require 'gosu'

require_relative '../src/classes/player.rb'
require_relative '../src/classes/engine.rb'

class GameWindow < Gosu::Window
  attr_accessor :left,:right,:res_x,:res_y
  def initialize
    @z=0

    @res_x,@res_y=1920,1080
    super @res_x, @res_y, true
    @res_x+=0.0
    @res_y+=0.0
    self.caption = "Gosu Tutorial Game1"
    @background_sky = Gosu::Image.new(self, "../data/graphics/Background/sky.png", false)
    @background_ground = Gosu::Image.new(self, "../data/graphics/Background/grass1.jpg", false)
    @engin=Engine.new(self)
    @left=Player.new(self,"left",@engin)
    @right=Player.new(self,"right",@engin)

    end


  def update


    self.button_action
    @left.walls.each { |x| x.bow.arrows_fly}


  end

  def draw
    @background_sky.draw(0, 0, 0,@res_x/@background_sky.width,@res_y-100.0/@background_sky.height)
    @background_ground.draw(0,@res_y-100,0,@res_x/@background_ground.width,100.0/@background_ground.height)

    @left.draw
    @right.draw
  end


def button_down(id)
  if id == Gosu::KbEscape
    close
  end
end

def button_action
  if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
    @left.walls.each { |x| x.bow.angle_change(false)}
  end
  if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
    @left.walls.each { |x| x.bow.angle_change(true)}
  end
  if button_down? Gosu::KbSpace then
    @left.walls.each { |x| x.bow.shoot}
  end
end

def engine
  return @engin
end



end
window = GameWindow.new
window.show