require 'gosu'
load '../src/classes/object.rb'

class Unit < Object
  attr_accessor :remove_unit, :speed, :max_unit_speed, :radius, :attack, :damage
  def initialize(x,y,window,player_id,type)
    super(x,y,window,player_id)
    @cost,@speed=0
    @max_unit_speed=0
    @radius=0
    @attack=false
    @is_dead=false
    @damage=0
    @type=type
    @z=2
    @frame_time=6
    @cooldown_counter=@cooldown_time
    @attack_time=50
    @attack_counter=25

    @remove_unit=false

    @buff=0
    init(@type)

  end

  def draw()
      @image.draw_rot(@x, @y, @z, 0, 0.2, 1, orientation, 1) and @previous_image=@image unless @image.nil?
      @previous_image.draw_rot(@x, @y, @z, 0, 0.2, 1, orientation, 1) if @image.nil? and !@previous_image.nil?

    if @is_dead==false then

      # set_image @anim_move   
      # @cooldown_counter-=1
      # @cooldown_counter=@cooldown_time unless @cooldown_counter>0

      if @attack==false
        set_image @anim_move   
        @cooldown_counter-=1
        @cooldown_counter=@cooldown_time unless @cooldown_counter>0

        if @speed==0
          @image=@anim_move[0]
        end
      else
        set_image @anim_attack
        @cooldown_counter-=1
        @cooldown_counter=@cooldown_time unless @cooldown_counter>0
      end

    else
      hide_hp_bar
      set_image @anim_die
      @cooldown_counter-=1
      @remove_unit=true unless @cooldown_counter>0
    end

    super

  end

  def die
    @is_dead=true
    @cooldown_time=50
    @cooldown_counter=@cooldown_time
    @anim_die=load_sprites("../data/graphics/"+@player_id+"/Units/"+@type+"/die")
  end

  def move
    if @is_dead==false then
      if orientation==1
        @x+=@speed
      else
        @x-=@speed
      end
    else
      # @time_to_die-=50
    end
  end

  def attacking(damage)
    if @attack_counter<=0
      @attack_counter=@attack_time
      hit(damage)
    end
    @attack_counter-=1
  end

  def hit(damage)
    unless @is_dead
      @hp-=damage
      unless @hp>0
        @hp=0
        die
      end

      show_hp_bar 60,25
    end
  end
  def corpse
    @z=1
    @image=@anim_die[@anim_die.size-1]
    # abort(@image.inspect)
  end

  def init(type)
    if type=='swordsman'
      @recruit_swordsman=Gosu::Sample.new(@game_window, "../data/sounds/"+@player_id+"/recruit_swordsman.wav")
      @max_hp=350
      @damage=100
      @speed=1.5
      @max_unit_speed=@speed
      @anim_move=load_sprites("../data/graphics/"+@player_id+"/Units/swordsman/walk")
      @anim_attack=load_sprites("../data/graphics/"+@player_id+"/Units/swordsman/attack")
      @recruit_swordsman.play
      @cost=100
      @radius=25
    end
    if type=='pikeman'
      @recruit_pikeman=Gosu::Sample.new(@game_window, "../data/sounds/"+@player_id+"/recruit_pikeman.wav")
      @max_hp=300
      @damage=80
      @speed=1
      @max_unit_speed=@speed
      @anim_move=load_sprites("../data/graphics/"+@player_id+"/Units/pikeman/walk")
      @anim_attack=load_sprites("../data/graphics/"+@player_id+"/Units/pikeman/attack")
      @recruit_pikeman.play
      @cost=100
      @radius=30
    end
    if type=='horseman'
      @recruit_horseman=Gosu::Sample.new(@game_window, "../data/sounds/"+@player_id+"/recruit_horseman.wav")
      @max_hp=400
      @damage=150
      @speed=2
      @max_unit_speed=@speed
      @anim_move=load_sprites("../data/graphics/"+@player_id+"/Units/horseman/walk")
      @anim_attack=load_sprites("../data/graphics/"+@player_id+"/Units/horseman/attack")
      @recruit_horseman.play
      @cost=100
      @radius=55
    end
      @cooldown_time=@frame_time*@anim_move.size
      @hp=@max_hp
  end
end
