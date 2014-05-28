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
    
<<<<<<< HEAD
    @reload =load_sprites("../data/graphics/Units/Archer/Reload")

=======
    @reload = load_sprites("../data/graphics/Units/Archer/Reload")
>>>>>>> 40b9c68a4fea2a9a6beb9e1154fa0d004bcb4f7e
    @cursor=Gosu::Image.new(@game_window, "../data/graphics/cursor.png")
    @bow_shot_sound = Gosu::Sample.new(@game_window, "../data/sounds/cbow_04.wav")
    @reload_sound = Gosu::Sample.new(@game_window, "../data/sounds/cbowwind_01.wav")

    @arrows=Array.new
    if orientation==1
      @angle=45.0
      else
      @angle=135.0
    end
    @cooldown_addition=4000
    @cooldown=100.0
    @cooldown_decay=0.95

  end

  def draw
<<<<<<< HEAD
    if @cooldown<50 then
      @image = @stand_image
      @arm.draw_rot(@x-5*orientation, @y-15, 1, @angle-90,0,0.5,orientation)
    else
      @image = @reload[Gosu::milliseconds / 250 % @reload.size];
    end
    @image.draw_rot(@x, @y, 1, 0,0.5,0.5, orientation )
      #@cursor.draw_rot(@x-5, @y-15, 1, @angle,0.5,3)
    
    @arrows.each {|x| x.draw}
=======
    if @cooldown > 50
       @image = @reload[Gosu::milliseconds / (@cooldown_addition/18) % @reload.size];
    else
      @image=@img
      @arm.draw_rot(@x-5*orientation, @y-15, 1, @angle-90,0,0.5,orientation)
    end
     
      @image.draw_rot(@x, @y, 1, 0,0.5,0.5, orientation )
      #@cursor.draw_rot(@x-5, @y-15, 1, @angle,0.5,3)
      
      @arrows.each {|x| x.draw}
>>>>>>> 40b9c68a4fea2a9a6beb9e1154fa0d004bcb4f7e
  end

  def angle_change (direction)
    
        if direction==true
          @angle+=3 if @angle+3<160
        else
          @angle-=3 if @angle-3>20
        end
   
  end

  def shoot
    if @cooldown<50
    ar=Projectile.new(self.x+12*orientation,self.y-17,self.game_window,self.player_id )
    orientation==1 ? ar.warp(angle+180) : ar.warp(angle)
    @arrows.push(ar)
<<<<<<< HEAD
    @cooldown+=100
=======
    @cooldown+=@cooldown_addition
>>>>>>> 40b9c68a4fea2a9a6beb9e1154fa0d004bcb4f7e
    @bow_shot_sound.play
    @reload_sound.play
    end
  end

  def arrows_fly
    @arrows.reject! {|x| x.move}
    @cooldown*=@cooldown_decay
  end



  end
