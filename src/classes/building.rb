require 'gosu'
require_relative '../classes/object.rb'

class Building < Object
  def initialize(x,y,window,player_id)
    super
    @z=1
  end
end