module Vedeu

  # This module is the direct interface between Vedeu and your terminal/
  # console, via Ruby's IO core library.
  #
  module Terminal

    include Vedeu::Terminal::Mode
    extend self

    # Opens a terminal screen in either `raw` or `cooked` mode. On exit,
    # attempts to restore the screen. See {Vedeu::Terminal#restore_screen}.
    #
    # @raise [Vedeu::Error::InvalidSyntax] The required block was not given.
    # @return [Array]
    def open
      fail Vedeu::Error::InvalidSyntax, 'block not given' unless block_given?

      if raw_mode? || fake_mode?
        console.raw    { initialize_screen(mode) { yield } }

      else
        console.cooked { initialize_screen(mode) { yield } }

      end
    ensure
      restore_screen
    end

    # Takes input from the user via the keyboard. Accepts special keys like
    # the F-Keys etc, by capturing the entire sequence.
    #
    # @return [String]
    def input
      Vedeu.log(type: :input, message: 'Waiting for user input...')

      if raw_mode? || fake_mode?
        Vedeu::Editor::Capture.read(console)

      else
        console.gets.chomp

      end
    end
    alias_method :read, :input

    # Prints the streams to the screen and returns the streams.
    #
    # @param streams [String|Array]
    # @return [Array]
    def output(*streams)
      streams.each { |stream| console.print(stream) }
    end
    alias_method :write, :output

    # When the terminal emit the 'SIGWINCH' signal, Vedeu can intercept this
    # and attempt to redraw the current interface with varying degrees of
    # success. Can also be used to simulate a terminal resize.
    #
    # @example
    #   Vedeu.resize
    #
    # @return [TrueClass]
    def resize
      Vedeu.trigger(:_clear_)

      Vedeu.trigger(:_refresh_)

      true
    end

    # @param mode [Symbol]
    # @return [void]
    def initialize_screen(mode)
      Vedeu.log(type: :info, message: "Terminal entering '#{mode}' mode")

      output(Esc.string('screen_init'))

      yield if block_given?
    end

    # Clears the entire terminal space.
    #
    # @example
    #   Vedeu.clear
    #
    # @return [String]
    def clear
      virtual.clear if Vedeu::Configuration.drb?

      output(Esc.string('clear'))
    end

    # Attempts to tidy up the screen just before the application terminates.
    # The cursor is shown, colours are reset to terminal defaults, the
    # terminal is told to reset, and finally we clear the last line ready for
    # the prompt.
    #
    # @return [String]
    def restore_screen
      output(Esc.string('screen_exit'))
    end

    # Sets the cursor to be visible unless in raw mode, whereby it will be left
    # hidden.
    #
    # @return [String]
    def set_cursor_mode
      output(Esc.string('show_cursor')) unless raw_mode?
    end

    # Returns a coordinate tuple of the format [y, x], where `y` is the row/line
    # and `x` is the column/character.
    #
    # @return [Array]
    def centre
      [(height / 2), (width / 2)]
    end

    # Returns the `y` (row/line) component of the coordinate tuple provided by
    # {Vedeu::Terminal.centre}
    #
    # @return [Fixnum]
    def centre_y
      centre[0]
    end

    # Returns the `x` (column/character) component of the coodinate tuple
    # provided by {Vedeu::Terminal.centre}
    #
    # @return [Fixnum]
    def centre_x
      centre[-1]
    end

    # Returns 1. This 1 is either the top-most or left-most coordinate of the
    # terminal.
    #
    # @return [Fixnum]
    def origin
      1
    end
    alias_method :x, :origin
    alias_method :y, :origin
    alias_method :tx, :origin
    alias_method :ty, :origin

    # Returns the total width (number of columns/characters) of the current
    # terminal.
    #
    # @example
    #   Vedeu.width # => provides the width via the Vedeu API.
    #
    # @return [Fixnum]
    def width
      return Vedeu::Configuration.drb_width if Vedeu::Configuration.drb?

      size[-1]
    end
    alias_method :xn, :width
    alias_method :txn, :width

    # Returns the total height (number of rows/lines) of the current terminal.
    #
    # @example
    #   Vedeu.height # => provides the height via the Vedeu API.
    #
    # @return [Fixnum]
    def height
      return Vedeu::Configuration.drb_height if Vedeu::Configuration.drb?

      size.first
    end
    alias_method :yn, :height
    alias_method :tyn, :height

    # Returns a tuple containing the height and width of the current terminal.
    #
    # @note
    #   If the terminal is a odd number of characters in height or width, then
    #   1 is deducted from the dimension to make it even. For example; the
    #   actual terminal is height: 37, width: 145, then the reported size will
    #   be 36, 144 respectively.
    #
    #   This is done to make it easier for client applications to divide the
    #   terminal space up when defining interfaces or views, leading to more
    #   consistent rendering.
    #
    #   If the client application is using the {Vedeu::Geometry::Grid#rows} or
    #   {Vedeu::Geometry::Grid#columns} helpers, the dimensions are made more
    #   consistent using this approach.
    #
    # @return [Array]
    def size
      h, w = console.winsize

      h = (h.even? ? h : h - 1)
      w = (w.even? ? w : w - 1)

      [h, w]
    end

    # Provides our gateway into the wonderful rainbow-filled world of IO.
    #
    # @return [File]
    def console
      IO.console
    end

    # @return [Vedeu::VirtualBuffer]
    def virtual
      @virtual ||= Vedeu::VirtualBuffer.new(height, width)
    end

  end # Terminal

end # Vedeu
