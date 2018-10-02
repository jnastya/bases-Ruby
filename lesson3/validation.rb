module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate (attr_name, val_type, *params)
      @validations ||= []
      @validations << {attr: attr_name, type: val_type, params: params}
    end
  end

  module InstanceMethods

    def valid?
      validate!
    rescue StandardError
      false
    end

    protected

    def validate!
      self.class.validations.each do |validation|
        validation_method = "validate_#{validation[:type]}".to_sym
        send(validation_method, validation[:attr], validation[:params])
      end

      true
    end

    def validate_presence(name, _params)
      value = instance_variable_get("@#{name}")
      raise "Значение атрибута не должно быть nil или пустой строкой" if value.to_s.empty?
    end

    def validate_format(name, params)
      value = instance_variable_get("@#{name}")
      raise "Значение атрибута не соответствует заданному регулярному выражению" if value !~ params[0]
    end

    def validate_type(name, params)
      value = instance_variable_get("@#{name}")
      raise "Значение атрибута не соответствует заданному классу" if value.class != params[0]
    end
  end
end
