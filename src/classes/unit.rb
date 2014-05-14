require 'gosu'
load '../src/classes/object.rb'

class Unit < Object
  def initialize(x,y,window,player_id,type)
    super(x,y,window,player_id)
    @hp,@cost,@speed=0
    @recruit_pikeman=Gosu::Sample.new(@game_window, "../data/sounds/recruit_pikeman.wav")
    @recruit_swordsman=Gosu::Sample.new(@game_window, "../data/sounds/recruit_swordsman.wav")
    @recruit_horseman=Gosu::Sample.new(@game_window, "../data/sounds/recruit_horseman.wav")
    @type=type
    @z=2
    @animation_speed=100
    @frame_name = :scan

    @buff=0
    init(@type)
  end

  def draw()
    
    img = @image[Gosu::milliseconds / @animation_speed % @image.size];
    img.draw_rot(@x, @y, @z, 0, 0.2, 0.5, orientation, 1)
    @buff+=0.1
  end

  def die()
  end

  def move()
    if orientation==1
      @x+=@speed
    else
      @x-=@speed
    end
  end

  def attack(target)

  end

  def init(type)
    # case type

    #   when "swordsman" then @hp=100, @cost=100,@speed=1, @image=Gosu::Image.new(@game_window, "../data/graphics/Units/swordsman/swordsman.gif"), @recruit_swordsman.play
    #   when "pikeman" then @hp=100, @cost=100,@speed=0.5, @image=Gosu::Image.new(@game_window, "../data/graphics/Units/pikeman/pikeman.gif"), @recruit_pikeman.play
    #   when "horseman" then @hp=100, @cost=100,@speed=2, @image=Gosu::Image.new(@game_window, "../data/graphics/Units/cavalier/horseman.gif"), @recruit_horseman.play
    # end

    case type
      when "swordsman" then @hp=100, @cost=100,@speed=1.5, @image=load_sprites("../data/graphics/Units/swordsman/walk"), @recruit_swordsman.play
      when "pikeman" then @hp=100, @cost=100,@speed=1, @image=load_sprites("../data/graphics/Units/pikeman/walk"), @recruit_pikeman.play
      when "horseman" then @hp=100, @cost=100,@speed=2, @image=load_sprites("../data/graphics/Units/cavalier/walk"), @recruit_horseman.play
    end

  end
end