require 'gosu'

class Object
  attr_accessor :x,:y,:game_window,:player_id
  def initialize (x,y,window,player_id)
    @x,@y=x,y
    @game_window=window
    @player_id=player_id #left, right, neutral
    @image=nil
    
  end

  def orientation 
    if @player_id=="left"
      return 1
    else
      return -1
    end
  end
  
  def load_sprites (path) #"../data/graphics/Units/<unitname>/<Action>"
    images=[]
    i=0;
    begin
      while Gosu::Image.new(@game_window, path+"/"+i.to_s+".png")!=nil do
      images << Gosu::Image.new(@game_window, path+"/"+i.to_s+".png")
      end
    rescue
    i=nil
    ensure
    return images
    end
  end
end
