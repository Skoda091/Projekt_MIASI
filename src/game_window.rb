require 'gosu'

load '../src/classes/unit.rb'

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
    self.caption = "Gladius"
    @background_sky = Gosu::Image.new(self, "../data/graphics/Background/sky.png", false)
    @background_ground = Gosu::Image.new(self, "../data/graphics/Background/grass1.jpg", false)
    
    @engin=Engine.new(self)
    @left=Player.new(self,"left",@engin)
    @right=Player.new(self,"right",@engin)
  end

  def update

    self.button_action
    @left.walls.each { |x| x.bow.arrows_fly}
<<<<<<< HEAD
    @left.units.each {|u| u.move}
    @right.units.each {|u| u.move}
=======
    @right.walls.each { |x| x.bow.arrows_fly}
    
    unless @units1.empty?
    @units1.each { |u| u.move}
    end

    unless @units2.empty?
      @units2.each { |u| u.move}
    end
>>>>>>> debcf8c008482b49455430b5bf4ef24083805885

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
  if button_down? Gosu::KbA  then
    @left.walls.each { |x| x.bow.angle_change(false)}
  end
  if button_down? Gosu::KbD  then
    @left.walls.each { |x| x.bow.angle_change(true)}
  end
  if button_down? Gosu::KbSpace then
    @left.walls.each { |x| x.bow.shoot}
  end
<<<<<<< HEAD
  # Rekrutacja jednostek
  if button_down? Gosu::Kb1 then
    @left.units.push(Unit.new(0,@res_y-100,self,"left","pikeman"))
  end
  if button_down? Gosu::Kb0 then
    @right.units.push(Unit.new(@res_x,@res_y-100,self,"right","pikeman"))
  end
  if button_down? Gosu::Kb2 then
    @left.units.push(Unit.new(0,@res_y-100,self,"left","swordsman"))
  end
  if button_down? Gosu::Kb9 then
    @right.units.push(Unit.new(@res_x,@res_y-100,self,"right","swordsman"))
  end
  if button_down? Gosu::Kb3 then
    @left.units.push(Unit.new(0,@res_y-100,self,"left","horseman"))
  end
  if button_down? Gosu::Kb8 then
    @right.units.push(Unit.new(@res_x,@res_y-100,self,"right","horseman"))
=======
  if button_down? Gosu::KbLeft  then
    @right.walls.each { |x| x.bow.angle_change(false)}
  end
  if button_down? Gosu::KbRight  then
    @right.walls.each { |x| x.bow.angle_change(true)}
  end
  if button_down? Gosu::KbEnter then
    @right.walls.each { |x| x.bow.shoot}
>>>>>>> debcf8c008482b49455430b5bf4ef24083805885
  end
end

def engine
  return @engin
end

end
window = GameWindow.new
window.show
