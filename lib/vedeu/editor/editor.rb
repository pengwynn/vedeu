module Vedeu

  module Editor

    # Handles keypresses for a named document whilst the terminal is in fake
    # mode.
    #
    class Editor

      include Vedeu::Common
      extend Forwardable

      def_delegators :document,
                     :clear,
                     :delete_character,
                     :down,
                     :insert_character,
                     :insert_line,
                     :left,
                     :render,
                     :reset!,
                     :execute,
                     :right,
                     :up

      # Send given input to the named document.
      #
      # @param name [String]
      # @param input [String|Symbol]
      # @return [String|Symbol]
      def self.keypress(input:, name:)
        new(input: input, name: name).keypress
      end

      # Returns a new instance of Vedeu::Editor::Editor.
      #
      # @param name [String]
      # @param input [String|Symbol]
      # @return [Vedeu::Editor::Editor]
      def initialize(input:, name:)
        @input = input
        @name  = name
      end

      # Send given input to the named document.
      #
      # @return [String|Symbol]
      def keypress
        return input unless document

        case input
        when :backspace then delete_character
        when :ctrl_c    then Vedeu.trigger(:_exit_)
        when :down      then down
        when :enter     then insert_line
        when :escape    then Vedeu.trigger(:_mode_switch_)
        when :left      then left
        when :right     then right
        when :tab       then execute
        when :up        then up
        # when ''         then delete_line
        else
          insert_character(input)
        end
      end

      protected

      # @!attribute [r] input
      # @return [Symbol|String]
      attr_reader :input

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

      private

      # Return the document by name from the documents repository.
      #
      # @return [Vedeu::Editor::Document]
      def document
        @document ||= Vedeu.documents.by_name(name)
      end

    end # Editor

  end # Editor

end # Vedeu
