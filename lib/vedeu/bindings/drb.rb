module Vedeu

  module Bindings

    # System events relating to the DRb server implementation.
    #
    # :nocov:
    module DRB

      extend self

      # Setup events relating to the DRb server. This method is called
      # by Vedeu.
      #
      # @return [TrueClass]
      def setup!
        drb_input!
        drb_retrieve_output!
        drb_store_output!
        drb_restart!
        drb_start!
        drb_status!
        drb_stop!
      end

      private

      # Triggering this event will send input to the running
      # application as long as it has the DRb server running.
      #
      # @example
      #   Vedeu.trigger(:_drb_input_, data, type)
      #
      # @return [TrueClass]
      # @see Vedeu::Distributed::Server#input
      def drb_input!
        Vedeu.bind(:_drb_input_) do |data, type|
          Vedeu.log(type: :drb, message: "Sending input (#{type})")

          case type
          when :command  then Vedeu.trigger(:_command_, data)
          when :keypress then Vedeu.trigger(:_keypress_, data)
          else Vedeu.trigger(:_keypress_, data)
          end
        end
      end

      # @example
      #   Vedeu.trigger(:_drb_retrieve_output_)
      #
      # @todo This event queries Vedeu. Events should only be
      #   commands.
      #
      # @return [TrueClass]
      def drb_retrieve_output!
        Vedeu.bind(:_drb_retrieve_output_) { Vedeu::VirtualBuffers.retrieve }
      end

      # Triggering this event with 'data' will push data into the
      # running application's virtual buffer.
      #
      # @example
      #   Vedeu.trigger(:_drb_store_output_, data)
      #
      # @return [TrueClass]
      def drb_store_output!
        Vedeu.bind(:_drb_store_output_) do |data|
          Vedeu::VirtualBuffers.store(Vedeu::VirtualBuffer.output(data))
        end
      end

      # Use the DRb server to request the client application to
      # restart.
      #
      # @example
      #   Vedeu.trigger(:_drb_restart_)
      #   Vedeu.drb_restart
      #
      # @return [TrueClass]
      def drb_restart!
        Vedeu.bind(:_drb_restart_) { Vedeu::Distributed::Server.restart }
      end

      # Use the DRb server to request the client application to start.
      #
      # @example
      #   Vedeu.trigger(:_drb_start_)
      #   Vedeu.drb_start
      #
      # @return [TrueClass]
      def drb_start!
        Vedeu.bind(:_drb_start_) { Vedeu::Distributed::Server.start }
      end

      # Use the DRb server to request the status of the client
      # application.
      #
      # @example
      #   Vedeu.trigger(:_drb_status_)
      #   Vedeu.drb_status
      #
      # @return [TrueClass]
      def drb_status!
        Vedeu.bind(:_drb_status_) { Vedeu::Distributed::Server.status }
      end

      # Use the DRb server to request the client application to stop.
      #
      # @example
      #   Vedeu.trigger(:_drb_stop_)
      #   Vedeu.drb_stop
      #
      # @return [TrueClass]
      def drb_stop!
        Vedeu.bind(:_drb_stop_) { Vedeu::Distributed::Server.stop }
      end

    end # DRB
    # :nocov:

  end # Bindings

end # Vedeu
