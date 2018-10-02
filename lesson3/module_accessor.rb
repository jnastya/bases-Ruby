module Accessors

  def attr_accessor_with_history(*names)
    attr_accessor :history
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=") do |value|
        instance_variable_set(var_name, value)
        @history ||= {}
        @history[name] ||= []
        @history[name] << value
      end
      define_method("#{name}_history") { @history[name] }
    end
  end

  def strong_attr_accessor(attr_name, type)
    var_name = "@#{attr_name}".to_sym
    define_method(attr_name) { instance_variable_get(var_name) }
    define_method("#{attr_name}=") do |value|
      if value.is_a? type
        instance_variable_set(var_name, value)
      else
        raise ArgumentError.new("Invalid Type")
      end
    end
  end
end
