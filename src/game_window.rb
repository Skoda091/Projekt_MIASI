require 'gosu'

load '../src/classes/unit.rb'
load '../src/classes/bird.rb'

require_relative '../src/classes/player.rb'
require_relative '../src/classes/engine.rb'

class GameWindow < Gosu::Window
  attr_accessor :left,:right,:res_x,:res_y,:birds,:engin
  def initialize

    @z=0
    @res_x,@res_y=1920,1080
    super @res_x, @res_y, true
    @res_x+=0.0
    @res_y+=0.0
    @res_y_recruit=@res_y-50
    self.caption = "Gladius"
    @background_sky = Gosu::Image.new(self, "../data/graphics/Background/sky.png", false)
    @background_ground = Gosu::Image.new(self, "../data/graphics/Background/grass1.jpg", false)
    
    @engin=Engine.new(self)
    @left=Player.new(self,"left",@engin)
    @right=Player.new(self,"right",@engin)
    @watch_out=false

    @birds=Array.new
    @birds_corpse=Array.new
  end

  def update
    @birds << Bird.new(self,"left") if rand((@birds.count+1)*160)==0
    @birds.each { |e|  @birds_corpse << e if e.dead? }
    @birds_corpse.reject! {|e| e.dead?}


    @birds.each { |e| e.move}
    @birds_corpse.each { |e| e.move}

    @left.walls.reject! { |e| e.dead? }
    @right.walls.reject! { |e| e.dead? }

    self.button_action

    @left.units.each {|d| d.corpse and @left.corpse << d if d.remove_unit }
    @right.units.each {|d| d.corpse and @right.corpse << d if d.remove_unit }

    @left.units.reject! {|u| u.remove_unit}
    @right.units.reject! {|u| u.remove_unit}

    @left.corpse.each {|u| u.corpse}
    @right.corpse.each {|u| u.corpse}

    @left.collision
    @right.collision

    @left.units.each {|u| u.move}
    @right.units.each {|u| u.move}
    @left.walls.each { |x| x.bow.arrows_fly}
    @right.walls.each { |x| x.bow.arrows_fly}
    @left.cooldown
    @right.cooldown

    self.players_units_colision
    self.units_and_walls_collision
    self.units_and_nexus_collision

  end

  def draw

    @background_sky.draw(0, 0, 0,@res_x/@background_sky.width,@res_y-100.0/@background_sky.height)
    @background_ground.draw(0,@res_y-100,0,@res_x/@background_ground.width,100.0/@background_ground.height)

    

    @left.draw
    @right.draw


    @birds.each { |e| e.draw}
    @birds_corpse.each { |e| e.draw}
  end


def button_down(id)
  if id == Gosu::KbEscape
    close
  end
end

def players_units_colision
  if !@left.units.empty?&&!@right.units.empty?
    if Gosu::distance(@left.units.first.x,@left.units.first.y, @right.units.first.x,@right.units.first.y)<@left.units.first.radius+@right.units.first.radius+20
      @left.units.first.speed=0
      @right.units.first.speed=0
      @left.units.first.attack=true
      @right.units.first.attack=true
      @left.units.first.attacking(@right.units.first.damage)
      @right.units.first.attacking(@left.units.first.damage)
      @watch_out=true
    else
      @left.units.first.speed=@left.units.first.max_unit_speed
      @right.units.first.speed=@right.units.first.max_unit_speed
      @left.units.first.attack=false
      @right.units.first.attack=false
      @watch_out=false
    end
  else
    @left.units.first.speed=@left.units.first.max_unit_speed if !@left.units.empty?
    @right.units.first.speed=@right.units.first.max_unit_speed if !@right.units.empty?
    @left.units.first.attack=false if !@left.units.empty?
    @right.units.first.attack=false if !@right.units.empty?
    @watch_out=false
  end
end

def units_and_walls_collision
  if !@left.units.empty?&&!@right.walls.empty?
    if Gosu::distance(@left.units.first.x,@left.units.first.y, @right.walls.last.x, @right.walls.last.y_down)<@left.units.first.radius+50#&&!@right.walls.last.collapsed
      @left.units.first.speed=0
      @left.units.first.attack=true
      @left.units.first.attacking_walls
    else
      if !@watch_out
        @left.units.first.speed=@left.units.first.max_unit_speed #if @right.walls.last.collapsed
        @left.units.first.attack=false
      end
    end

  end
  if !@right.units.empty?&&!@left.walls.empty?
    if Gosu::distance(@right.units.first.x,@right.units.first.y, @left.walls.last.x, @left.walls.last.y_down)<@right.units.first.radius+50
      @right.units.first.speed=0
      @right.units.first.attack=true
      @right.units.first.attacking_walls
    else
      if !@watch_out
        @right.units.first.speed=@right.units.first.max_unit_speed
        @right.units.first.attack=false
      end
    end

  end
end

def units_and_nexus_collision
  if !@left.units.empty?
    if Gosu::distance(@left.units.first.x,@left.units.first.y, @right.nexus.x, @left.units.first.y)<@left.units.first.radius+70
      @left.units.first.speed=0
      @left.units.first.attack=true
      @left.units.first.attacking_nexus
    end
  end
  if !@right.units.empty?
    if Gosu::distance(@right.units.first.x,@right.units.first.y, @left.nexus.x, @right.units.first.y)<@right.units.first.radius+70
      @right.units.first.speed=0
      @right.units.first.attack=true
      @right.units.first.attacking_nexus
    end
  end
end

def win
  if @left.nexus.hp<=0
    
  end
  if @right.nexus.hp<=0
  end
end

def button_action

  #Strzelanie gracz lewy
  #######################
  if button_down? Gosu::KbLeft  then
    @right.walls.each { |x| x.bow.angle_change(false)}
  end
  if button_down? Gosu::KbRight  then
    @right.walls.each { |x| x.bow.angle_change(true)}
  end
  if button_down? Gosu::KbEnter then
    @right.walls.each { |x| x.bow.shoot}
  end

  #Strzelanie gracz prawy
  #######################
  if button_down? Gosu::KbA  then
    @left.walls.each { |x| x.bow.angle_change(false)}
  end
  if button_down? Gosu::KbD  then
    @left.walls.each { |x| x.bow.angle_change(true)}
  end
  if button_down? Gosu::KbSpace then
    @left.walls.each { |x| x.bow.shoot}
  end

  
  # Rekrutacja jednostek
  if button_down? Gosu::Kb1 then
    @left.recruit(0,@res_y_recruit,"left","pikeman")
  end
  if button_down? Gosu::Kb0 then
    @right.recruit(@res_x,@res_y_recruit,"right","pikeman")
  end
  if button_down? Gosu::Kb2 then
    @left.recruit(0,@res_y_recruit,"left","swordsman")
  end
  if button_down? Gosu::Kb9 then
    @right.recruit(@res_x,@res_y_recruit,"right","swordsman")
  end
  if button_down? Gosu::Kb3 then
    @left.recruit(0,@res_y_recruit,"left","horseman")
  end
  if button_down? Gosu::Kb8 then
    @right.recruit(@res_x,@res_y_recruit,"right","horseman")
  end
  if button_down? Gosu::KbLeft  then
    @right.walls.each { |x| x.bow.angle_change(false)}
  end
  if button_down? Gosu::KbRight  then
    @right.walls.each { |x| x.bow.angle_change(true)}
  end
  if button_down? Gosu::KbRightShift then
    @right.walls.each { |x| x.bow.shoot}
  end
  
end

def engine
  return @engin
end

end
window = GameWindow.new
window.show
