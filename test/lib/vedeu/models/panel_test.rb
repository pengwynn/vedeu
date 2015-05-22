require 'test_helper'

module Vedeu

  describe Panel do

    let(:described)  { Vedeu::Panel }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        name:   _name,
        parent: parent,
      }
    }
    let(:_name)      {}
    let(:parent)     {}

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@attributes').must_equal(attributes) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
      it { instance.instance_variable_get('@parent').must_equal(parent) }
    end

  end # Panel

end # Vedeu


