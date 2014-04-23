class Unit < Object
  def initialize(x,y,window,path,player_id)
    super(x,y,window,path,player_id)
    @hp,@cost,@speed=0
  end

  def draw()

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
end