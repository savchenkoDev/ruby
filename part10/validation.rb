# Module
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  # Module
  module ClassMethods
    define_method(:validate) do |name, type, *params|
      instance_variable_set('@val'.to_sym, []) if instance_variable_get('@val').nil?
      validators = instance_variable_get('@val')
      instance_variable_set('@val'.to_sym, validators << {
        name: name,
        type: type,
        params: params
      })
    end
  end
  # Module
  module InstanceMethods
    define_method(:validate!) do
      validations = self.class.instance_variable_get('@val')
      return if validations.nil?
      validations.each do |validator|
        value = instance_variable_get("@#{validator[:name]}".to_sym)
        method_name = "#{validation[:type]}_validator"
        send(method_name, value, validator[:params])
      end
    end

    protected

    def valid?
      validate!
      true
    rescue RuntimeError
      return false
    end

    def presence_validator(value)
      raise 'Empty attribute' if value.to_s.nil? || value.to_s.strip.empty?
    end

    def type_validator(value, param)
      raise 'Invalid type attribute' if value.class != param
    end

    def format_validator(value, param)
      raise 'Invalid format attribute' if value !~ param
    end
  end
end
