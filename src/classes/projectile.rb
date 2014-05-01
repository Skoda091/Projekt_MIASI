require 'gosu'
require_relative '../classes/object.rb'

class Projectile < Object
  attr_reader :ttl,:base_angle
  def initialize (x,y,window,player_id)

    super

    @image=Gosu::Image.new(@game_window, "../data/graphics/arrow.png")

  end
def warp (angle)
  @base_angle=-angle
  @vel=13.0
  @vel_x,@vel_y=Gosu::offset_x(@base_angle,@vel),Gosu::offset_y(@base_angle,@vel)
  @g=0.2
  @ttl=1000
end
  def move
    @ttl-=2
    @x+=@vel_x
    @vel_y-=@g
    @y-=@vel_y

    if @ttl<0
      return true
    end
  end

  def draw
    @image.draw_rot(@x, @y, 1, -Gosu::angle(0,0,@vel_x,@vel_y)+180)
  end
end