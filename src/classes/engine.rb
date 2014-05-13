class Engine
attr_accessor :horizont_pos,:wall_pos
  def initialize(window)
    @game_window=window
    @wall_pos=300
    @horizont_pos=@game_window.res_y-100
   end


end