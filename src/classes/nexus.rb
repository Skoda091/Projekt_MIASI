require 'gosu'
require_relative '../classes/object.rb'

class Nexus < Object
  def initialize(x,y,window,player_id)
    super(x =x,y =y,window,player_id)

    @image=Gosu::Image.new(@game_window, "../data/graphics/"+player_id+"/Buildings/nexus_full.png")
    @image_damaged=Gosu::Image.new(@game_window, "../data/graphics/"+player_id+"/Buildings/nexus_damaged.png")

    @scale=1.5
    @x+=@image.width*@scale/2*self.orientation
    @y-=@image.height*@scale/3-10
    @z=6
    
    @max_hp=10000
    @hp=@max_hp
    @dead=false
    @collapsed=false
    @dead_time=100
  end

  def draw
      @image.draw_rot(@x, @y, @z, 0,0.5,0.5,-1*orientation*@scale,@scale)
    super
  end

  def hit(dmg)
    @hp-=dmg
    @hp=0 if @hp<0
    @image=@image_damaged if @hp/(@max_hp+0.0)<=0.5
    @collapsed=true unless @hp>0
    show_hp_bar(-10, 0)
  end

  def dead?
    if @collapsed
      @dead_time-=1

      unless @dead_time>0
        @dead=true
      end
    end
    return @dead
  end
end
