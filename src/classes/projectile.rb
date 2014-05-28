require 'gosu'

require_relative '../classes/object.rb'
require_relative '../classes/engine.rb'

class Projectile < Object
  attr_reader :ttl,:base_angle
  def initialize (x,y,window,player_id)

    super
    @arrow_hit_ground=Gosu::Sample.new(@game_window, "../data/sounds/arrow_hit_ground.wav")
    @arrow_hit_wall=Gosu::Sample.new(@game_window, "../data/sounds/arrow_hit_wall.wav")
    @image=Gosu::Image.new(@game_window, "../data/graphics/arrow.png")
    @in_air=true
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
<<<<<<< HEAD
      @game_window.right.walls.each { |wall| if Gosu::distance(@x,@y, wall.x,wall.y)<40.0 or Gosu::distance(@x,@y, wall.x,wall.y_down)<40.0 then @colide=true end}
      @game_window.left.walls.each { |wall| if Gosu::distance(@x,@y, wall.x,wall.y)<40.0 or Gosu::distance(@x,@y, wall.x,wall.y_down)<40.0 then @colide=true end}
      
        if orientation==1 then
          @game_window.right.units.each {|unit| unit.die if Gosu::distance(@x,@y,unit.x,unit.y)<35.0 }
        else
          @game_window.left.units.each {|unit| unit.die if Gosu::distance(@x,@y,unit.x,unit.y)<35.0 }
        end
=======
        @game_window.right.walls.each { |wall| if Gosu::distance(@x,@y, wall.x,wall.y)<40.0 or Gosu::distance(@x,@y, wall.x,wall.y_down)<40.0 then @colide=true end}
        @game_window.left.walls.each { |wall| if Gosu::distance(@x,@y, wall.x,wall.y)<40.0 or Gosu::distance(@x,@y, wall.x,wall.y_down)<40.0 then @colide=true end}
        
        @game_window.right.units.each { |unit| if Gosu::distance(@x,@y, unit.x,unit.y)<40.0  then @hit=true, @unit=unit end}
        @game_window.left.units.each { |unit| if Gosu::distance(@x,@y, unit.x,unit.y)<40.0  then @hit=true, @unit=unit end}

        @game_window.balloons.each { |e| if Gosu::distance(@x, @y, e.x,e.y)<30.0 then e.hit and return true end}
>>>>>>> 40b9c68a4fea2a9a6beb9e1154fa0d004bcb4f7e
      end

      if @colide
        @arrow_hit_wall.play
        @vel_x=-0.3*@vel_x
        @vel_y=0
        @colide=false
        @broken=true
      end

      if @hit
        @unit.die
        return true
      end
      
      @x+=@vel_x
      @vel_y-=@g
      @y-=@vel_y

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
