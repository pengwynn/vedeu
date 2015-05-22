require 'test_helper'

module Vedeu

  describe Button do

    let(:described) { Vedeu::Button }
    let(:instance)  { described.new(label: label, name: _name, value: _value) }
    let(:label)     {}
    let(:_name)     {}
    let(:_value)    {}

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@label').must_equal(label) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
      it { instance.instance_variable_get('@value').must_equal(_value) }
    end

  end # Button

end # Vedeu
