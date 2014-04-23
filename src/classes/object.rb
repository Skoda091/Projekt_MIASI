class Object
  def initialize (x,y,window,path,player_id)
    @x,@y=x,y
    @player_id=player_id #left, right, neutral
    @image=Gosu::Image.new(window, path, orientation(player_id))

  end

  def draw()
    @image.draw_rot(@x, @y, 1, 0)
  end

  def orientation (player_id)
    if player_id=="left"
      return false
    else
      return true
    end
  end
end