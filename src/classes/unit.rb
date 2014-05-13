require 'gosu'
load '../src/classes/object.rb'

class Unit < Object
  def initialize(x,y,window,player_id,type)
    super(x,y,window,player_id)
    @hp,@cost,@speed=0
    @type=type
    @z=2

    # Load the full animation from tile-file media/droid.bmp
=begin
    @animation = Chingu::Animation.new(:file => "droid_11x15.bmp")
    @animation.frame_names = { :scan => 0..5, :up => 6..7, :down => 8..9, :left => 10..11, :right => 12..13 }
=end

    # Start out by animation frames 0-5 (contained by @animation[:scan])
    @frame_name = :scan




    init(@type)
  end

  def draw()

    if orientation(@player_id)==false
      @image.draw_rot(@x, @y, 1, 0, 0.5, 0.5, 1, 1)
    else
      @image.draw_rot(@x, @y, 1, 0, 0.5, 0.5, -1, 1)
    end
    #draw_rot(x, y, z, angle, center_x = 0.5, center_y = 0.5, factor_x = 1, factor_y = 1, color = 0xffffffff, mode = :default) 
=begin
  
rescue Exception => e
  
end
    img = @image[Gosu::milliseconds / 100 % @image.size];
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0, 0, 1, 1, 0xffffffff, :default)

=end


  end

  def die()

  end

  def move()
    if orientation(@player_id)==false
      @x+=@speed
    else
      @x-=@speed
    end
  end

  def attack(target)

  end

  def init(type)

    case type
      when "swordsman" then @hp=100, @cost=100,@speed=1, @image=Gosu::Image.new(@game_window, "../data/graphics/Units/swordsman.gif",orientation(@player_id))
      when "pikeman" then @hp=100, @cost=100,@speed=0.5, @image=Gosu::Image.new(@game_window, "../data/graphics/Units/pikeman.gif",orientation(@player_id))
      when "horseman" then @hp=100, @cost=100,@speed=2, @image=Gosu::Image.new(@game_window, "../data/graphics/Units/horseman.gif",orientation(@player_id))
    end

=begin
    case type
      when "swordsman" then @hp=100, @cost=100,@speed=1, @image=Gosu::Image.load_tiles(@game_window, "../data/graphics/Units/swordsman2_anim.png", 80, 134, false)
      when "pikeman" then @hp=100, @cost=100,@speed=0.5, @image=Gosu::Image::load_tiles(@game_window, "../data/graphics/Units/pikeman_anim.png", 74, 129, false)
      when "horseman" then @hp=100, @cost=100,@speed=8, @image=Gosu::Image.load_tiles(@game_window, "../data/graphics/Units/horseman.gif", 54, 106, false)
    end
=end
  end
end