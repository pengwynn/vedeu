module Vedeu

  class Fifo

    # Return an instance of Vedeu::Fifo.
    #
    # @param storage [Array<void>]
    # @return [Vedeu::Fifo]
    def initialize(storage = [])
      @storage = storage
    end

    # Return a boolean indicating whether the storage is not empty.
    #
    # @return [Boolean]
    def any?
      storage.any?
    end

    # Return a boolean indicating whether the storage is empty.
    #
    # @return [Boolean]
    def empty?
      storage.empty?
    end

    # Destroy all virtual buffers currently stored.
    #
    # @return [Array<void>]
    def reset
      @storage = in_memory
    end

    # Fetch the oldest stored virtual buffer first.
    #
    # @return [void|NilClass]
    def retrieve
      storage.pop
    end

    # Return the number of virtual buffers currently stored.
    #
    # @return [Fixnum]
    def size
      storage.size
    end

    # Store a new virtual buffer.
    #
    # @return [Array<void>]
    def store(data)
      storage.unshift(data)
    end

    protected

    # @!attribute [r] storage
    # @return [Array<void>]
    attr_reader :storage

    private

    # Returns an empty collection ready for the storing of virtual buffers.
    #
    # @return [Array<void>]
    def in_memory
      []
    end

  end # Fifo

end # Vedeu
