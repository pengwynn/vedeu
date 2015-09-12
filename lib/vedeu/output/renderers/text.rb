module Vedeu

  module Renderers

    # Converts a grid of {Vedeu::Views::Char} objects into a stream of escape
    # sequences and content.
    #
    class Text

      include Vedeu::RendererOptions

      # Returns a new instance of Vedeu::Renderers::Text.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::Text]
      def initialize(options = {})
        @options = options || {}
      end

      # @param buffer [Vedeu::Terminal::Buffer]
      # @return [String]
      def render(buffer)
        Vedeu::Compressor.render(buffer)
      end

    end # Text

  end # Renderers

end # Vedeu
