module Vedeu

  module Associations

    include Vedeu::Common

    module ClassMethods

      include Vedeu::Common

      # @param target []
      # @return []
      def has_many(target)
        define_collection_getter!(target)
        define_reflection_name!

        define_method("#{target}=") do |members|
          # nil to empty
          members ||= []

          # set the instance variable only if I am now the rightful owner
          instance_variable_set("@#{target}", members)

          members.each do |member|
            current = member.send(reflection_name)

            # no current assignment
            if current.nil?
              member.send("#{reflection_name}=", self)

            # current assignment is not me
            elsif current != self
              others = current.send(target)

              if others.include?(member)
                # take the element from the other member
                current.send("#{target}=", others - [member])

              else
                fail "Unmatching association; Current owner " \
                     "(#{current.class.name}) of #{member.class.name} " \
                     "does not have it as a member"

              end
              # add me as associated to the member I am also including
              member.send("#{reflection_name}=", self)

            # its already me, do not do anything
            else

            end
          end
        end

        define_associator!(target)

        define_disassociator!(target)
      end

      # @param target []
      # @return []
      def has_one(target)
        define_getter!(target)
        define_reflection_name!

        define_method("#{target}=") do |member|
          if member.respond_to?(reflection_name) &&
              member.send(reflection_name) != self
            member.send("#{reflection_name}=", self)
          end

          instance_variable_set("@#{target}", member)
        end
      end

      # @param target []
      # @return []
      def belongs_to(target)
        define_getter!(target)
        define_reflection_name!

        # define setter method
        define_method("#{target}=") do |member|
          previous = instance_variable_get("@#{target}")
          instance_variable_set("@#{target}", member)

          reflection_names = pluralize(reflection_name)

          # add myself to reflected association
          if member.respond_to?(reflection_name) &&
              member.send(reflection_name) != self
            member.send("#{reflection_name}=", self)

          elsif member.respond_to?(reflection_names)
            reflected_members = member.send(reflection_names)

            unless reflected_members.include?(self)
              member.send("#{reflection_names}=", reflected_members + [self])
            end

          else
            fail "Association definition missing: no " \
                 "#{reflection_name} or #{reflection_names} " \
                 "association defined in #{member.class}"
          end

          # remove myself from old reflected association
          if previous.respond_to?(reflection_name)
            if previous.send(reflection_name) == self
              previous.send("#{reflection_name}=", nil)
            end

          elsif previous.respond_to?(reflection_names)
            previous_reflected = previous.send(reflection_names)

            if previous_reflected.include?(self)
              previous.send("#{reflection_names}=", previous_reflected - [self])
            end

          # there wasn't any previous member
          elsif previous.nil?

          # there was a previous member
          else
            fail "Ghost association definition: no " \
                 "#{reflection_name} or #{reflection_names} " \
                 "association defined in #{member.class}"
          end
        end
      end

      # @param target []
      # @return []
      def define_getter!(target)
        define_method(target) do
          instance_variable_get("@#{target}")
        end
      end

      # @param target []
      # @return []
      def define_collection_getter!(target)
        define_method(target) do
          instance_variable_get("@#{target}") || []
        end
      end

      def define_associator!(target)
        define_method("add_#{singularize(target)}") do |member|
          send("#{target}=", (send(target) + [member]).uniq)
        end
      end

      def define_disassociator!(target)
        define_method("remove_#{singularize(target)}") do |member|
          send("#{target}=", (send(target) - [member]).uniq)
        end
      end

      def define_reflection_name!
        define_method("reflection_name") do
          instance_variable_set("@reflection_name", underscore(self.class.name))
        end
      end

    end # ClassMethods

    # When this module is included in a class, provide ClassMethods as class
    # methods for the class.
    #
    # @param klass [Class]
    # @return [void]
    def self.included(klass)
      klass.send(:extend, ClassMethods)
    end

  end # Associations

end # Vedeu
