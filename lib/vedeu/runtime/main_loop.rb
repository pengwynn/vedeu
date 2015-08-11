module Vedeu

  # Provides the main loop for a Vedeu application.
  #
  class MainLoop

    trap('TERM') { Vedeu::MainLoop.stop! }
    trap('INT')  { Vedeu::MainLoop.stop! }
    trap('TSTP') { Vedeu::MainLoop.pause! }  # Terminal Stop
    trap('CONT') { Vedeu::MainLoop.resume! } # Continue executing, if stopped.

    class << self

      # :nocov:
      # Start the main loop.
      #
      # @return [void]
      # @yieldreturn [void] The client application.
      def start!
        @paused  = false
        @started = true
        @loop    = true

        while @loop
          yield

          safe_exit_point!
        end
      rescue Vedeu::Error::Interrupt
        Vedeu.log(type:    :info,
                  message: 'Vedeu execution interrupted, exiting.')
      end
      # :nocov:

      # Signal that we wish to terminate the running application.
      #
      # @return [void]
      def stop!
        @loop = false
      end

      # Signal that we wish to pause the running application.
      #
      # @return [void]
      def pause!
        @paused = true
      end

      # Signal that we wish to resume the running application.
      #
      # @return [void]
      def resume!
        @paused = false
      end

      # Returns a boolean indicating whether the running application is paused.
      #
      # @return [Boolean]
      def paused?
        @paused
      end

      # :nocov:
      # Check the application has started and we wish to continue running.
      #
      # @raise [Vedeu::Error::Interrupt] When we wish to terminate the running
      #   application.
      # @return [void]
      def safe_exit_point!
        fail Vedeu::Error::Interrupt if @started && !@loop
      end
      # :nocov:

    end # Eigenclass

  end # MainLoop

end # Vedeu
