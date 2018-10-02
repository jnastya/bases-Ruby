def strong_attr_accessor(attr_name, self.class)
  var_name = "@#{attr_name}".to_sym
  define_method(attr_name) { instance_variable_get(var_name) }
  define_method("#{attr_name}=") do |value|
    if value is_a? self.class
      instance_variable_set(var_name, value)
    else
      raise 'Не соответствует имя класса'
    end
  end
end
