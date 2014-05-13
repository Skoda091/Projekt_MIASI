require 'gosu'
require_relative '../classes/object.rb'
require_relative '../classes/projectile.rb'

class Archer < Object
  attr_accessor :angle
  def initialize (x,y,window,player_id)
    super(x,y,window,player_id)


    @image=Gosu::Image.new(@game_window, "../data/graphics/Units/Archer/Shoot/Angle/0.png")
    @arm=Gosu::Image.new(@game_window, "../data/graphics/Units/Archer/Shoot/Angle/arm.png")
    
    #@reload = load_sprites("../data/graphics/Units/Archer/Reload")
    @cursor=Gosu::Image.new(@game_window, "../data/graphics/cursor.png")
    @bow_shot_sound = Gosu::Sample.new(@game_window, "../data/sounds/cbow_04.wav")
    @reload_sound = Gosu::Sample.new(@game_window, "../data/sounds/cbowwind_01.wav")

    @arrows=Array.new
    @angle=0.0
    @cooldown=100.0
    @cooldown_decay=0.95

  end

  def draw
      #@image = @animation[Gosu::milliseconds / 100 % @animation.size];
      @image.draw_rot(@x, @y, 1, 0,0.5,0.5, orientation )
      #@cursor.draw_rot(@x-5, @y-15, 1, @angle,0.5,3)
      @arm.draw_rot(@x-5, @y-15, 1, @angle-90,0,0.5)
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
    if @cooldown<50
    ar=Projectile.new(self.x+12,self.y-17,self.game_window,self.player_id )
    ar.warp(angle+180)
    @arrows.push(ar)
    @cooldown+=4000
    @bow_shot_sound.play
    @reload_sound.play_pan(2,2,2)
    end
  end

  def arrows_fly
    @arrows.reject! {|x| x.move}
    @cooldown*=@cooldown_decay
  end



  end
