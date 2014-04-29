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


  def update
    if button_down? Gosu::KbEscape  then
      close
    end



    if rand(100)<5 then
      @units.push(Unit.new(0,800,self,"left","swordsman"))

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