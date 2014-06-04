require 'gosu'
require_relative '../classes/object.rb'
require_relative '../classes/projectile.rb'

class Archer < Object
  attr_accessor :angle
  def initialize (x,y,window,player_id)
    super(x,y,window,player_id)


    @img=Gosu::Image.new(@game_window, "../data/graphics/"+player_id+"/Units/Archer/Shoot/Angle/0.png")
    @image=Gosu::Image.new(@game_window, "../data/graphics/"+player_id+"/Units/Archer/Shoot/Angle/0.png")
    @stand_image=@image;
    @arm=Gosu::Image.new(@game_window, "../data/graphics/"+player_id+"/Units/Archer/Shoot/Angle/arm.png")
    

    @reload =load_sprites("../data/graphics/"+player_id+"/Units/Archer/Reload")

    @bow_shot_sound = Gosu::Sample.new(@game_window, "../data/sounds/"+player_id+"/cbow_04.wav")
    @reload_sound = Gosu::Sample.new(@game_window, "../data/sounds/"+player_id+"/cbowwind_01.wav")
 
    if player_id=='left'
    
    else

    end


    @arrows=Array.new
    if orientation==1
      @angle=45.0
      else
      @angle=135.0
    end
    @cooldown_time=100.0
    @cooldown_counter=0

  end

  def draw
    if @cooldown_counter > 0
       set_image @reload
       @image.draw_rot(@x, @y, 1, 0,0.5,0.5, orientation )
    else
      @image=@img
      if player_id=='left'
        @image.draw_rot(@x, @y, 1, 0,0.5,0.5, orientation )
        @arm.draw_rot(@x-10*orientation, @y-15, 1, @angle-90,0,0.5,orientation)
      else
        @arm.draw_rot(@x-5*orientation, @y-15, 1, @angle-90,0.4,0.5,orientation)
        @image.draw_rot(@x, @y, 1, 0,0.5,0.5, orientation )
      end
    end
     
      
      
      @arrows.each {|x| x.draw}
  end

  def angle_change (direction)
        angle_delta=2
        @player_id=='left' ? delta=angle_delta : delta=angle_delta/2.0

        if direction==true
          @angle+=delta if @angle+delta<160
        else
          @angle-=delta if @angle-delta>20
        end
   
  end

  def shoot
    if @cooldown_counter==0
    ar=Projectile.new(self.x+12*orientation,self.y-17,self.game_window,self.player_id )
    orientation==1 ? ar.warp(angle+180) : ar.warp(angle)
    @arrows.push(ar)
    @cooldown_counter=@cooldown_time
    if @player_id=='left'
      @bow_shot_sound.play(0.5)
      @reload_sound.play
    else
      @bow_shot_sound.play(0.4)
      @reload_sound.play(0.3)
    end
    end
  end

  def arrows_fly
    @arrows.reject! {|x| x.move}
    @cooldown_counter-=1 if @cooldown_counter>0

  end



  end
