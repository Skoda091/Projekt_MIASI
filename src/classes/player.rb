require 'gosu'
require_relative '../classes/archer.rb'
require_relative '../classes/building.rb'
require_relative '../classes/nexus.rb'
require_relative '../classes/unit.rb'
require_relative '../classes/label.rb'

class Player
  attr_accessor :walls, :units, :corpse, :nexus, :gold
  def initialize (window,orientation,engine)
    @game_window=window
    @orientation=orientation
    @engine=engine
    @gold=1000
    @cooldown=100.0
    @count=false
    @cooldown_decay=0.995
    @nexus=Nexus.new(orientation=='left' ? 0 : window.res_x,engine.horizont_pos,@game_window,@orientation)
    @walls=Array.new
    @units=Array.new
    @label=Label.new(@game_window,@orientation)
    @label.draw(@gold)
    @corpse=Array.new

    @pikeman_cost=100
    @swordsman_cost=300
    @horseman_cost=500

    @cooldown_sample=0
    @cooldown_sample_time=100
    @cant_recruit=Gosu::Sample.new(@game_window, "../data/sounds/Taxes_rate6.wav")


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
    @cooldown_sample-=0.5
    if @cooldown.between?(50,99) 
      @label.deny(@gold)
    else
      @label.draw(@gold)
    end
    @nexus.draw
    @walls.each { |x| x.draw}
    unless @units.empty?
      @units.each { |u| u.draw}
    end
    @corpse.each { |u| u.draw}  
  end

  def recruit (x, y, player, unit)
      if @cooldown==100&&self.can_recruit?(unit)
        @count=true
        tmp=Unit.new(x,y,@game_window,player,unit)
        @units.push(tmp)
      end
  end

  def can_recruit?(unit)
    @tmp_cost=0
    case unit
      when "swordsman"
        @tmp_cost=@swordsman_cost
      when "pikeman"
        @tmp_cost=@pikeman_cost
      when "horseman"
        @tmp_cost=@horseman_cost
      end
    if @gold>=@tmp_cost
      @gold-=@tmp_cost
      return true
    else
      if @cooldown_sample<=0
        @cant_recruit.play
        @cooldown_sample=@cooldown_sample_time
      end
      return false
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
