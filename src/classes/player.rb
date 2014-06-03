require 'gosu'
require_relative '../classes/archer.rb'
require_relative '../classes/building.rb'
require_relative '../classes/nexus.rb'
require_relative '../classes/unit.rb'
require_relative '../classes/label.rb'

class Player
  attr_accessor :walls, :units, :corpse
  def initialize (window,orientation,engine)
    @game_window=window
    @orientation=orientation
    @engine=engine
    @cooldown=100.0
    @count=false
    @cooldown_decay=0.995
    @nexus=Nexus.new(orientation=='left' ? 0 : window.res_x,engine.horizont_pos,@game_window,@orientation)
    @walls=Array.new
    @units=Array.new
    @label=Label.new(@game_window,@orientation)
    @label.draw
    @corpse=Array.new


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
    if @cooldown.between?(50,99) 
      @label.deny
    else
      @label.draw
    end
    @nexus.draw
    @walls.each { |x| x.draw}
    unless @units.empty?
      @units.each { |u| u.draw}
    end
    @corpse.each { |u| u.draw}  
  end

  def recruit (x, y, player, unit)
    if @cooldown==100
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
      else
        @cooldown*=@cooldown_decay
      end
    end
  end

  def collision
    i=0
    if @units.count>1
      @units.each {
                    |u|
                    # u.speed = u.max_unit_speed
                    if u!=@units[0]
                      if Gosu::distance(u.x,u.y, @units[i].x,@units[i].y)<u.radius+@units[i].radius
                        u.speed = @units[i].speed
                      else
                        u.speed = u.max_unit_speed
                      end
                      if i==@units.count-1
                        break
                      else
                      i += 1
                      end
                    end
                  }
    end
  end
end
