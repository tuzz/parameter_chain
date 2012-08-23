class ParameterChain
  alias_method :__class__, :class

  instance_methods.each do |method|
    next if method == :object_id
    next if method =~ /^__/ # Internal methods.

    undef_method method
  end

  def initialize(object, callback, params)
    @object = object
    @callback = callback

    @hash = {}
    params.each do |param|
      __class__.send(:define_method, param) do |arg|
        @hash[param] = arg
        self
      end
    end
  end

  def method_missing(method, *args)
    @object.send(@callback, @hash).send(method, *args)
  end

  def self.for(klass, callback, params)
    this = self # Store self for use in block scope.

    params.each do |param|
      klass.send(:define_method, param) do |arg|
        chain = this.new(self, callback, params)
        chain.__send__(param, arg)
      end
    end

    nil
  end
end

class Object
  def self.parameter_chain(callback, *params)
    ParameterChain.for(self, callback, params)
  end
end
