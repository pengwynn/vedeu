require 'vedeu/application/helper'

module Vedeu

  # Provides methods which should be available to all client application
  # helpers. The client application's ApplicationHelper will include this
  # module.
  #
  # @api private
  module ApplicationHelper

    include Vedeu::Helper

  end # ApplicationHelper

end # Vedeu
