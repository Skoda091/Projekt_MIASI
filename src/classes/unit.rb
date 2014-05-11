require 'gosu'
load '../src/classes/object.rb'

class Unit < Object
  def initialize(x,y,window,player_id,type)
    super(x,y,window,player_id)
    @hp,@cost,@speed=0
    @type=type
    @z=2
    #@animation=Gosu::Image::load_tiles(self, "../data/graphics/Units/swordsman.gif", 25, 25, false)
    @color = Gosu::Color.new(0xff000000)
    @color.red = rand(256 - 40) + 40
    @color.green = rand(256 - 40) + 40
    @color.blue = rand(256 - 40) + 40
    init(@type)
  end

  def draw()
    #@image.draw_rot(@x, @y, 1, 0)

    img = @image[Gosu::milliseconds / 100 % @image.size];
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0, 0, 1, 1, @color, :add)

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
=begin
    case type
      when "swordsman" then @hp=100, @cost=100,@speed=5, @image=Gosu::Image.new(@game_window, "../data/graphics/Units/swordsman.gif",orientation(@player_id))
      when "pikeman" then @hp=100, @cost=100,@speed=2, @image=Gosu::Image.new(@game_window, "../data/graphics/Units/pikeman.gif",orientation(@player_id))
      when "horseman" then @hp=100, @cost=100,@speed=8, @image=Gosu::Image.new(@game_window, "../data/graphics/Units/horseman.gif",orientation(@player_id))
    end
=end

    case type
      when "swordsman" then @hp=100, @cost=100,@speed=5, @image=Gosu::Image.load_tiles(@game_window, "../data/graphics/Units/pikeman_anim.png", 25, 25, false)
      when "pikeman" then @hp=100, @cost=100,@speed=2, @image=Gosu::Image::load_tiles(@game_window, "../data/graphics/Units/pikeman_anim.png", 25, 25, false)
      when "horseman" then @hp=100, @cost=100,@speed=8, @image=Gosu::Image.load_tiles(@game_window, "../data/graphics/Units/pikeman_anim.png", 25, 25, false)
    end

  end
end