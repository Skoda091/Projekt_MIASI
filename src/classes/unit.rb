require 'gosu'
load '../src/classes/object.rb'

class Unit < Object
  attr_accessor :arrow_hit, :arrow_hit_friendly, :remove_unit, :speed, :max_unit_speed, :radius, :attack, :damage, :cost
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
    @frame_attack
    @remove_unit=false

    @buff=0
    init(@type)
    @change_frame=false

    @arrow_hit=Gosu::Sample.new(@game_window, "../data/sounds/"+player_id+"/arrow_hit.wav")
    @arrow_hit_friendly=Gosu::Sample.new(@game_window, "../data/sounds/"+ (player_id=='left' ? 'right': 'left') +"/arrow_hit.wav")
  end

  def draw()

      @image.draw_rot(@x, @y, @z, 0, 0.2, 1, orientation, 1) and @previous_image=@image unless @image.nil?
      #@previous_image.draw_rot(@x, @y, @z, 0, 0.2, 1, orientation, 1) if @image.nil? and !@previous_image.nil?

    if @is_dead==false then

      # set_image @anim_move   
      # @cooldown_counter-=1
      # @cooldown_counter=@cooldown_time unless @cooldown_counter>0

      if @attack==false
        set_image @anim_move   
        @cooldown_counter-=1
        @cooldown_counter=@cooldown_time unless @cooldown_counter>0

        if @speed==0
          #@image=@anim_move[0]
          set_image @anim_stand 
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
    @game_window.left.gold+=@cost/2 if player_id=="right"
    @game_window.right.gold+=@cost/2 if player_id=="left"
    @die_sound.play
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
      @attack_sound.play
      @attack_counter=@attack_time
      hit(damage)
    end
    @attack_counter-=1
  end

  def attacking_walls
    if @image==@anim_attack[@frame_attack]
      if @change_frame==false
        @attack_sound.play
        @game_window.right.walls.last.hit(@damage) if @player_id=="left"
        @game_window.left.walls.last.hit(@damage) if @player_id=="right"
        @change_frame=true
      end
    else
      @change_frame=false
    end

  end

  def attacking_nexus
    if @image==@anim_attack[@frame_attack]
      if @change_frame==false
        @attack_sound.play
        @game_window.right.nexus.hit(@damage) if @player_id=="left"
        @game_window.left.nexus.hit(@damage) if @player_id=="right"
        @change_frame=true
      end
    else
      @change_frame=false
    end

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
      @die_sound=Gosu::Sample.new(@game_window, "../data/sounds/"+@player_id+"/Units/swordsman/die.wav")
      @attack_sound=Gosu::Sample.new(@game_window, "../data/sounds/"+@player_id+"/Units/swordsman/attack.wav")
      @max_hp=350
      @damage=100
      @speed=1.5
      @max_unit_speed=@speed
      @anim_move=load_sprites("../data/graphics/"+@player_id+"/Units/swordsman/walk")
      @anim_attack=load_sprites("../data/graphics/"+@player_id+"/Units/swordsman/attack")
      @anim_stand=load_sprites("../data/graphics/"+@player_id+"/Units/swordsman/stand")
      @recruit_swordsman.play
      @cost=300
      @radius=65
      @frame_attack=3 if @player_id=="left"
      @frame_attack=2 if @player_id=="right"
    end
    if type=='pikeman'
      @recruit_pikeman=Gosu::Sample.new(@game_window, "../data/sounds/"+@player_id+"/recruit_pikeman.wav")
      @die_sound=Gosu::Sample.new(@game_window, "../data/sounds/"+@player_id+"/Units/pikeman/die.wav")
      @attack_sound=Gosu::Sample.new(@game_window, "../data/sounds/"+@player_id+"/Units/pikeman/attack.wav")
      @max_hp=300
      @damage=80
      @speed=1
      @max_unit_speed=@speed
      @anim_move=load_sprites("../data/graphics/"+@player_id+"/Units/pikeman/walk")
      @anim_attack=load_sprites("../data/graphics/"+@player_id+"/Units/pikeman/attack")
      @anim_stand=load_sprites("../data/graphics/"+@player_id+"/Units/pikeman/stand")
      @recruit_pikeman.play
      @cost=100
      @radius=55
      @frame_attack=5 if @player_id=="left"
      @frame_attack=3 if @player_id=="right"
    end
    if type=='horseman'
      @recruit_horseman=Gosu::Sample.new(@game_window, "../data/sounds/"+@player_id+"/recruit_horseman.wav")
      @die_sound=Gosu::Sample.new(@game_window, "../data/sounds/"+@player_id+"/Units/horseman/die.wav")
      @attack_sound=Gosu::Sample.new(@game_window, "../data/sounds/"+@player_id+"/Units/horseman/attack.wav")
      @max_hp=400
      @damage=150
      @speed=2.5
      @max_unit_speed=@speed
      @anim_move=load_sprites("../data/graphics/"+@player_id+"/Units/horseman/walk")
      @anim_attack=load_sprites("../data/graphics/"+@player_id+"/Units/horseman/attack")
      @anim_stand=load_sprites("../data/graphics/"+@player_id+"/Units/horseman/stand")
      @recruit_horseman.play
      @cost=500
      @radius=75
      @frame_attack=6 if @player_id=="left"
      @frame_attack=4 if @player_id=="right"
    end
      @cooldown_time=@frame_time*@anim_move.size
      @hp=@max_hp
  end
end
