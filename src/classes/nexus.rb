require 'gosu'
require_relative '../classes/object.rb'

class Nexus < Object
  attr_accessor :hp
  def initialize(x,y,window,player_id)
    super(x =x,y =y,window,player_id)

    @image_nexus=Gosu::Image.new(@game_window, "../data/graphics/"+player_id+"/Buildings/nexus_full.png")
    @image_damaged=Gosu::Image.new(@game_window, "../data/graphics/"+player_id+"/Buildings/nexus_damaged.png")

    @collapse_sound=Gosu::Sample.new(@game_window, "../data/sounds/wall_collapse.wav")
    @collapse_anim=load_sprites("../data/graphics/explosion")

    @scale=1.5
    @x+=@image_nexus.width*@scale/2*self.orientation
    @y-=@image_nexus.height*@scale/3-10
    @z=6
    
    @max_hp=100
    @hp=@max_hp
    @dead=false
    @collapsed=false
    @dead_time=100
  end

  def draw
    if !@dead
      unless @collapsed
      @image_nexus.draw_rot(@x, @y, @z, 0,0.5,0.5,-1*orientation*@scale,@scale)
      else
      set_image @collapse_anim
      @image_nexus.draw_rot(@x, @y, @z, 0,0.5,0.5,-1*orientation*@scale,@scale)
      @image.draw_rot(@x, @y, @z, 0,0.5,0.5,-1*orientation*@scale,@scale)
      end
    end
    super
  end

  def hit(dmg)
    unless @collapsed
    @hp-=dmg
    @hp=0 if @hp<0
    @image_nexus=@image_damaged if @hp/(@max_hp+0.0)<=0.5
    @collapsed=true and @cooldown_time=150 and @cooldown_counter=@cooldown_time unless @hp>0
    show_hp_bar(100, 10)
    else
      
    end
  end

  def dead?
    if @collapsed
    @cooldown_counter-=1

      unless @cooldown_counter>0
        @dead=true
        @collapse_sound.play
      end
    end
    return @dead
  end
end
