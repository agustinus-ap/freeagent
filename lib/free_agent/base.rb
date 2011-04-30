module FreeAgent

  # The Base class for any FreeAgent resource.
  #
  # == Dynamic Finders
  #
  # Like ActiveRecord, this class support dynamic finders.
  # You can use dynamic finders to search a resource by any of its attributes.
  #
  #   class Contact < Base
  #   end
  #
  #   Contact.find_by_email 'email@example.org'
  #   Contact.find_by_username_and_email 'weppos', 'email@example.org'
  #
  # However, there's one important caveat we should mention.
  # This feature is not very efficient and the more records you have,
  # the longer the query it takes.
  #
  # This is because record filtering is performed client-side.
  # The library first loads and instantiate all records, then it filters them
  # applying given criteria.
  #
  class Base < ActiveResource::Base

    # = Active Record Dynamic Finder Match
    #
    # Refer to ActiveRecord::Base documentation for Dynamic attribute-based finders for detailed info.
    #
    class DynamicFinderMatch
      def self.match(method)
        finder       = :first
        bang         = false
        instantiator = nil

        case method.to_s
        when /^find_(all_|last_)?by_([_a-zA-Z]\w*)$/
          finder = :last if $1 == 'last_'
          finder = :all if $1 == 'all_'
          names = $2
        when /^find_by_([_a-zA-Z]\w*)\!$/
          bang = true
          names = $1
        when /^find_or_(initialize|create)_by_([_a-zA-Z]\w*)$/
          instantiator = $1 == 'initialize' ? :new : :create
          names = $2
        else
          return nil
        end

        new(finder, instantiator, bang, names.split('_and_'))
      end

      def initialize(finder, instantiator, bang, attribute_names)
        @finder          = finder
        @instantiator    = instantiator
        @bang            = bang
        @attribute_names = attribute_names
      end

      attr_reader :finder, :attribute_names, :instantiator

      def finder?
        @finder && !@instantiator
      end

      def instantiator?
        @finder == :first && @instantiator
      end

      def creator?
        @finder == :first && @instantiator == :create
      end

      def bang?
        @bang
      end
    end


    class << self

      protected

        def method_missing(method_id, *arguments, &block)
          if match = DynamicFinderMatch.match(method_id)
            attribute_names = match.attribute_names
            if match.finder?
              find_by_attributes(match, attribute_names, *arguments)
            elsif match.instantiator?
              find_or_instantiator_by_attributes(match, attribute_names, *arguments, &block)
            end
          else
            super
          end
        end

        def find_by_attributes(match, attributes, *args)
          conditions = Hash[attributes.map {|a| [a, args[attributes.index(a)]]}]
          result = all.select do |record|
            conditions.all? { |k,v| record.send(k) == v }
          end
          result = result.send(match.finder) if match.finder != :all

          if match.bang? && result.blank?
            raise ActiveResource::ResourceNotFound, 404, "Couldn't find #{self} with #{conditions.to_a.collect {|p| p.join(' = ')}.join(', ')}"
          else
            result
          end
        end

        def find_or_instantiator_by_attributes(match, attributes, *args)
          record = find_by_attributes(match, attributes, *args)

          unless record
            conditions = Hash[attributes.map {|a| [a, args[attributes.index(a)]]}]
            record = new(conditions)
            yield(record) if block_given?
            record.save if match.instantiator == :create
          end

          record
        end

    end


    def respond_to?(method_id, include_private = false)
      if DynamicFinderMatch.match(method_id)
        return true
      end

      super
    end

  end

end
