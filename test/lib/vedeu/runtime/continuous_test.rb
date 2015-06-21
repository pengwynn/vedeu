require 'test_helper'

module Vedeu

  describe Continuous do

    let(:described) { Vedeu::Continuous }
    let(:instance)  { described.new(_name) }
    let(:_name)     { 'long_runner' }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Vedeu::Continuous) }
      it { subject.instance_variable_get('@output').must_equal('') }
      it { subject.instance_variable_get('@name').must_equal(_name) }
    end

  end # Continuous

end # Vedeu
