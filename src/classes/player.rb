require 'gosu'
require_relative '../classes/archer.rb'
require_relative '../classes/building.rb'
require_relative '../classes/unit.rb'
require_relative '../classes/label.rb'

class Player
  attr_accessor :walls, :units
  def initialize (window,orientation,engine)
    @game_window=window
    @orientation=orientation
    @engine=engine
    @cooldown=100.0
    @count=false
    @cooldown_decay=0.995
    @walls=Array.new
    @units=Array.new
    @label=Label.new(@game_window,@orientation)


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
    @label.draw
    @walls.each { |x| x.draw}
    unless @units.empty?
      @units.each { |u| u.draw}
    end
  end

  def recruit (x, y, player, unit)
    if @cooldown==100
      @label.deny
      @count=true
      tmp=Unit.new(x,y,@game_window,player,unit)
      @units.push(tmp)
    end
  end

  def cooldown
    if @count==true
      if @cooldown<=50
        @count=false
        @cooldown=100
        @label.draw
      else
        @cooldown*=@cooldown_decay
      end
    end
  end

end