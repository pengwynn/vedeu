module Vedeu

  module Models

    # A Page represents an array of Vedeu::Models::Row objects.
    #
    class Page

      include Enumerable

      # @!attribute [r] rows
      # @return [Array<NilClass|Vedeu::Models::Row>]
      attr_reader :rows

      # @param value
      #   [Vedeu::Models::Page|Vedeu::Models::Row|Array<void>|void]
      # @return [Vedeu::Models::Page]
      def self.coerce(value)
        if value.is_a?(Vedeu::Models::Page)
          value

        elsif value.is_a?(Vedeu::Models::Row)
          Vedeu::Models::Page.new([value])

        elsif value.is_a?(Array) && value.empty?
          Vedeu::Models::Page.new([Vedeu::Models::Row.coerce(value)])

        elsif value.is_a?(Array)
          values = value.map do |v|
            if v.is_a?(Vedeu::Models::Row)
              v

            else
              Vedeu::Models::Row.coerce(v)

            end
          end
          Vedeu::Models::Page.new(values)

        else
          fail Vedeu::Error::InvalidSyntax,
               'Cannot coerce as value is not an Array.'

        end
      end

      # Returns an instance of Vedeu::Models::Page.
      #
      # @param rows [Array<NilClass|Vedeu::Models::Row>]
      # @return [Vedeu::Models::Page]
      def initialize(rows = [])
        @rows = rows || []
      end

      # Provides iteration over the collection.
      #
      # @param block [Proc]
      # @return [Enumerator]
      def each(&block)
        rows.each(&block)
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Models::Page]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && rows == other.rows
      end
      alias_method :==, :eql?

      # @param index [Fixnum]
      # @return [NilClass|Vedeu::Models::Row]
      def row(index = nil)
        return nil if index.nil?

        rows[index]
      end

      # @param row_index [Fixnum]
      # @param cell_index [Fixnum]
      # @return [NilClass|void]
      def cell(row_index = nil, cell_index = nil)
        return nil if row_index.nil? || cell_index.nil?
        return nil unless row(row_index)

        row(row_index)[cell_index]
      end

    end # Page

  end # Models

end # Vedeu
