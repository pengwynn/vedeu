module Vedeu

  module Models

    # A Row represents an array of Vedeu::Models::Cell objects.
    #
    class Row

      include Enumerable

      # @!attribute [r] cells
      # @return [Array<NilClass|void>]
      attr_reader :cells

      # @param value [Vedeu::Models::Row|Array<void>|void]
      # @return [Vedeu::Models::Row]
      def self.coerce(value)
        if value.is_a?(self)
          value

        elsif value.is_a?(Array)
          new(value.compact)

        elsif value.nil?
          new

        else
          new([value])

        end
      end

      # Returns an instance of Vedeu::Models::Row.
      #
      # @param cells [Array<NilClass|void>]
      # @return [Vedeu::Models::Row]
      def initialize(cells = [])
        @cells = cells || []
      end

      # Provides iteration over the collection.
      #
      # @param block [Proc]
      # @return [Enumerator]
      def each(&block)
        cells.each(&block)
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Models::Row]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && cells == other.cells
      end
      alias_method :==, :eql?

      # @param index [Fixnum]
      # @return [NilClass|void]
      def cell(index)
        return nil if index.nil?

        cells[index]
      end

    end # Row

  end # Models

end # Vedeu
