require 'gosu'

require_relative '../classes/object.rb'
require_relative '../classes/engine.rb'

class Projectile < Object
  attr_reader :ttl,:base_angle
  def initialize (x,y,window,player_id)

    super
    @arrow_hit_ground=Gosu::Sample.new(@game_window, "../data/sounds/arrow_hit_ground.wav")
    @arrow_hit_wall=Gosu::Sample.new(@game_window, "../data/sounds/arrow_hit_wall.wav")
    @image=Gosu::Image.new(@game_window, "../data/graphics/Units/Archer/projectile.png")
    @in_air=true
    @energy=0.0
    @weight=1
  end
def warp (angle)
  @base_angle=-angle
  @vel=20
  @vel_x,@vel_y=Gosu::offset_x(@base_angle,@vel),Gosu::offset_y(@base_angle,@vel)
  @g=0.18
  @ttl=1000
  @colide=false
  @broken=false
  @hit=false
end
  def move
    @ttl-=2 #czas zycia pocisku

    if @y>@game_window.engine.horizont_pos+40 and @in_air then # czy pocisk w powietrzu
      @in_air=false
      @arrow_hit_ground.play
    end

    if @in_air

      unless @broken
        @game_window.right.walls.each { |wall| if Gosu::distance(@x,@y, wall.x,wall.y)<40.0 or Gosu::distance(@x,@y, wall.x,wall.y_down)<40.0 then @colide=true and wall.hit(@energy)end}
        @game_window.left.walls.each { |wall| if Gosu::distance(@x,@y, wall.x,wall.y)<40.0 or Gosu::distance(@x,@y, wall.x,wall.y_down)<40.0 then @colide=true and wall.hit(@energy)end}

        @game_window.right.units.each { |unit| if Gosu::distance(@x,@y, unit.x,unit.y)<40.0  then  unit.hit(@energy) and return true end}
        @game_window.left.units.each { |unit| if Gosu::distance(@x,@y, unit.x,unit.y)<40.0  then  unit.hit(@energy) and return true end}

        @game_window.balloons.each { |e| if Gosu::distance(@x, @y, e.x,e.y)<35.0 then e.hit and return true end}
      end

      if @colide
        @arrow_hit_wall.play
        @vel_x=-0.3*@vel_x
        @vel_y=0
        @colide=false
        @broken=true
      end

      
      @x+=@vel_x
      @vel_y-=@g
      @y-=@vel_y
      @energy=@vel*@vel*@weight/2
    else


    end

    if @ttl<0
      return true
    end

  end

  def draw
    @image.draw_rot(@x, @y, 6, -Gosu::angle(0,0,@vel_x,@vel_y)+180)
  end
end
