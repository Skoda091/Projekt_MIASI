require 'gosu'

load '../src/classes/unit.rb'
load '../src/classes/balloon.rb'

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
    @res_y_recruit=@res_y-50
    self.caption = "Gladius"
    @background_sky = Gosu::Image.new(self, "../data/graphics/Background/sky.png", false)
    @background_ground = Gosu::Image.new(self, "../data/graphics/Background/grass1.jpg", false)
    
    @engin=Engine.new(self)
    @left=Player.new(self,"left",@engin)
    @right=Player.new(self,"right",@engin)

    @balloons=Array.new
  end

  def update
    @balloons << Balloon.new(self,"left") if rand((@balloons.count+1)*160)==0
    @balloons.reject! {|b| b.dead? }
    @balloons.each { |e| e.move}

    self.button_action    
    @left.units.each {|u| u.move}
    @right.units.each {|u| u.move}
    @left.walls.each { |x| x.bow.arrows_fly}
    @right.walls.each { |x| x.bow.arrows_fly}
    @left.cooldown
    @right.cooldown

  end

  def draw

    @background_sky.draw(0, 0, 0,@res_x/@background_sky.width,@res_y-100.0/@background_sky.height)
    @background_ground.draw(0,@res_y-100,0,@res_x/@background_ground.width,100.0/@background_ground.height)

    @balloons.each { |e| e.draw}

    @left.draw
    @right.draw

  end


def button_down(id)
  if id == Gosu::KbEscape
    close
  end
end

def button_action

  #Strzelanie gracz lewy
  #######################
  if button_down? Gosu::KbLeft  then
    @right.walls.each { |x| x.bow.angle_change(false)}
  end
  if button_down? Gosu::KbRight  then
    @right.walls.each { |x| x.bow.angle_change(true)}
  end
  if button_down? Gosu::KbEnter then
    @right.walls.each { |x| x.bow.shoot}
  end

  #Strzelanie gracz prawy
  #######################
  if button_down? Gosu::KbA  then
    @left.walls.each { |x| x.bow.angle_change(false)}
  end
  if button_down? Gosu::KbD  then
    @left.walls.each { |x| x.bow.angle_change(true)}
  end
  if button_down? Gosu::KbSpace then
    @left.walls.each { |x| x.bow.shoot}
  end

  
  # Rekrutacja jednostek
  if button_down? Gosu::Kb1 then
    @left.recruit(0,@res_y_recruit,"left","pikeman")
  end
  if button_down? Gosu::Kb0 then
    @right.recruit(@res_x,@res_y_recruit,"right","pikeman")
  end
  if button_down? Gosu::Kb2 then
    @left.recruit(0,@res_y_recruit,"left","swordsman")
  end
  if button_down? Gosu::Kb9 then
    @right.recruit(@res_x,@res_y_recruit,"right","swordsman")
  end
  if button_down? Gosu::Kb3 then
    @left.recruit(0,@res_y_recruit,"left","horseman")
  end
  if button_down? Gosu::Kb8 then
    @right.recruit(@res_x,@res_y_recruit,"right","horseman")
  end
  
end

def engine
  return @engin
end

end
window = GameWindow.new
window.show
