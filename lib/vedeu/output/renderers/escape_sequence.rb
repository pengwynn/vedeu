module Vedeu

  module Renderers

    # A renderer which returns the escape sequence for each character.
    #
    class EscapeSequence

      include Vedeu::RendererOptions

      # Returns a new instance of Vedeu::Renderers::EscapeSequence.
      #
      # @param options [Hash]
      # @return [Vedeu::Renderers::EscapeSequence]
      def initialize(options = {})
        @options = options || {}
      end

      # Render the output with the escape sequences escaped.
      #
      # @param output [Array<Array<Vedeu::Views::Char>>]
      # @return [String]
      def render(output)
        @parsed ||= Array(output).flatten.map do |char|
          Esc.escape(char.to_s) + "\n"
        end.join
      end

    end # EscapeSequence

  end # Renderers

end # Vedeu
