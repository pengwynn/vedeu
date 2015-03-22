module Vedeu

  # Converts a grid of {Vedeu::Char} objects into a stream of escape sequences
  # and content suitable for a terminal.
  #
  class Renderer

    # @param output [Array<Array<Vedeu::Char>>]
    # @return [String]
    def self.render(*output)
      new(*output).render
    end

    # Returns a new instance of Vedeu::Renderer.
    #
    # @param output [Array<Array<Vedeu::Char>>]
    # @return [Vedeu::Renderer]
    def initialize(*output)
      @output = output
    end

    # @return [String]
    def render
      Array(output).flatten.map(&:to_s).join
    end

    private

    # @!attribute [r] output
    # @return [Array<Array<Vedeu::Char>>]
    attr_reader :output

  end # Renderer

end # Vedeu
