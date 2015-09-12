module Vedeu

  module Renderers

    # Converts a grid of {Vedeu::Views::Char} objects into a stream of escape
    # sequences and content suitable for a terminal.
    #
    class Terminal

      include Vedeu::RendererOptions

      # Returns a new instance of Vedeu::Renderers::Terminal.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::Terminal]
      def initialize(options = {})
        @options = options || {}
      end

      # @param buffer [Vedeu::Terminal::Buffer]
      # @return [Array<String>]
      def render(buffer)
        Vedeu::Terminal.output(parsed(buffer))
      end

      private

      def compression
        options[:compression]
      end
      alias_method :compression?, :compression

      # @param buffer [Vedeu::Terminal::Buffer]
      # @return [Array<Array<Vedeu::Views::Char>>]
      def parsed(buffer)
        if compression?
          Vedeu.timer('Compression') { Vedeu::Compressor.render(content(buffer)) }

        else
          content(buffer)

        end
      end

      def content(buffer)
        buffer.output.flatten.delete_if do |cell|
          cell.is_a?(Vedeu::Cell)
        end
      end

      # @return [Hash<Symbol => Boolean>]
      def defaults
        {
          compression: false,
        }
      end

    end # Terminal

  end # Renderers

end # Vedeu
