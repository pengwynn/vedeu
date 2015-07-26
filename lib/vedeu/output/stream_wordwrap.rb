module Vedeu

  class StreamWordwrap

    # @param content [Vedeu::Lines<Vedeu::Streams<Vedeu::Stream>>]
    def initialize(content)
      @content = content
    end

    def process
    end

    protected

    # @!attribute [r] content
    # @return [void]
    attr_reader :content

    private

    def lines
      return content if content.is_a?(Vedeu::Lines)
    end

  end # StreamWordwrap

end # Vedeu
