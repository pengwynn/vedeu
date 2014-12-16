#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

trap('INT') { exit! }

# require 'bundler/setup' # uncomment to remove the need to do `bundle exec`.
require 'vedeu'

class MenusApp
  include Vedeu

  Vedeu.menu 'game_menu' do
    items [:game1, :game2, :game3]
  end

  Vedeu.menu 'help_menu' do
    items [:help1, :help2, :help3]
  end

  event(:_initialize_) do
    trigger(:show_game_menu)
  end

  event :show_help_menu do
    @active_menu = 'help_menu'
    # HelpView.new.show
    trigger(:_refresh_)
  end

  event :show_game_menu do
    @active_menu = 'game_menu'
    # GameView.new.show
    trigger(:_refresh_)
  end

  event :menu_prev_event do
    trigger(:move_menu_prev, {menu: @active_menu} )
    trigger("show_#{@active_menu}".to_sym)
  end

  event :move_menu_prev do |hash_args|
    trigger(:_menu_prev_, hash_args[:menu])
  end

  event :menu_next_event do
    trigger(:move_menu_next, {menu: @active_menu} )
    trigger("show_#{@active_menu}".to_sym)
  end

  event :move_menu_next do |hash_args|
    trigger(:_menu_next_, hash_args[:menu])
  end

  keys do
    key('k') do
      trigger(:menu_prev_event)
    end
    key('j') do
      trigger(:menu_next_event)
    end
    key('h') do
      trigger(:show_help_menu)
    end
    key('g') do
      trigger(:show_game_menu)
    end
  end

  def self.start
    Vedeu::Launcher.execute!(ARGV)
  end
end

MenusApp.start
