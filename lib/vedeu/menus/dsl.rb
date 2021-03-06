module Vedeu

  module Menus

    # Provides the mechanism to create menus within client
    # applications and use events to drive them.
    #
    class DSL

      include Vedeu::DSL

      # Return a new instance of Vedeu::Menus::DSL.
      #
      # @param model [Vedeu::Menus::Menu]
      # @param client [Object]
      # @return [Vedeu::Menus::DSL]
      def initialize(model, client = nil)
        @model  = model
        @client = client
      end

      # Add an individual item to the menu.
      #
      # @param element [Object] An object you wish to add to the
      #   collection.
      #
      #   Vedeu.menu 'my_menu' do
      #     item SomeClass.new
      #     item SomeClass.new
      #   end
      #
      # @return [Array]
      def item(element)
        model.collection << element
      end
      alias_method :item=, :item

      # Define the items for the menu. Most powerful when used with
      # one of your model classes.
      #
      # In the 'my_playlist' example below, your `Track` model may
      # return a collection of tracks to populate the menu.
      #
      #   Vedeu.menu 'my_menu' do
      #     items [:item_1, :item_2, :item_3]
      #   end
      #
      #   Vedeu.menu 'my_playlist' do
      #     items Track.all_my_favourites
      #   end
      #
      # @param collection [Array<Object>] A collection of objects
      #   which make up the menu items.
      # @return [Array]
      def items(collection = [])
        model.collection = collection
      end
      alias_method :items=, :items

      # The name of the menu. Used to reference the menu throughout
      # your application's execution lifetime.
      #
      #   Vedeu.menu do
      #     name 'my_menu'
      #     # ...
      #   end
      #
      # @param value [String]
      # @return [String]
      def name(value)
        model.name = value
      end
      alias_method :name=, :name

    end # DSL

  end # Menus

end # Vedeu
