module IgnoreDefaultScope
  class Relation
    attr_reader :host, :name, :id

    def initialize(args)
      @host = args[:host]
      @name = args[:name]
      @id = host_attribute("_id").call()
    end

    def klass
      klass = polymorphic? ? polymorphic_type : association_klass
    end

    def id_changed?
      host_attribute("_id_changed?").call()
    end

    private
    def host_attribute(message_suffix)
      host.method(attribute_name(message_suffix))
    end

    def attribute_name(message_suffix)
      (name.to_s + message_suffix).to_sym
    end

    def reflection
      host.class.reflect_on_association(name)
    end

    def polymorphic?
      reflection.options[:polymorphic]
    end

    def polymorphic_type
      host_attribute("_type").call.constantize
    end

    def association_klass
      reflection.class_name.constantize
    end
  end
end
