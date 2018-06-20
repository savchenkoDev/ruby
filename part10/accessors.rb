# Module
module Accessors
  def attr_accessor_with_history(*atributes)
    atributes.each do |attr|
      var_name = "@#{attr}".to_sym
      history = "@#{attr}_history".to_sym
      define_method("#{attr}_history".to_sym) { instance_variable_get(history) }
      define_method(attr) { instance_variable_get(var_name) }
      define_method("#{attr}=".to_sym) do |value|
        history_value = instance_variable_get(history) || []
        history_value << instance_variable_get(var_name)
        instance_variable_set(history, history_value)
        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'invalid argument type' if value.class != class_name
      instance_variable_set(var_name, value)
    end
  end
end
