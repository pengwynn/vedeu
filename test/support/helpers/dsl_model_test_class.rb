require 'vedeu/dsl/shared/all'

module Vedeu

  module DSL

    class ModelTestClass

      include Vedeu::DSL::Colour
      include Vedeu::DSL::Style

      def initialize(model)
        @model = model
      end

      private

      attr_reader :model

    end # ModelTestClass

  end # DSL

end # Vedeu
