require 'gosu'
require_relative '../classes/object.rb'
require_relative '../classes/projectile.rb'

class Archer < Object
  attr_accessor :angle
  def initialize (x,y,window,player_id)
    super(x,y,window,player_id)

    @img=Gosu::Image.new(@game_window, "../data/graphics/Units/Archer/Shoot/Angle/0.png")
    @image=Gosu::Image.new(@game_window, "../data/graphics/Units/Archer/Shoot/Angle/0.png")
    @stand_image=@image;
    @arm=Gosu::Image.new(@game_window, "../data/graphics/Units/Archer/Shoot/Angle/arm.png")
    

    @reload =load_sprites("../data/graphics/Units/Archer/Reload")

    @reload = load_sprites("../data/graphics/Units/Archer/Reload")
    @cursor=Gosu::Image.new(@game_window, "../data/graphics/cursor.png")
    @bow_shot_sound = Gosu::Sample.new(@game_window, "../data/sounds/cbow_04.wav")
    @reload_sound = Gosu::Sample.new(@game_window, "../data/sounds/cbowwind_01.wav")

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
       #@image = @reload[Gosu::milliseconds / (@cooldown_addition/18) % @reload.size];
       @image = @reload[@reload.count-@cooldown_counter/(@cooldown_time/@reload.size)]
    else
      @image=@img
      @arm.draw_rot(@x-5*orientation, @y-15, 1, @angle-90,0,0.5,orientation)
    end
     
      @image.draw_rot(@x, @y, 1, 0,0.5,0.5, orientation )
      #@cursor.draw_rot(@x-5, @y-15, 1, @angle,0.5,3)
      
      @arrows.each {|x| x.draw}
  end

  def angle_change (direction)
    
        if direction==true
          @angle+=3 if @angle+3<160
        else
          @angle-=3 if @angle-3>20
        end
   
  end

  def shoot
    if @cooldown_counter==0
    ar=Projectile.new(self.x+12*orientation,self.y-17,self.game_window,self.player_id )
    orientation==1 ? ar.warp(angle+180) : ar.warp(angle)
    @arrows.push(ar)
    @cooldown_counter=@cooldown_time
    @bow_shot_sound.play
    @reload_sound.play
    end
  end

  def arrows_fly
    @arrows.reject! {|x| x.move}
    @cooldown_counter-=1 if @cooldown_counter>0

  end



  end
