require 'spec_helper'

describe Object do

  subject do
    class Foo
      def foo(params = {})
        params
      end
      parameter_chain :foo, :bar, :baz
    end

    Foo.new
  end

  it 'defines methods on the object' do
    subject.methods.should include(:bar, :baz)
  end

  it 'lazily evaluates' do
    subject.should_not_receive(:foo)
    subject.bar(123).baz(321)
  end

  it "delegates everything to the return value of the given method" do
    acts_as_hash = subject.bar(123).baz(321)
    acts_as_hash.class.should == Hash
    acts_as_hash.inspect.should == "{:bar=>123, :baz=>321}"
    acts_as_hash.merge(:qux => true).should == { :bar => 123, :baz => 321, :qux => true }
  end

  it 'does not alter the given method' do
    subject.foo(:asd => 123).should == { :asd => 123 }
  end

end
