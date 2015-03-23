module Vedeu

  # Present a string (or object responding to `to_s`).
  #
  class Text

    # @see Vedeu::DSL::Text#text
    def self.with(value = '', options = {})
      new(value, options).aligned
    end

    # Returns a new instance of Vedeu::Text.
    #
    # @param value [String]
    # @param options [Hash]
    # @option options width [Integer]
    # @option options anchor [Symbol] See {Text#anchor}
    # @option options pad [String]
    # @return [Text]
    def initialize(value = '', options = {})
      @value   = value
      @options = defaults.merge!(options)
    end

    # Aligns the value.
    #
    # @return [String]
    def aligned
      return string unless width

      return truncated if truncate?

      case anchor
      when :align, :left, :text then left
      when :centre, :center     then centre
      when :right               then right
      else
        left
      end
    end

    private

    # @!attribute [r] value
    # @return [String]
    attr_reader :value

    # @!attribute [r] options
    # @return [Hash]
    attr_reader :options

    # @return [Symbol] One of :align, :centre, :center, :left, :right, :text
    def anchor
      options[:anchor]
    end

    # The string padded to width, centralized.
    #
    # @return [String]
    def centre
      string.center(width, pad)
    end

    # The default values for a new instance of this class.
    #
    # @return [Hash<Symbol => NilClass, String, Symbol>]
    def defaults
      {
        anchor: :left,
        pad:    ' ',
        width:  nil,
      }
    end

    # The string padded to width, left justified.
    #
    # @return [String]
    def left
      string.ljust(width, pad)
    end

    # The character to use for padding the string.
    #
    # @return [String]
    def pad
      options[:pad]
    end

    # The string padded to width, right justified.
    #
    # @return [String]
    def right
      string.rjust(width, pad)
    end

    # The string, coerced.
    #
    # @return [String]
    def string
      value.to_s
    end

    # Return a boolean indicating that the string is greater than the width.
    #
    # @return [Boolean]
    def truncate?
      string.size > width
    end

    # Return the string truncated to the width.
    #
    # @return [String]
    def truncated
      string.slice(0, width)
    end

    # Return the width.
    #
    # @return [Fixnum]
    def width
      options[:width]
    end

  end # Align

end # Vedeu
