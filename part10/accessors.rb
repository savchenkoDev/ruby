# Module
module Accessors
  def attr_accessor_with_history(*atributes)
    atributes.each do |attr|
      var_name = "@#{attr}".to_sym
      history = "@#{attr}_history".to_sym
      # Getter for instance variable <attr>_history
      define_method("#{attr}_history".to_sym) { instance_variable_get(history) }
      # Getter for instance variable <attr>
      define_method(attr) { instance_variable_get(var_name) }
      # Setter for instance variable <attr>
      define_method("#{attr}=".to_sym) do |value|
        instance_variable_set(history, []) if instance_variable_get(history).nil?
        instance_variable_set(var_name, value)
        instance_variable_set(history, instance_variable_get(history) << value)
      end
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    # Getter for instance variable <name>
    define_method(name) { instance_variable_get(var_name) }
    # Setter for instance variable <name>
    define_method("#{name}=".to_sym) do |value|
      raise 'invalid argument type' if value.class != class_name
      instance_variable_set(var_name, value)
    end
  end
end
