require 'gosu'
require_relative '../classes/object.rb'

class Building < Object
  attr_accessor :bow,:y_down
  def initialize(x,y,window,player_id,height)
    super(x =x,y =y,window,player_id)
    @image_normal=Gosu::Image.new(@game_window, "../data/graphics/"+player_id+"/Buildings/wall.png")
    @image_blank=Gosu::Image.new(@game_window, "../data/graphics/"+player_id+"/Buildings/wall_blank.png")
    @collapse_sound=Gosu::Sample.new(@game_window, "../data/sounds/wall_collapse.wav")
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
    super
  end

  def hit(dmg)
    @hp-=dmg
    @hp=0 if @hp<0

    @collapsed=true unless @hp>0
    show_hp_bar(-10, 0)
  end

  def dead?
    if @collapsed
      @dead_time-=1

      unless @dead_time>0
        @dead=true
        @collapse_sound.play
      end
    end
    return @dead
  end



end
