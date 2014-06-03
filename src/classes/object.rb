require 'gosu'
require 'texplay'

class Object
  attr_accessor :x,:y,:game_window,:player_id
  def initialize (x,y,window,player_id)
    @x,@y=x,y
    @game_window=window
    @player_id=player_id #left, right, neutral
    @image=nil
    @hp_bar= TexPlay.create_blank_image(window, 80, 80)
    @hp_bar_counter=0
    @hp_bar_time=200
    @max_hp=100
    @hp=@max_hp
    @pixels_above=15
    @pixels_left=0

    @cooldown_time=100.0
    @cooldown_counter=0

  end

  def orientation 
    if @player_id=="left"
      return 1
    else
      return -1
    end
  end

  def draw
    #@image.draw_rot(@x, @y,1,0) unless @image.nil?
    if @hp_bar_counter>0
      @hp_bar.draw_rot(@x-@pixels_left, @y-@pixels_above,10,0)
      @hp_bar.rect 0,0,80,10, :color => :green, :fill => :green
      @hp_bar.rect (@hp*1.0)/@max_hp*80,0,80,10, :color => :red, :fill => :red
      @hp_bar.rect 0,0,79,9, :color => :black, :thickness => 4
      @hp_bar_counter-=1
    end
  end
  
  def load_sprites (path) #"../data/graphics/Units/<unitname>/<Action>"
    images=[]
    i=0;
    @count=Dir.glob(File.join(path, '**', '*')).select { |file| File.file?(file) }.count
    begin
      for i in 0..@count
        images << Gosu::Image.new(@game_window, path+"/"+i.to_s+".png")
      end
    rescue
    return images
    end
  end

  def show_hp_bar (pixels_above, pixels_left)
    @pixels_left=pixels_left
    @pixels_above=pixels_above
    @hp_bar_counter=@hp_bar_time
  end

  def hide_hp_bar
    @hp_bar_counter=0
  end

  def set_image anim
    @image = anim[anim.size-1-@cooldown_counter/(@cooldown_time/anim.size)]
  end

end
