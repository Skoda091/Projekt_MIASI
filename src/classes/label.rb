require 'gosu'
require_relative '../classes/object.rb'

class Label < Object
  def initialize(window,player_id)
  	super(x =position(player_id,"x"),y =position(player_id, "y"),window,player_id)
    @z=3
    @image_p=Gosu::Image.new(@game_window, "../data/graphics/"+@player_id+"/Units/pikeman/pikeman_poster_1.png")
    @image_s=Gosu::Image.new(@game_window, "../data/graphics/"+@player_id+"/Units/swordsman/swordsman_poster_1.png")
    @image_h=Gosu::Image.new(@game_window, "../data/graphics/"+@player_id+"/Units/horseman/horseman_poster_1.png")
  end
  def draw
  	if orientation==1
	  	@image_p.draw_rot(@x, @y, @z, 0, 0.5, 0.5, orientation, 1)
	  	@image_s.draw_rot(@x+20+@image_s.width, @y, @z, 0, 0.5, 0.5, orientation, 1)
	  	@image_h.draw_rot(@x+40+2*@image_h.width, @y, @z, 0, 0.5, 0.5, orientation, 1)
  	end
  	if orientation==-1
	  	@image_p.draw_rot(@x, @y, @z, 0, 0.5, 0.5, orientation, 1)
	  	@image_s.draw_rot(@x-20-@image_s.width, @y, @z, 0, 0.5, 0.5, orientation, 1,)
	  	@image_h.draw_rot(@x-40-2*@image_h.width, @y, @z, 0, 0.5, 0.5, orientation, 1)
  	end
  end

  def deny
  	if orientation==1
	  	@image_p.draw_rot(@x, @y, @z, 0, 0.5, 0.5, orientation, 1,Gosu::Color.argb(0xffff0000))
	  	@image_s.draw_rot(@x+20+@image_s.width, @y, @z, 0, 0.5, 0.5, orientation, 1,Gosu::Color.argb(0xffff0000))
	  	@image_h.draw_rot(@x+40+2*@image_h.width, @y, @z, 0, 0.5, 0.5, orientation, 1,Gosu::Color.argb(0xffff0000))
  	end
  	if orientation==-1
	  	@image_p.draw_rot(@x, @y, @z, 0, 0.5, 0.5, orientation, 1,Gosu::Color.argb(0xffff0000))
	  	@image_s.draw_rot(@x-20-@image_s.width, @y, @z, 0, 0.5, 0.5, orientation, 1,Gosu::Color.argb(0xffff0000))
	  	@image_h.draw_rot(@x-40-2*@image_h.width, @y, @z, 0, 0.5, 0.5, orientation, 1,Gosu::Color.argb(0xffff0000))
  	end
  end

  def position(player_id, coordinate)
  	if player_id=="left"&&coordinate=="x"
  		return 100
  	end
  	if player_id=="left"&&coordinate=="y"
  		return 100
  	end
  	if player_id=="right"&&coordinate=="x"
  		return 1820
  	end
  	if player_id=="right"&&coordinate=="y"
  		return 100
  	end
  end
end