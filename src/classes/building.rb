require 'gosu'
require_relative '../classes/object.rb'

class Building < Object
  attr_accessor :bow,:y_down, :collapsed
  def initialize(x,y,window,player_id,height)
    super(x =x,y =y,window,player_id)
    @image_normal=Gosu::Image.new(@game_window, "../data/graphics/"+player_id+"/Buildings/wall.png")
    @image_blank=Gosu::Image.new(@game_window, "../data/graphics/"+player_id+"/Buildings/wall_blank.png")
    
    @collapse_sound=Gosu::Sample.new(@game_window, "../data/sounds/wall_collapse.wav")
    @collapse_anim=load_sprites("../data/graphics/explosion")

    @z=1
    @height=height
    @y_down=@y
    @y=@y-(@height*64)
    @max_hp=1000
    @hp=@max_hp
    @dead=false
    @collapsed=false
    @dead_time=100

    
  end

  def draw()
    for i in 0..@height do
      i==0 ? @image_blank.draw_rot(@x, @y+i*64, 1, 0) : @image_normal.draw_rot(@x, @y+i*64, 1, 0)
    end
    @bow.draw
    if @collapsed

      set_image @collapse_anim
      @image.draw_rot(@x,(@y+@y_down)/2-20,6,0,0.5,0.5,2,2)
      @imageold.draw_rot(@x,(@y+@y_down)/2+40,6,0,0.5,0.5,2,2) unless @imageold.nil?
    end
    super
  end

  def hit(dmg)
    unless @collapsed
      @hp-=dmg
      @hp=0 if @hp<0

      @collapsed=true and @cooldown_time=100 and @cooldown_counter=@cooldown_time unless @hp>0
      show_hp_bar(-10, 0)
    end
  end

  def dead?
    if @collapsed
      @cooldown_counter-=1
      set_image @collapse_anim
      unless @cooldown_counter>0
        @collapse_sound.play if @dead=false
        @dead=true
        
      end
    end
    return @dead
  end



end
