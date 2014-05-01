require 'gosu'
require_relative '../classes/archer.rb'
require_relative '../classes/building.rb'

class Player
  attr_accessor :walls
  def initialize (window,orientation,engine)
    @game_window=window
    @orientation=orientation

    @walls=Array.new


    if @orientation=="left"
      for i in 0..2

        tmp=Building.new(engine.wall_pos+i*64,engine.horizont_pos,@game_window,@orientation,2-i)
        tmp.bow=Archer.new(tmp.x,tmp.y-70,@game_window,@orientation)

        @walls.push(tmp)

      end
    else
      for i in 0..2

        tmp=Building.new(window.width-engine.wall_pos-i*64,engine.horizont_pos,@game_window,@orientation,2-i)
        tmp.bow=Archer.new(tmp.x,tmp.y-70,@game_window,@orientation)
        @walls.push(tmp)
      end
    end
  end


  def draw
    @walls.each { |x| x.draw}

  end

end