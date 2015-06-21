require_relative 'store'
require_relative 'registerable'
require_relative 'repository'

module Vedeu

  # Allows the storing of continuous commands.
  class ContinuousRepository < Repository

    class << self

      # @return [Vedeu::ContinuousRepository]
      alias_method :continuous, :repository

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::ContinuousRepository]
      def reset!
        @continous = new(Vedeu::Continuous)
      end

    end

  end # ContinuousRepository

end # Vedeu
