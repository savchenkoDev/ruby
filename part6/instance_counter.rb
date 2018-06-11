module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def initialize
      @instances = 0
    end

    def instances
      @instances ||= 0
    end

    def register_instance
      @instances = instances + 1
    end
  end
  #
  module InstanceMethods
    protected
    def register_instance
      self.class.register_instance
    end
  end
end
