module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, *params)
      @validators ||= []
      @validators << { name: name, type: type, params: params }
    end
  end

  module InstanceMethods
    def validate!
      validators = self.class.instance_variable_get('@validators')
      return if validators.nil?
      validators.each do |validator|
        value = instance_variable_get("@#{validator[:name]}".to_sym)
        method_name = "#{validator[:type]}_validator"
        send(method_name, value, *validator[:params])
      end
    end

    protected

    def valid?
      validate!
      true
    rescue RuntimeError
      false
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
