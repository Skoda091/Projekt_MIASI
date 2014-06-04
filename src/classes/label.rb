require 'gosu'
require_relative '../classes/object.rb'

class Label < Object
  def initialize(window,player_id)
  	super(x =position(player_id,"x"),y =position(player_id, "y"),window,player_id)
    @z=3

    @font_size=50
    @font_x_shift=5

    @pikeman_cost=100
    @swordsman_cost=200
    @horseman_cost=500

    @gold_cost_icon_size=0.5
    @gold_salary_icon_size=0.5
    @shortcut_icon_size=0.3

    @font_color_for_castle=Gosu::Color.argb(0xffffffff)
    @font_color_for_nekro=Gosu::Color.argb(0xff000000)

    @text=Gosu::Font.new(@game_window, "shortcut", @font_size)
    
    @image_p=Gosu::Image.new(@game_window, "../data/graphics/"+@player_id+"/Units/pikeman/pikeman_poster_1.png")
    @image_s=Gosu::Image.new(@game_window, "../data/graphics/"+@player_id+"/Units/swordsman/swordsman_poster_1.png")
    @image_h=Gosu::Image.new(@game_window, "../data/graphics/"+@player_id+"/Units/horseman/horseman_poster_1.png")
  
    @image_gold_cost_icon=Gosu::Image.new(@game_window, "../data/graphics/icon-gold.png")
    @image_gold_salary_icon=Gosu::Image.new(@game_window, "../data/graphics/coin-stack.png")
    @image_shortcut_icon=Gosu::Image.new(@game_window, "../data/graphics/shortcut-icon.png")
  end
  def draw(gold)
  	if orientation==1
      @image_gold_cost_icon.draw_rot(@x-50, @y-55, @z, 0, 0.5, 0.5, orientation*@gold_cost_icon_size, 1*@gold_cost_icon_size)
      @image_shortcut_icon.draw_rot(@x-50, @y+45, @z, 0, 0.5, 0.5, orientation*@shortcut_icon_size, 1*@shortcut_icon_size)
      @image_gold_salary_icon.draw_rot(@x+40+2*@image_h.width+100, @y, @z, 0, 0.5, 0.5, orientation*@gold_salary_icon_size, 1*@gold_salary_icon_size)
      
      @text.draw(gold, @x+40+2*@image_h.width+150, @y-10, 4, 0.5, 0.5, @font_color_for_castle) 

	  	@image_p.draw_rot(@x, @y, @z, 0, 0.5, 0.5, orientation, 1)
	  	@image_s.draw_rot(@x+20+@image_s.width, @y, @z, 0, 0.5, 0.5, orientation, 1)
	  	@image_h.draw_rot(@x+40+2*@image_h.width, @y, @z, 0, 0.5, 0.5, orientation, 1)

      @text.draw("1", @x-@font_x_shift, @y+30, 4, 0.5, 0.5, @font_color_for_castle) 
      @text.draw("2", @x+20+@image_s.width-@font_x_shift, @y+30, 4, 0.5, 0.5, @font_color_for_castle) 
      @text.draw("3", @x+40+2*@image_h.width-@font_x_shift, @y+30, 4, 0.5, 0.5, @font_color_for_castle) 
    	
      @text.draw(@pikeman_cost, @x-@font_x_shift*4, @y-55, 4, 0.5, 0.5, @font_color_for_castle) 
      @text.draw(@swordsman_cost, @x+20+@image_s.width-@font_x_shift*4, @y-55, 4, 0.5, 0.5, @font_color_for_castle) 
      @text.draw(@horseman_cost, @x+40+2*@image_h.width-@font_x_shift*4, @y-55, 4, 0.5, 0.5, @font_color_for_castle)
    end
  	if orientation==-1
	  	@image_gold_cost_icon.draw_rot(@x+50, @y-55, @z, 0, 0.5, 0.5, orientation*@gold_cost_icon_size, 1*@gold_cost_icon_size)
      @image_shortcut_icon.draw_rot(@x+50, @y+45, @z, 0, 0.5, 0.5, orientation*@shortcut_icon_size, 1*@shortcut_icon_size)
      @image_gold_salary_icon.draw_rot(@x-40-2*@image_h.width-100, @y, @z, 0, 0.5, 0.5, orientation*@gold_salary_icon_size, 1*@gold_salary_icon_size)
      
      @text.draw(gold, @x-40-2*@image_h.width-200, @y-10, 4, 0.5, 0.5, @font_color_for_nekro) 

      @image_p.draw_rot(@x, @y, @z, 0, 0.5, 0.5, orientation, 1)
	  	@image_s.draw_rot(@x-20-@image_s.width, @y, @z, 0, 0.5, 0.5, orientation, 1,)
	  	@image_h.draw_rot(@x-40-2*@image_h.width, @y, @z, 0, 0.5, 0.5, orientation, 1)

      @text.draw("0", @x-@font_x_shift, @y+30, 4, 0.5, 0.5, @font_color_for_nekro) 
      @text.draw("9", @x-20-@image_s.width-@font_x_shift, @y+30, 4, 0.5, 0.5, @font_color_for_nekro) 
      @text.draw("8", @x-40-2*@image_h.width-@font_x_shift, @y+30, 4, 0.5, 0.5, @font_color_for_nekro)

      @text.draw(@pikeman_cost, @x-@font_x_shift*4, @y-55, 4, 0.5, 0.5, @font_color_for_nekro) 
      @text.draw(@swordsman_cost, @x-20-@image_s.width-@font_x_shift*4, @y-55, 4, 0.5, 0.5, @font_color_for_nekro) 
      @text.draw(@horseman_cost, @x-40-2*@image_h.width-@font_x_shift*4, @y-55, 4, 0.5, 0.5,@font_color_for_nekro)  
  	end
  end

  def deny(gold)
  	if orientation==1
	  	@image_gold_cost_icon.draw_rot(@x-50, @y-55, @z, 0, 0.5, 0.5, orientation*@gold_cost_icon_size, 1*@gold_cost_icon_size)
      @image_shortcut_icon.draw_rot(@x-50, @y+45, @z, 0, 0.5, 0.5, orientation*@shortcut_icon_size, 1*@shortcut_icon_size)
      @image_gold_salary_icon.draw_rot(@x+40+2*@image_h.width+100, @y, @z, 0, 0.5, 0.5, orientation*@gold_salary_icon_size, 1*@gold_salary_icon_size)
      
      @text.draw(gold, @x+40+2*@image_h.width+150, @y-10, 4, 0.5, 0.5, @font_color_for_castle)

      @image_p.draw_rot(@x, @y, @z, 0, 0.5, 0.5, orientation, 1,Gosu::Color.argb(0xffff0000))
	  	@image_s.draw_rot(@x+20+@image_s.width, @y, @z, 0, 0.5, 0.5, orientation, 1,Gosu::Color.argb(0xffff0000))
	  	@image_h.draw_rot(@x+40+2*@image_h.width, @y, @z, 0, 0.5, 0.5, orientation, 1,Gosu::Color.argb(0xffff0000))

      @text.draw("1", @x-@font_x_shift, @y+30, 4, 0.5, 0.5, Gosu::Color.argb(0xffff0000)) 
      @text.draw("2", @x+20+@image_s.width-@font_x_shift, @y+30, 4, 0.5, 0.5, Gosu::Color.argb(0xffff0000)) 
      @text.draw("3", @x+40+2*@image_h.width-@font_x_shift, @y+30, 4, 0.5, 0.5, Gosu::Color.argb(0xffff0000))
  	
      @text.draw(@pikeman_cost, @x-@font_x_shift*4, @y-55, 4, 0.5, 0.5, Gosu::Color.argb(0xffff0000)) 
      @text.draw(@swordsman_cost, @x+20+@image_s.width-@font_x_shift*4, @y-55, 4, 0.5, 0.5, Gosu::Color.argb(0xffff0000)) 
      @text.draw(@horseman_cost, @x+40+2*@image_h.width-@font_x_shift*4, @y-55, 4, 0.5, 0.5, Gosu::Color.argb(0xffff0000)) 
    end
  	if orientation==-1
      @image_gold_cost_icon.draw_rot(@x+50, @y-55, @z, 0, 0.5, 0.5, orientation*@gold_cost_icon_size, 1*@gold_cost_icon_size)
      @image_shortcut_icon.draw_rot(@x+50, @y+45, @z, 0, 0.5, 0.5, orientation*@shortcut_icon_size, 1*@shortcut_icon_size)
      @image_gold_salary_icon.draw_rot(@x-40-2*@image_h.width-100, @y, @z, 0, 0.5, 0.5, orientation*@gold_salary_icon_size, 1*@gold_salary_icon_size)
      
      @text.draw(gold, @x-40-2*@image_h.width-200, @y-10, 4, 0.5, 0.5, @font_color_for_nekro) 

	  	@image_p.draw_rot(@x, @y, @z, 0, 0.5, 0.5, orientation, 1,Gosu::Color.argb(0xffff0000))
	  	@image_s.draw_rot(@x-20-@image_s.width, @y, @z, 0, 0.5, 0.5, orientation, 1,Gosu::Color.argb(0xffff0000))
	  	@image_h.draw_rot(@x-40-2*@image_h.width, @y, @z, 0, 0.5, 0.5, orientation, 1,Gosu::Color.argb(0xffff0000))

      @text.draw("0", @x-@font_x_shift, @y+30, 4, 0.5, 0.5,Gosu::Color.argb(0xffff0000)) 
      @text.draw("9", @x-20-@image_s.width-@font_x_shift, @y+30, 4, 0.5, 0.5,Gosu::Color.argb(0xffff0000)) 
      @text.draw("8", @x-40-2*@image_h.width-@font_x_shift, @y+30, 4, 0.5, 0.5, Gosu::Color.argb(0xffff0000)) 
  	  
      @text.draw(@pikeman_cost, @x-@font_x_shift*4, @y-55, 4, 0.5, 0.5, Gosu::Color.argb(0xffff0000)) 
      @text.draw(@swordsman_cost, @x-20-@image_s.width-@font_x_shift*4, @y-55, 4, 0.5, 0.5, Gosu::Color.argb(0xffff0000)) 
      @text.draw(@horseman_cost, @x-40-2*@image_h.width-@font_x_shift*4, @y-55, 4, 0.5, 0.5, Gosu::Color.argb(0xffff0000))
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