module Manufacturer

  def company_name
    @company_name
  end

  def company_name=(name)
    @company_name = name
  end

end


module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instance_counter ||= 0
    end

    def instances=(value)
      @instance_counter = value
    end
  end

  module InstanceMethods

    protected

    def register_instance
      self.class.instances += 1
    end
  end
end
