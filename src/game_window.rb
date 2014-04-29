require 'gosu'

load '../src/classes/unit.rb'


class GameWindow < Gosu::Window
  def initialize
    @z=0
    super 1600, 900, true
    self.caption = "Gosu Tutorial Game1"
    @background_image = Gosu::Image.new(self, "../data/graphics/archer.jpg", true)
    #@units=Array.new
    @count=0

    end
  end

  def update
    if button_down? Gosu::KbEscape  then
      close
    end

=begin

    if @count>500 then
      @units.push(Unit.new(0,800,self,"left","swordsman"))
      @count=0
    else
      @count+=1
    end

    unless @units.empty?
    @units.each { |u| u.move}
      end
=end
  end

  def draw
    @background_image.draw(0, 0, 0)
=begin
    unless @units.empty?
      @units.each { |u| u.draw}
    end
=end
  end


def button_down(id)
  if id == Gosu::KbEscape
    close
  end
end
window = GameWindow.new
window.show