module Vedeu

  module Templating

    # Provide helpers to be used with your Vedeu templates.
    #
    module Helpers

      # @param options [Hash<Symbol => void>]
      # @param block [Proc]
      # @raise [Vedeu::InvalidSyntax] The required block was not given.
      # @return [void]
      def align(options = {}, &block)
        fail Vedeu::InvalidSyntax, 'block not given' unless block_given?

        options.merge!(anchor: __callee__)

        encode(Vedeu::Text.add(block.call, options))
      end
      alias_method :left, :align
      alias_method :right, :align
      alias_method :centre, :align
      alias_method :center, :align

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
