require 'gosu'
<<<<<<< HEAD
load '../src/classes/unit.rb'

=======

require_relative '../src/classes/player.rb'
require_relative '../src/classes/engine.rb'
>>>>>>> damian

class GameWindow < Gosu::Window
  attr_accessor :left,:right,:res_x,:res_y
  def initialize

    @z=0
<<<<<<< HEAD
    super 1600, 900, false
    self.caption = "Gosu Tutorial Game1"
    @background_image = Gosu::Image.new(self, "../data/graphics/archer.jpg", true)
    @units1=Array.new
    @units2=Array.new

  end
=======

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
>>>>>>> damian


  def update

<<<<<<< HEAD
    unit_type=rand(3)
    unit_types=""
    case unit_type
      when 0
        unit_types="swordsman"
      when 1
        unit_types="pikeman"
      when 2
        unit_types="horseman"
    end
    if rand(200)<2 then


      @units1.push(Unit.new(0,800,self,"left",unit_types))
      @units2.push(Unit.new(1600,800,self,"right",unit_types))

=======
>>>>>>> damian

    self.button_action
    @left.walls.each { |x| x.bow.arrows_fly}

<<<<<<< HEAD
    unless @units1.empty?
    @units1.each { |u| u.move}
    end

    unless @units2.empty?
      @units2.each { |u| u.move}
    end

=======
>>>>>>> damian

  end

  def draw
<<<<<<< HEAD
    @background_image.draw(0, 0, 0)

    unless @units1.empty?
      @units1.each { |u| u.draw}
    end

    unless @units2.empty?
      @units2.each { |u| u.draw}
    end


=======
    @background_sky.draw(0, 0, 0,@res_x/@background_sky.width,@res_y-100.0/@background_sky.height)
    @background_ground.draw(0,@res_y-100,0,@res_x/@background_ground.width,100.0/@background_ground.height)

    @left.draw
    @right.draw
>>>>>>> damian
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
