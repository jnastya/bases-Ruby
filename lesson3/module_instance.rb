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
