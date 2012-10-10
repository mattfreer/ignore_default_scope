module IgnoreDefaultScope
  module ActsAsOblivious
    extend ActiveSupport::Concern

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
      apply_aliasing
      self.class.after_save :on_after_save
    end

    def on_after_save
      #If the association has changed we need to update the aliasing in case
      #the association type has changed (e.g. polymorhic association)
      if relation_name.present? && relation_method("_id_changed?").call()
        apply_aliasing
      end
    end

    def apply_aliasing
      if relation_name.present? && relation_foreign_key.present?
        singleton = class << self; self end

        # Each instance will have it's own *_with_unscoped method definition
        singleton.send(:define_method, relation_method_name("_with_unscoped")) do
          relation_klass.unscoped.find(relation_method("_id").call())
        end

        singleton.send(:alias_method, relation_name, relation_method_name("_with_unscoped"))
      end
    end

    private
    def relation_klass
      reflection = self.class.reflect_on_association(relation_name)

      klass =
        if reflection.options[:polymorphic]
          relation_method("_type").call.constantize
        else
          self.class.reflect_on_association(relation_name).class_name.constantize
        end
    end

    def relation_foreign_key
      self.attributes[(relation_name.to_s + "_id")]
    end

    def relation_name
      self.class.association_name
    end

    def relation_method(message_suffix)
      self.method(relation_method_name(message_suffix))
    end

    def relation_method_name(message_suffix)
      (self.class.association_name.to_s + message_suffix).to_sym
    end
  end
end
ActiveRecord::Base.send :include, IgnoreDefaultScope::ActsAsOblivious
