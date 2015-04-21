module Vedeu

  # Provides the main loop for a Vedeu application.
  #
  # Each time Vedeu starts one cycle in the application loop, it triggers the
  # `:tick` event. A completion of that cycle will trigger `:tock`. This can be
  # used by the client application for timing amongst other things.
  class MainLoop

    trap('SIGTERM') { stop! }
    trap('TERM')    { stop! }
    trap('INT')     { stop! }

    # :nocov:
    # Start the main loop.
    #
    # @return [void]
    # @yieldreturn [void] The client application.
    def self.start!
      @started = true
      @loop    = true

      while @loop
        yield

        safe_exit_point!
      end
    rescue VedeuInterrupt
      Vedeu.log(type: :debug, message: 'Vedeu execution interrupted, exiting.')
    end
    # :nocov:

    # Signal that we wish to terminate the running application.
    #
    # @return [void]
    def self.stop!
      @loop = false
    end

    # Check the application has started and we wish to continue running.
    #
    # @raise [VedeuInterrupt] When we wish to terminate the running application.
    # @return [void]
    def self.safe_exit_point!
      if @started && !@loop
        fail VedeuInterrupt

      else
        Vedeu.trigger(:tock, Time.now.to_f)

      end
    end

  end # MainLoop

end # Vedeu
