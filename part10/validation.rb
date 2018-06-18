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
      instance_variable_set('@val'.to_sym, validators << [name, type, params])
    end
  end
  # Module
  module InstanceMethods
    define_method(:validate!) do
      validations = self.class.instance_variable_get('@val')
      return if validations.nil?
      validations.each do |validator|
        value = instance_variable_get("@#{validator[0]}".to_sym)
        case validator[1]
        when :presence then presence_validator(value)
        when :type then type_validator(value, validator[2][0])
        when :format then format_validator(value, validator[2][0])
        end
      end
    end

    define_method(:valid?) do
      begin
        validate!
      rescue RuntimeError
        return false
      end
      return true
    end

    define_method(:presence_validator) do |value|
      raise 'Empty attribute' if value.to_s.nil? || value.to_s.strip.empty?
    end

    define_method(:type_validator) do |value, param|
      raise 'Invalid type attribute' if value.class != param
    end

    define_method(:format_validator) do |value, param|
      raise 'Invalid format attribute' if value !~ param
    end
  end
end
