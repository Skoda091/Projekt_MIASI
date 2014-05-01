require 'gosu'

class Object
  attr_accessor :x,:y,:game_window,:player_id
  def initialize (x,y,window,player_id)
    @x,@y=x,y
    @game_window=window
    @player_id=player_id #left, right, neutral
    @image=nil

  end



  def orientation (player_id)
    if player_id=="left"
      return false
    else
      return true
    end
  end
end