require 'gosu'
require_relative '../classes/object.rb'


class Balloon < Object
  def initialize(window,player_id)
     super(rand(window.res_x-70)+35,rand(window.res_y-630)+30,window,player_id)
     
     @anim = load_sprites("../data/graphics/Balloon/Anim")
     @image=@anim[0]

     @boom_sound=Gosu::Sample.new(@game_window, "../data/sounds/balloon.wav")
     @vel=0.75
     @base_angle=rand(350)+5
     @vel_x,@vel_y=Gosu::offset_x(@base_angle,@vel),Gosu::offset_y(@base_angle,@vel)

     @ttl=2000
     @boom=false
     @died=false
     @dead_time=100
     
  end

  def move
    @ttl-=1
    @boom=true if @ttl<1

    unless @boom
      if rand(100)<20
        r=(rand(11)-5)/50.0
        @vel+=r if (@vel+r).between?(0.25,1.5)
      end
      while true do
        if rand(100)<30
          @base_angle+=rand(21)-10
          @base_angle=@base_angle%360
        end
        @vel_x,@vel_y=Gosu::offset_x(@base_angle,@vel),Gosu::offset_y(@base_angle,@vel)
        if (@x+@vel_x).between?(30,@game_window.res_x-30) and (@y+@vel_y).between?(30,@game_window.res_y-600)
          @x+=@vel_x
          @y+=@vel_y
          break
        end
      end
    else
      @dead_time-=1
      @died=true if @dead_time<1
    end
  end

  def dead?
    @died
  end

  def hit
    @boom_sound.play
    @boom=true
  end


end
