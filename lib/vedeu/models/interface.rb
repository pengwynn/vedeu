module Vedeu

  # An Interface represents a portion of the terminal defined by
  # {Vedeu::Geometry::Geometry}.
  #
  class Interface

    include Vedeu::Model
    include Vedeu::Presentation
    include Vedeu::Toggleable

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # @!attribute [rw] client
    # @return [Fixnum|Float]
    attr_accessor :client

    # @!attribute [rw] delay
    # @return [Fixnum|Float]
    attr_accessor :delay

    # @!attribute [rw] group
    # @return [Symbol|String]
    attr_accessor :group

    # @!attribute [rw] name
    # @return [String]
    attr_accessor :name

    # @!attribute [rw] parent
    # @return [Vedeu::Views::Composition]
    attr_accessor :parent

    # @!attribute [rw] zindex
    # @return [Fixnum]
    attr_accessor :zindex

    # Return a new instance of Vedeu::Interface.
    #
    # @param attributes [Hash]
    # @option attributes client [Vedeu::Client]
    # @option attributes colour [Vedeu::Colours::Colour]
    # @option attributes delay [Float]
    # @option attributes group [String]
    # @option attributes name [String]
    # @option attributes parent [Vedeu::Views::Composition]
    # @option attributes repository [Vedeu::Interfaces]
    # @option attributes style [Vedeu::Style]
    # @option attributes visible [Boolean]
    # @option attributes zindex [Fixnum]
    # @return [Vedeu::Interface]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @attributes.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # Hide a named interface buffer, or without a name, the buffer of the
    # currently focussed interface.
    #
    # @example
    #   Vedeu.hide_interface(name)
    #
    # @return [void]
    def hide
      super

      Vedeu.buffers.by_name(name).hide
    end

    # Show the named interface buffer, or without a name, the buffer of the
    # currently focussed interface.
    #
    # @example
    #   Vedeu.show_interface(name)
    #
    # @return [void]
    def show
      super

      Vedeu.buffers.by_name(name).show
    end

    # Toggle the visibility of the interface with the given name.
    #
    # @example
    #   Vedeu.toggle_interface(name)
    #
    # @return [void]
    def toggle
      if visible?
        hide

      else
        show

      end
    end

    private

    # The default values for a new instance of this class.
    #
    # @return [Hash<Symbol => Array, Boolean, Class, Float, NilClass, String]
    def defaults
      {
        client:     nil,
        colour:     Vedeu::Colours::Colour.coerce(background: :default,
                                                  foreground: :default),
        delay:      0.0,
        group:      '',
        name:       '',
        parent:     nil,
        repository: Vedeu.interfaces,
        style:      :normal,
        visible:    true,
        zindex:     0,
      }
    end

  end # Interface

end # Vedeu
