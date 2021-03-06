module Vedeu

  module Terminal

    # Store the current mode of the terminal.
    #
    module Mode

      extend self

      # Returns a boolean indicating whether the terminal is currently in
      # `cooked` mode.
      #
      # @return [Boolean]
      def cooked_mode?
        mode == :cooked
      end

      # Sets the terminal in to `cooked` mode.
      #
      # @return [Symbol]
      def cooked_mode!
        @mode = :cooked
      end

      # Returns a boolean indicating whether the terminal is currently in `fake`
      # mode.
      #
      # @return [Boolean]
      def fake_mode?
        mode == :fake
      end

      # Sets the terminal in to `fake` mode.
      #
      # @return [Symbol]
      def fake_mode!
        @mode = :fake
      end

      # Returns a boolean indicating whether the terminal is currently in `raw`
      # mode.
      #
      # @return [Boolean]
      def raw_mode?
        mode == :raw
      end

      # Sets the terminal in to `raw` mode.
      #
      # @return [Symbol]
      def raw_mode!
        @mode = :raw
      end

      # Toggles the terminal's mode between `cooked`, `fake` and `raw`,
      # depending on its current mode.
      #
      # @return [Symbol]
      def switch_mode!
        return fake_mode!   if raw_mode?
        return cooked_mode! if fake_mode?

        raw_mode!
      end

      # Returns the mode of the terminal, either `:cooked`, `:fake` or `:raw`.
      # Can change throughout the lifespan of the client application.
      #
      # @return [Symbol]
      def mode
        @mode ||= Vedeu::Configuration.terminal_mode
      end

    end # Mode

  end # Terminal

end # Vedeu
