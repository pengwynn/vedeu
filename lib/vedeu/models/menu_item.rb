module Vedeu

  class MenuItem

    # @!attribute [r] child
    # @return [void]
    attr_reader :child

    # @!attribute [r] parent
    # @return [void]
    attr_reader :parent

    # @param attributes [Hash<Symbol => void>]
    # @option attributes parent [Vedeu::Menu]
    # @option attributes child [Vedeu::Menu]
    # @option attributes value []
    # @option attributes label [String]
    # @option attributes selected [Boolean]
    # @option attributes current [Boolean]
    # @return [Vedeu::MenuItem]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @parent   = @attributes[:parent]
      @child    = @attributes[:child]
      @value    = @attributes[:value]
      @label    = @attributes[:label]
      @selected = @attributes[:selected]
      @current  = @attributes[:current]
    end

    def select!
      if parent?

      elsif child?

      else

      end
    end

    private

    # @return [Boolean]
    def child?
      return true if child

      false
    end

    # @return [Boolean]
    def parent?
      return true if parent

      false
    end

    # @return [Hash<Symbol => NilClass>]
    def defaults
      {
        parent:   nil,
        child:    nil,
        value:    nil,
        label:    nil,
        selected: nil,
        current:  nil,
      }
    end

  end # MenuItem

end # Vedeu
