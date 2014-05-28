require 'gosu'
load '../src/classes/object.rb'

class Unit < Object
  attr_accessor :time_to_die
  def initialize(x,y,window,player_id,type)
    super(x,y,window,player_id)
    @hp,@cost,@speed=0
    @recruit_pikeman=Gosu::Sample.new(@game_window, "../data/sounds/recruit_pikeman.wav")
    @recruit_swordsman=Gosu::Sample.new(@game_window, "../data/sounds/recruit_swordsman.wav")
    @recruit_horseman=Gosu::Sample.new(@game_window, "../data/sounds/recruit_horseman.wav")
    @is_dead=false
    @time_to_die=900
    @frame_time=100
    @frame_number=0
    @type=type
    @z=2
    @animation_speed=100

    @buff=0
    init(@type)
  end

  def draw()
    if @is_dead==false then
      img = @image[Gosu::milliseconds / @animation_speed % @image.size];
    else
      @frame_time-=10
      if @frame_number<=@image.size-1 then
        if @frame_time<0 then
          @frame_number+=1
          @frame_time=100
        end
        img = @image[@frame_number]
      else
          @time_to_die= -1
      end
      
             #img = @image[Gosu::milliseconds / @animation_speed % @image.size];

    end
      img.draw_rot(@x, @y, @z, 0, 0.2, 1, orientation, 1)
  end

  def die
    @is_dead=true
    @image=load_sprites("../data/graphics/Units/"+@type+"/die")
  end

  def move()
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

  def attack(target)
    @image=load_sprites("../data/graphics/Units/"+@type+"/attack")
  end

  def init(type)
    case type
      when "swordsman" then @hp=100, @cost=100,@speed=1.5, @image=load_sprites("../data/graphics/Units/swordsman/walk"), @recruit_swordsman.play
      when "pikeman" then @hp=100, @cost=100,@speed=1, @image=load_sprites("../data/graphics/Units/pikeman/walk"), @recruit_pikeman.play
      when "horseman" then @hp=100, @cost=100,@speed=2, @image=load_sprites("../data/graphics/Units/horseman/walk"), @recruit_horseman.play
    end

  end
end