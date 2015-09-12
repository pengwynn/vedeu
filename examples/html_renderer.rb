#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'vedeu'

# An example application to demonstrate colours, cursor and interface movement,
# maximising/unmaximising of interfaces and toggling of cursors and interfaces.
#
# If you have cloned this repository from GitHub, you can run this example:
#
#     ./examples/html_renderer_app.rb
#
# Running this application once, and immediately exiting produces the diagram
# at `./examples/html_renderer_app_20150721.svg`. Hopefully this will help
# you to understand how parts of Vedeu work together. Questions are always
# welcome at `https://github.com/gavinlaking/vedeu/issues`
#
class VedeuHTMLRenderer

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  # Be aware that running an application with debugging enabled will affect
  # performance.
  Vedeu.configure do
    debug!
    log '/tmp/vedeu_html_renderer_app.log'
    renderers Vedeu::Renderers::Terminal.new
  end

  Vedeu.interface 'main_interface' do
    border 'main_interface' do
      colour foreground: '#ffffff', background: :default
      title 'Rainbow!'
      caption('Unicorns!')
    end
    colour foreground: '#ffffff', background: :default
    cursor!
    geometry 'main_interface' do
      x  3
      xn 12
      y  2
      yn 5
    end
    zindex 1
  end



  Vedeu.keymap('_global_') do
    key('q')        { Vedeu.trigger(:_exit_) }
  end

  Vedeu.renders do
    view 'main_interface' do
      line { centre 'Red', width: 9, background: '#f44336' }
    end
  end

  Vedeu.focus_by_name 'main_interface'

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # VedeuHTMLRenderer

VedeuHTMLRenderer.start(ARGV)
