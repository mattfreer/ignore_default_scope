require "ignore_default_scope/relation.rb"

module IgnoreDefaultScope
  module Base
    extend ActiveSupport::Concern

    attr_reader :relation

    included do
      send(:after_initialize, :on_after_init)
    end

    module ClassMethods
      attr_reader :association_name

      def ignore_default_scope(association_name)
        @association_name = association_name
      end
    end

    def on_after_init
      self.class.after_save :on_after_save
      setup_ignore if ignoring?
    end

    def on_after_save
      if relation_changed?
        #Update the aliasing in case the association type has changed (e.g. polymorhic association)
        setup_ignore
      end
    end

    def apply_ignore_aliasing
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

    def ignoring?
      self.class.association_name.present?
    end

    def setup_ignore
      create_ignore_relation
      apply_ignore_aliasing
    end

    def create_ignore_relation
      @relation = IgnoreDefaultScope::Relation.new(
        :host => self,
        :name => self.class.association_name
      )
    end

    def unscoped_alias_name
      (relation.name.to_s + "_with_unscoped").to_sym
    end

    def relation_changed?
      relation.present? && relation.id_changed?
    end
  end
end
