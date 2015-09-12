module Vedeu

  module Terminal

    # All output will be written to this singleton, and #render will be called
    # at the end of each run of {Vedeu::MainLoop}; effectively rendering this
    # buffer to each registered renderer. This buffer is not cleared after this
    # action though, as subsequent actions will modify the contents. This means
    # that individual parts of Vedeu can write content here at various points
    # and only at the end of each run of {Vedeu::MainLoop} will it be actually
    # output 'somewhere'.
    #
    module Buffer

      extend self

      # @return [Array<Array<void>>]
      def output
        @output ||= terminal
      end

      # @return [void|NilClass]
      def render
        Vedeu.renderers.render(self) if Vedeu.ready?
      end

      # @return [Array<Array<void>>]
      def reset
        @output = terminal
      end

      # @return [Array<Array<Vedeu::Cell>>]
      def terminal
        Array.new(Vedeu.height) do |y|
          Array.new(Vedeu.width) do |x|
            Vedeu::Cell.new(position: [y + 1, x + 1])
          end
        end
      end

      # @param value [Array<Array<void>>]
      # @return [Vedeu::Terminal::Buffer]
      def write(value)
        if value.is_a?(Array)



        end


        if value.respond_to?(:position) && value.position.is_a?(Vedeu::Position)
          output[value.position.y][value.position.x] = value

        else

        end

        self
      end

    end # Buffer

  end # Terminal

end # Vedeu
