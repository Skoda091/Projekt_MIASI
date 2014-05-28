require 'gosu'
require 'texplay'

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

  def draw
    @image.draw_rot(@x, @y,1,0) unless @image.nil?
    @image.line 0, -100 , 50, 0, :thickness => 50
  end
  
  def load_sprites (path) #"../data/graphics/Units/<unitname>/<Action>"
    images=[]
    i=0;
    @count=Dir.glob(File.join(path, '**', '*')).select { |file| File.file?(file) }.count
    begin
      for i in 0..@count
        images << Gosu::Image.new(@game_window, path+"/"+i.to_s+".png")
      end
    rescue
    return images
    end
  end

  def show_hp_bar
  
  end

end
