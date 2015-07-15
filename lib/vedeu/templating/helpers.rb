module Vedeu

  module Templating

    # Provide helpers to be used with your Vedeu templates.
    #
    module Helpers

      # @param value [String] The HTML/CSS colour.
      # @param block [Proc]
      # @return [Vedeu::Views::Stream]
      # @raise [Vedeu::Error::InvalidSyntax] The required block was not given.
      def background(value, &block)
        define_stream(background: value, &block)
      end
      alias_method :bg, :background

      # @param attributes [Hash]
      # @option attributes foreground [String] The HTML/CSS foreground colour.
      # @option attributes background [String] The HTML/CSS background colour.
      # @param block [Proc]
      # @return [Vedeu::Views::Stream]
      # @raise [Vedeu::Error::InvalidSyntax] The required block was not given.
      def colour(attributes = {}, &block)
        define_stream(attributes, &block)
      end

      # @param value [String] The HTML/CSS colour.
      # @param block [Proc]
      # @return [Vedeu::Views::Stream]
      # @raise [Vedeu::Error::InvalidSyntax] The required block was not given.
      def foreground(value, &block)
        define_stream(foreground: value, &block)
      end
      alias_method :fg, :foreground

      # @param value [Symbol]
      # @param block [Proc]
      # @return [Vedeu::Views::Stream]
      def style(value, &block)
        define_stream(style: value, &block)
      end

      # Adds the number of lines or characters provided for each dimension as
      # padding to the content defined in the given block.
      #
      # @example
      #   {{ padding(1, 2, 1, 2) { 'padded!' } }}
      #
      # @param top [Fixnum] Add lines of padding to the top.
      # @param right [Fixnum] Add characters of padding to the right.
      # @param bottom [Fixnum] Add lines of padding to the bottom.
      # @param left [Fixnum] Add characters of padding to the left.
      # @return [Array<void>]
      # @raise [InvalidSyntax] The required block was not given.
      def padding(top = 0, right = 0, bottom = 0, left = 0, &block)
        out = []

        top.times do |top_lines|
          out << Vedeu::Line.build(value: ' ')
        end

        out << define_stream(value: (left * ' ')) if left > 0

        out << define_stream({}, &block)

        out << define_stream(value: (right * ' ')) if right > 0

        bottom.times do |bottom_lines|
          out << Vedeu::Line.build(value: ' ')
        end

        out
      end

      private

      # @see Vedeu::Templating::Helpers#colours
      def define_colour(attributes = {})
        attributes.delete_if do |k, v|
          [:background, :foreground].include?(k) == false || v.nil? || v.empty?
        end

        Vedeu::Colour.new(attributes)
      end

      private

      # @see Vedeu::Templating::Helpers#colour
      def define_stream(attributes = {}, &block)
        fail Vedeu::Error::InvalidSyntax, 'block not given' unless block_given?

        encode(
          Vedeu::Views::Stream.build(
            colour: Vedeu::Colours::Colour.new(attributes),
            style:  Vedeu::Style.new(attributes[:style]),
            value:  block.call))
      end

      # @param data [String]
      # @return [String]
      def encode(data)
        Vedeu::Templating::Encoder.process(data)
      end

    end # Helpers

  end # Templating

end # Vedeu
