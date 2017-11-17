## Parameter Chain

Parameter Chain allows you to chain methods to specify parameters, e.g.

```ruby
instance.bar(123).baz(321)
```

Which would be equivalent to:

```ruby
instance.some_method(:bar => 123, :baz => 321)
```

Parameter Chain provides a great out-of-the-box interface for dealing with search, or querying an API:

```ruby
api = SomeApi.new(key)
api.category(3).price('> 1000').brand(:apple)
```

Which would be equivalent to:

```ruby
api = SomeApi.new(key)
api.search(:category => 3, :price => '> 1000', :brand => :apple)
```

## Setup

```
gem install parameter_chain
```

```ruby
require 'parameter_chain'

class MyClass
  def my_method(params = {})
    # Do something with params, e.g.
    "Params: #{params.inspect}"
  end
  parameter_chain :my_method, :foo, :bar
end

instance = MyClass.new
instance.foo(123).bar(321)
#=> "Params: { :foo => 123, :bar => 321 }"
```

## Lazy Evaluation

Parameter chains are evaluated lazily. When you call something on the end of your chain, it passes the parameters to the method and evaluates.

If you're in IRB, the inspect method is called implicitly. This is why your chains look like hashes. You can verify this by running:

```ruby
instance.foo(123).bar(321).__class__
#=> ParameterChain
```

## Coming Soon

Chaining from class methods, e.g.

```ruby
MyClass.foo(123).bar(321)
```
