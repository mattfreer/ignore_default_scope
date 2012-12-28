require "ignore_default_scope/relation.rb"

module IgnoreDefaultScope
  module Base
    extend ActiveSupport::Concern

    attr_reader :relation

    included do
      send(:after_initialize, :on_after_init)
    end

    #ActiveSupport::Concern automatically mixes-in ClassMethods
    module ClassMethods
      attr_reader :association_name

      def ignore_default_scope(association_name)
        @association_name = association_name
      end
    end

    def on_after_init
      create_relation
      apply_aliasing
      self.class.after_save :on_after_save
    end

    def on_after_save
      #If the association has changed we need to update the aliasing in case
      #the association type has changed (e.g. polymorhic association)
      create_relation
      if relation.name.present? && relation.id_changed?
        apply_aliasing
      end
    end

    def apply_aliasing
      if relation.name.present? && relation.id.present?
        singleton = class << self; self end

        # Each instance will have it's own *_with_unscoped method definition
        singleton.send(:define_method, unscoped_alias_name) do
          relation.klass.unscoped.find(relation.id)
        end

        singleton.send(:alias_method, relation.name, unscoped_alias_name)
      end
    end

    private
    def create_relation
      @relation = IgnoreDefaultScope::Relation.new(
        :host => self,
        :name => self.class.association_name
      )
    end

    def unscoped_alias_name
      (relation.name.to_s + "_with_unscoped").to_sym
    end
  end
end
ActiveRecord::Base.send :include, IgnoreDefaultScope::Base
