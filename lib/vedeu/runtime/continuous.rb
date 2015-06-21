module Vedeu

  class Continuous

    include Vedeu::Model

    # collection Vedeu::Continuous
    # member     Vedeu::Interface

    # @!attribute [r] output
    # @return [void]
    attr_reader :output

    # @param name [String]
    # @return [Vedeu::Continuous]
    def initialize(name)
      @name   = name
      @output = ''
    end

    protected

    # @!attribute [r] name
    # @return [void]
    attr_reader :name

    private

    # @return [Mutex]
    def mutex
      @mutex ||= Mutex.new
    end

  end # Continuous

end # Vedeu
