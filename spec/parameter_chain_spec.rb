require 'spec_helper'

describe ParameterChain do

  subject do
    class Foo; def foo(params = {}); params; end; end
    ParameterChain.new(Foo.new, :foo, [:bar, :baz])
  end

  describe '#__class__' do
    it 'is the only mechanism for fetching the class' do
      subject.class.should_not == ParameterChain
    end

    it 'returns the ParameterChain class' do
      subject.__class__.should == ParameterChain
    end
  end

  describe '#object_id' do
    it 'is defined so that a warning is not thrown' do
      subject.methods.should include(:object_id)
    end
  end

  describe 'internal methods' do
    let!(:internal_methods) { Object.new.methods.select { |m| m =~ /^__/ } }

    it 'leaves them defined' do
      internal_methods.each do |m|
        subject.methods.should include(m), m
      end
    end
  end

  describe '#initialize' do
    it 'defines a method for each parameter' do
      expect { subject.bar(nil) }.to_not raise_error
      expect { subject.baz(nil) }.to_not raise_error
    end

    it 'does not define a callback method' do
      expect { subject.foo(nil) }.to raise_error(NoMethodError)
    end
  end

  describe 'dynamic method' do
    before do
      class ParameterChain; def hash; @hash; end; end
    end

    it 'facilitates chaining' do
      subject.bar(nil).__class__.should == ParameterChain
    end

    it 'adds its method-argument pair to the internal hash' do
      subject.bar(123).hash.should == { :bar => 123 }
      subject.baz(321).bar(123).should == { :bar => 123, :baz => 321 }
    end

    it 'facilitates multiline chaining' do
      bar = subject.bar(123)
      bar.baz(321).hash.should == { :bar => 123, :baz => 321 }
    end
  end
end
