require 'gosu'


class Unit < Object
  def initialize(x,y,window,player_id,type)
    super(x,y,window,player_id)
    @hp,@cost,@speed=0
    @type=type
    @z=2
    #@animation=Gosu::Image::load_tiles(self, "media/Star.png", 25, 25, false)
    init(@type)
  end

  def draw()
    @image.draw_rot(@x, @y, 1, 0)
  end

  def die()

  end

  def move()
    if orientation(player_id)==false
      @x+=@speed
    else
      @x-=@speed
    end
  end

  def attack(target)

  end

  def init(type)
    case type
      when "swordsman" then @hp=100, @cost=100,@speed=5, @image=Gosu::Image.new(window, "../data/graphics/Units/swordsman.gif",orientation(player_id))
      when "pikeman" then @hp=100, @cost=100, @image=Gosu::Image.new(window, "../data/graphics/Units/pikeman.gif",orientation(player_id))
      when "horseman" then @hp=100, @cost=100, @image=Gosu::Image.new(window, "../data/graphics/Units/horseman.gif",orientation(player_id))
    end

  end
end