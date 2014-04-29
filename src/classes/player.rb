require 'gosu'
require_relative '../classes/archer.rb'
require_relative '../classes/building.rb'

class Player
  def initialize (window,orientation)
    @game_window=window
    @orientation=orientation
    @archers=Array.new
    @walls=Array.new
    @arrows=Array.new

    3.times do
      @walls.push(Building.new(1,2,@game_window,@orientation))
      @archers.push(Archer.new())
    end
  end
end