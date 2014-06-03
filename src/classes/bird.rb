require 'gosu'
require_relative '../classes/object.rb'

class Bird < Object
  def initialize(window,player_id)
      orient=rand(2)
       super(orient==0 ? 0 : window.res_x,rand(window.res_y-630)+30,window,orient==0 ? 'left' : 'right')
       
       @fly_anim = load_sprites("../data/graphics/Bird/fly")
       @die_anim = load_sprites("../data/graphics/Bird/die")

       @image=@fly_anim[0]

       @boom_sound=Gosu::Sample.new(@game_window, "../data/sounds/balloon.wav")
       @vel_x=1.5
       @vel_y=0.0

       @ttl=500
       
       @died=false
       @dead_time=42
       @dead_counter=@dead_time
    end

  def move
    if @died
      set_image @die_anim   
      @cooldown_counter-=1 if @cooldown_counter>1 
      # abort(@vel_y.inspect)
      
      @vel_y+=0.18
      @y+=@vel_y if @y<@game_window.engin.horizont_pos+50
      

    else
      r=(rand(21)-10)/50.0
      @vel_y+=r if (@vel_y+r).between?(-1.0,1.0)
      @x+=@vel_x*orientation
      @y+=@vel_y if (@y+@vel_y).between?(0,500)

      @ttl=-0 unless @x.between?(-20,@game_window.res_x+21)

      set_image @fly_anim   
      @cooldown_counter-=1
      @cooldown_counter=@cooldown_time unless @cooldown_counter>0
    end

    

    @died=true unless @ttl>1
    
  end

  def dead?
    @died
  end

  def draw
    @image.draw_rot(@x, @y, 1, 0,0.5,0.5, -1*orientation) unless @image.nil?     
  end

  def hit
    unless @died
      @vel_x=0
      @vel_y=0
      @cooldown_time=@dead_time
      @cooldown_counter=@dead_time
      @boom_sound.play
      @died=true
    end
  end

end
