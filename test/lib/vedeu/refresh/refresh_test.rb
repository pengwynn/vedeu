require 'test_helper'

module Vedeu

  describe Refresh do

    let(:described) { Vedeu::Refresh }
    let(:instance)  { described.new }

    describe '.all' do
      before { Vedeu.stubs(:trigger) }

      subject { described.all }

      it { subject.must_be_instance_of(Array) }

      context 'when there are no registered interfaces' do
        before { Vedeu.interfaces.reset }

        it { subject.must_equal([]) }
      end

      context 'when there are registered interfaces' do
        let(:interface)  { Vedeu::Interface.new(name: 'Vedeu::Refresh') }
        let(:interfaces) { [interface] }

        before { Vedeu.interfaces.stubs(:zindexed).returns(interfaces) }

        it {
          Vedeu.expects(:trigger).with(:_refresh_, 'Vedeu::Refresh')
          subject
        }

        it { subject.must_equal([interface]) }
      end
    end

    describe '#all' do
      it { instance.must_respond_to(:all) }
    end

  end # Refresh

end # Vedeu
