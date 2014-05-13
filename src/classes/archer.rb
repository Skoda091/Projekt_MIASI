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


    @arrows=Array.new
    @angle=0.0
    @cooldown=100.0
    @cooldown_decay=0.95

  end

  def draw
      #@image = @animation[Gosu::milliseconds / 100 % @animation.size];
      @image.draw_rot(@x, @y, 1, 0,0.5,0.5, orientation )
      @cursor.draw_rot(@x, @y, 1, @angle,0.5,3)
      @arrows.each {|x| x.draw}
  end

  def angle_change (direction)
    if direction==true
    @angle+=3
    else
    @angle-=3
    end
  end

  def shoot
    if @cooldown<50
    ar=Projectile.new(self.x,self.y,self.game_window,self.player_id )
    ar.warp(angle+180)
    @arrows.push(ar)
    @cooldown+=10
    @bow_shot_sound.play
    end
  end

  def arrows_fly
    @arrows.reject! {|x| x.move}
    @cooldown*=@cooldown_decay
  end



  end
