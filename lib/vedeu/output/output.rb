module Vedeu

  # Sends the output to the renderers.
  #
  class Output

    # Writes output to the defined renderers.
    #
    # @return [Array|String]
    # @see #initialize
    def self.render(output)
      new(output).render
    end

    # Return a new instance of Vedeu::Output.
    #
    # @param output [Array<Array<Vedeu::Views::Char>>]
    # @return [Vedeu::Output]
    def initialize(output)
      @output = output
    end

    # Send the view to the renderers.
    #
    # @return [Array]
    def render
      #Vedeu.renderers.render(output) if Vedeu.ready?

      Vedeu::Terminal::Buffer.write(output).render
    end

    protected

    # @!attribute [r] output
    # @return [Array<Array<Vedeu::Views::Char>>]
    attr_reader :output

  end # Output

end # Vedeu
