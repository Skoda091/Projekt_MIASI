require 'gosu'
load '../src/classes/unit.rb'


class GameWindow < Gosu::Window
  def initialize

    @z=0
    super 1600, 900, false
    self.caption = "Gosu Tutorial Game1"
    @background_image = Gosu::Image.new(self, "../data/graphics/archer.jpg", true)
    @units1=Array.new
    @units2=Array.new

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
    if rand(200)<2 then


      @units1.push(Unit.new(0,800,self,"left",unit_types))
      @units2.push(Unit.new(1600,800,self,"right",unit_types))


    end

    unless @units1.empty?
    @units1.each { |u| u.move}
    end

    unless @units2.empty?
      @units2.each { |u| u.move}
    end


  end

  def draw
    @background_image.draw(0, 0, 0)

    unless @units1.empty?
      @units1.each { |u| u.draw}
    end

    unless @units2.empty?
      @units2.each { |u| u.draw}
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