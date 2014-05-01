require 'gosu'
require_relative '../classes/object.rb'

class Building < Object
  attr_accessor :bow
  def initialize(x,y,window,player_id,height)
    super(x =x,y =y,window,player_id)
    @image=Gosu::Image.new(@game_window, "../data/graphics/Buildings/wall.png")
    @z=1
    @height=height
    @y=@y-(@height*64)
  end
  def draw()
    for i in 0..@height do
      @image.draw_rot(@x, @y+i*64, 1, 0)
    end
    @bow.draw
  end
end