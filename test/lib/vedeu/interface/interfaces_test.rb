require_relative '../../../test_helper'

module Vedeu
  class DummyInterface < Interface
    def initial_state; end

    def event_loop; end
  end

  describe Interfaces do
    let(:described_class) { Interfaces }

    describe '.define' do
      let(:subject) { described_class.define }

      it { subject.must_be_instance_of(Module) }
    end

    describe '.defined' do
      after { described_class.interfaces = {} }

      let(:subject) { described_class.defined }

      context 'when interfaces are not defined' do
        before { described_class.interfaces = {} }

        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when no interfaces are defined' do
        before { described_class.interfaces = { mock: :interface } }

        it { subject.must_be_instance_of(Module) }
      end
    end

    describe '.default' do
      let(:subject) { described_class.default }

      it { subject.must_be_instance_of(Module) }

      it 'adds the dummy interface to the interface list' do
        described_class.list.wont_be_empty
      end
    end

    describe '.add' do
      let(:interface) {}
      let(:klass)     { DummyInterface }
      let(:options)   { {} }

      let(:subject) { described_class.add(interface, klass, options) }

      it { subject.must_be_instance_of(Module) }

      context 'when the interface class does not exist' do
        before { Object.stubs(:const_defined?).returns(false) }

        it { proc { subject }.must_raise(UndefinedInterface) }
      end
    end

    describe '.list' do
      let(:subject) { described_class.list }

      it { subject.must_be_instance_of(String) }
    end

    describe '.initial_state' do
      let(:subject) { described_class.initial_state }

      it { subject.must_be_instance_of(Array) }
    end

    describe '.event_loop' do
      before do
        Terminal.stubs(:input)
        Commands.stubs(:execute).returns(:stop)
      end

      let(:subject) { described_class.event_loop }

      it { subject.must_be_instance_of(Array) }
    end
  end
end
