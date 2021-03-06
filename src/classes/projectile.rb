require 'gosu'

require_relative '../classes/object.rb'
require_relative '../classes/engine.rb'

class Projectile < Object
  attr_accessor :ttl,:base_angle, :angle, :scx, :scy, :vel_x, :vel_y
  def initialize (x,y,window,player_id)

    super
    @arrow_hit_ground=Gosu::Sample.new(@game_window, "../data/sounds/"+player_id+"/arrow_hit_ground.wav")
    @arrow_hit_wall=Gosu::Sample.new(@game_window, "../data/sounds/"+player_id+"/arrow_hit_wall.wav")
    
    # @arrow_fly=Gosu::Sample.new(@game_window, "../data/sounds/"+player_id+"/arrow_fly.wav")
    
    @image=Gosu::Image.new(@game_window, "../data/graphics/"+player_id+"/Units/Archer/projectile.png")
    @in_air=true
    @energy=0.0
    @weight=0.4
    @angle=0

    @z=6
    @scx=0.5
    @scy=0.5
  end
def warp (angle)
  @base_angle=-angle
  @vel=16
  @vel_x,@vel_y=Gosu::offset_x(@base_angle,@vel),Gosu::offset_y(@base_angle,@vel)
  @g=0.18
  @ttl=1000
  @colide=false
  @broken=false
  @hit=false
end
  def move
    @arrow_above_hor=10
    @ttl-=2 #czas zycia pocisku

    # @arrow_fly.play if @y.between?(@game_window.engine.horizont_pos-240,@game_window.engine.horizont_pos-230)
    if @y>@game_window.engine.horizont_pos+ (@colide==true ? @arrow_above_hor : 40) and @in_air then # czy pocisk w powietrzu
      @in_air=false
      @player_id=='left' ? @arrow_hit_ground.play : @arrow_hit_ground.play(0.6)
    end

    if @in_air
      unless @broken
        if @player_id=='left'
          @colide=true and @vel_x1=@vel_x and @vel_y1=@vel_y if Gosu::distance(@x,@y, @game_window.right.walls[1].x,@game_window.right.walls[1].y)<150.0
        else
          @colide=true and @vel_y1=@vel_y and @vel_x1=@vel_x if Gosu::distance(@x,@y, @game_window.left.walls[1].x,@game_window.left.walls[1].y)<150.0
        end
        
        @game_window.right.units.each { |unit|  if Gosu::distance(@x,@y, unit.x,unit.y)<unit.radius  then  unit.player_id==player_id ? unit.arrow_hit_friendly.play : unit.arrow_hit.play and unit.hit(@energy)  and return true end}
        @game_window.left.units.each { |unit|   if Gosu::distance(@x,@y, unit.x,unit.y)<unit.radius  then  unit.player_id==player_id ? unit.arrow_hit_friendly.play : unit.arrow_hit.play and unit.hit(@energy)  and return true end}

        @game_window.birds.each { |e| if Gosu::distance(@x, @y, e.x,e.y)<30.0 then e.arrow=self and e.hit(@energy)  and return true end}
      end

      if @colide
        # @arrow_hit_wall.play
        dist=180
        if @player_id=='left'
          dist = Gosu::distance(@x,@y, @game_window.right.walls[1].x,@game_window.right.walls[1].y) unless @game_window.right.walls[1].nil?
          ang=Gosu::angle(0,0,@vel_x1,@vel_y1)
          @vel_x*=dist.abs/180.0 if @x<@game_window.right.walls[1].x and !@game_window.right.walls[1].nil?
        else
          dist = Gosu::distance(@x,@y, @game_window.left.walls[1].x,@game_window.left.walls[1].y) unless @game_window.left.walls[1].nil?
          ang=-Gosu::angle(0,0,@vel_x1,@vel_y1)
          @vel_x*=dist.abs/180.0 if @x>@game_window.left.walls[1].x and !@game_window.left.walls[1].nil?
        end

        @z=0.5
        
        
        
        # @colide=false
        @broken=true
      end

      
      @x+=@vel_x
      @vel_y-=@g
      @y-=@vel_y
      @energy=@vel*@vel*@weight/2
      @angle=-Gosu::angle(0,0,@vel_x,@vel_y)+180
    else


    end

    if @ttl<0
      return true
    end

  end

  def draw
    @image.draw_rot(@x, @y, @z, @angle,@scx,@scy)
  end

  def set_angle ang
    @angle=ang
  end
end
