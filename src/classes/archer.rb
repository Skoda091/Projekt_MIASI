require 'gosu'
require_relative '../classes/object.rb'
require_relative '../classes/projectile.rb'

class Archer < Object
  attr_accessor :angle

  def initialize (x,y,window,player_id)
    super(x,y,window,player_id)
    @image=Gosu::Image.new(@game_window, "../data/graphics/Units/archer.gif")
    @cursor=Gosu::Image.new(@game_window, "../data/graphics/cursor.png")
    @arrows=Array.new
    @angle=0.0
    @cooldown=100.0
    @cooldown_decay=0.95
  end

  def draw
      @image.draw_rot(@x, @y, 1, 0)
      @cursor.draw_rot(@x+30, @y-30, 1, @angle,0.5,2)
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
    @cooldown+=500
    end
  end

  def arrows_fly
    @arrows.reject! {|x| x.move}
    @cooldown*=@cooldown_decay
  end

  end
