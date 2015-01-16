require 'gosu'

require_relative 'player'
require_relative 'bullet'
require_relative 'scene'
require_relative 'intro'
require_relative 'level'
require_relative 'zorder'
require_relative 'bullet'
require_relative 'enemy'
require_relative 'enemy_bullet'

include ZOrder

class Orizn < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = "orizn:prototype"
    @level = Intro.new(self)
    @start = false
  end
  
  def update
    @level.update
  end
  
  def draw
    @level.draw
  end
  
  def button_down(id)
    close if id == Gosu::KbEscape
    press_enter if id == Gosu::KbReturn
    if @level.instance_of? Level
      @level.player.button_down(id)
    end
  end
  
  def press_enter
    if @start == false
      @level.song.stop
      @level.sample.play
      @level = Level.new(self)
    end
    
    if @level.gameover == true
      @level = Level.new(self)
    end
    
    @start = true
  end
end

Orizn.new.show