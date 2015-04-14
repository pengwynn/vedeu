module Vedeu

  class MenuItem

    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @parent   = @attributes[:parent]
      @child    = @attributes[:child]
      @value    = @attributes[:value]
      @label    = @attributes[:label]
      @selected = @attributes[:selected]
      @current  = @attributes[:current]
    end

    private

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
