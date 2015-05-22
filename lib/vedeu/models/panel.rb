module Vedeu

  # Abstract interface class without the baggage.
  #
  # @api private
  class Panel

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # @!attribute [rw] name
    # @return [String]
    attr_accessor :name

    # @!attribute [rw] parent
    # @return [Vedeu::Panel]
    attr_accessor :parent

    # Return a new instance of Vedeu::Panel.
    #
    # @param attributes [Hash]
    # @option attributes name [String]
    # @option attributes parent [Vedeu::Panel]
    # @return [Vedeu::Panel]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @name   = @attributes[:name]
      @parent = @attributes[:parent]

    end

    private

    # @return [Vedeu::Area]
    def area
      @area = Vedeu::Area.from_dimensions(y_yn: y_yn, x_xn: x_xn)
    end

    # The default values for a new instance of this class.
    #
    # @return [Hash<Symbol => NilClass, String]
    def defaults
      {
        name:   '',
        parent: nil,
      }
    end

  end # Panel

end # Vedeu
