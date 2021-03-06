module Vedeu

  # Provides common methods for accessing the various repositories Vedeu uses.
  #
  # @example
  #   { 'models' => [Model, Model, Model] }
  #
  #   { 'models' => [Model] }
  #
  class Repository

    include Vedeu::Common
    include Vedeu::Registerable
    include Vedeu::Store

    # @!attribute [r] model
    # @return [void]
    attr_reader :model

    # @!attribute [r] storage
    # @return [void]
    attr_reader :storage

    # Returns a new instance of Vedeu::Repository.
    #
    # @param model [Class]
    # @param storage [Class|Hash]
    # @return [Vedeu::Repository]
    def initialize(model = nil, storage = {})
      @model      = model
      @storage    = storage
    end

    # Returns the repository class.
    #
    # @return [Class]
    def repository
      self.class
    end

    # Return all the registered models.
    #
    # @return [Array<void>] An array containing each stored model.
    def all
      return storage.values if storage.is_a?(Hash)

      registered
    end

    # Return the named model or a null object if not registered.
    #
    # @example
    #   Vedeu.cursors.by_name('some_name') # => Fetch the cursor belonging to
    #                                           the interface of the same name.
    #
    #   Vedeu.groups.by_name(name) # => Fetch the names of the interfaces
    #                                   belonging to this group.
    #
    # @param name [String] The name of the stored model.
    # @return [void]
    def by_name(name)
      name ||= Vedeu.focus

      if registered?(name)
        find(name)

      else
        null_model.new(name: name)

      end
    end

    # Return the model for the interface currently in focus.
    #
    # @return [String|NilClass]
    def current
      find_or_create(Vedeu.focus) if Vedeu.focus
    end

    # Find the model by name.
    #
    # @param name [String]
    # @return [Hash<String => Object>|NilClass]
    def find(name)
      storage[name]
    end

    # Find the model attributes by name, raises an exception when the model
    # cannot be found.
    #
    # @param name [String]
    # @raise [Vedeu::Error::ModelNotFound] When the model cannot be found with
    #   this name.
    # @return [Hash<String => Object>]
    def find!(name)
      find(name) || fail(Vedeu::Error::ModelNotFound,
                         "Cannot find model by name: '#{name}'")
    end

    # Find a model by name, registers the model by name when not found.
    #
    # @param name [String]
    # @return [void]
    def find_or_create(name)
      if registered?(name)
        find(name)

      else
        Vedeu.log(type: :store,
                  message: "Model (#{model}) not found, registering: '#{name}'")

        model.new(name).store
      end
    end

    # @return [String]
    def inspect
      "<#{self.class.name}>"
    end

    # Returns a boolean indicating whether the named model is registered.
    #
    # @param name [String]
    # @return [Boolean]
    def registered?(name)
      return false if name.nil? || name.empty?
      return false if empty?

      storage.include?(name)
    end

    # Returns the storage with the named model removed, or false when the model
    # does not exist.
    #
    # @param name [String]
    # @return [Hash|FalseClass]
    def remove(name)
      return false if empty?

      if registered?(name)
        storage.delete(name)
        storage unless storage.is_a?(Set)

      else
        false

      end
    end
    alias_method :destroy,    :remove
    alias_method :delete,     :remove
    alias_method :deregister, :remove

    # Stores the model instance by name in the repository of the model.
    #
    # @param model [void] A model instance.
    # @raise [Vedeu::Error::MissingRequired] When the name attribute is not
    #   defined.
    # @return [void] The model instance which was stored.
    def store(model)
      unless present?(model.name)
        fail Vedeu::Error::MissingRequired,
             "Cannot store model '#{model.class}' without a name attribute."
      end

      log_store(model)

      storage[model.name] = model
    end
    alias_method :register, :store
    alias_method :add, :store

    private

    # @return [String]
    def log_store(model)
      type = registered?(model.name) ? :update : :create

      Vedeu.log(type: type, message: "#{model.class.name}: '#{model.name}'")
    end

  end # Repository

end # Vedeu
