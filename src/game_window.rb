require 'gosu'

load '../src/classes/unit.rb'


class GameWindow < Gosu::Window
  def initialize
<<<<<<< HEAD
    super 800, 600, false
    self.caption = "Gosu Tutorial Game"
=======
    @z=0
    super 1600, 900, true
    self.caption = "Gosu Tutorial Game1"
>>>>>>> ca9abf82c205124c8c08446488ebd16d91a5623c
    @background_image = Gosu::Image.new(self, "../data/graphics/archer.jpg", true)
    @units=Array.new


    end


  def update
    if button_down? Gosu::KbEscape  then
      close
    end

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
    if rand(100)<5 then
      @units.push(Unit.new(0,800,self,"left",unit_types))

    end

    unless @units.empty?
    @units.each { |u| u.move}
      end

  end

  def draw
    @background_image.draw(0, 0, 0)

    unless @units.empty?
      @units.each { |u| u.draw}
    end

  end


def button_down(id)
  if id == Gosu::KbEscape
    close
  end
end
end
window = GameWindow.new
window.show