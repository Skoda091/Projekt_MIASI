require 'gosu'
require_relative '../classes/object.rb'

class Bird < Object
  attr_accessor :arrow
  def initialize(window,player_id)
      orient=rand(2)
       super(orient==0 ? 0 : window.res_x,rand(window.res_y-630)+30,window,orient==0 ? 'left' : 'right')
       
       @fly_anim = load_sprites("../data/graphics/Bird/fly")
       @die_anim = load_sprites("../data/graphics/Bird/die")
       @arrow=nil

       @image=@fly_anim[0]

       @boom_sound=Gosu::Sample.new(@game_window, "../data/sounds/bird_die.wav")
       @vel_x=1.5
       @vel_y=0.0

       @ttl=500
       
       @died=false
       @dead_time=42
       @dead_counter=@dead_time
       @angle=0
       @rotate=0
       @energy=0
    end

  def move
    if @died
      set_image @die_anim   
      @cooldown_counter-=1 if @cooldown_counter>1 
      # abort(@vel_y.inspect)
      
      @vel_y+=0.18
      
      
      @y+=@vel_y and @angle+= @rotate and @arrow.set_angle (@arrow.angle+@rotate)if @y<@game_window.engin.horizont_pos+30 and !@arrow.nil?
      

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
    @image.draw_rot(@x, @y, 1, @angle,0.5,0.5, -1*orientation) unless @image.nil?
    @arrow.x=@x
    @arrow.y=@y
    @arrow.draw unless @arrow.nil?
  end

  def hit dmg
    unless @died
      @energy=dmg
      @arrow.nil? ? @rotate=0 : @arrow.scy=0 and @rotate=@energy/55 * (@arrow.player_id=='left' ? 1 : -1)
      @vel_x=0
      @vel_y=0
      @cooldown_time=@dead_time
      @cooldown_counter=@dead_time
      @boom_sound.play(1.5)
      @died=true
    end
  end

end
