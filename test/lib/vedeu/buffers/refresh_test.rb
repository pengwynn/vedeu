require 'test_helper'

module Vedeu

  module Buffers

    describe Refresh do

      let(:described) { Vedeu::Buffers::Refresh }
      let(:instance)  { described.new(_name) }
      let(:_name)     { 'Vedeu::Buffers::Refresh' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.by_name' do
        subject { described.by_name(_name) }

        context 'when the name is not present' do
          let(:_name) { '' }

          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end

        # describe '.by_name' do
        #   let(:_name)  { 'aluminium' }
        #   let(:buffer) { Vedeu::Buffers::Null.new(name: _name) }
        #
        #   subject { described.by_name(_name) }
        #
        #   it {
        #     Vedeu.buffers.expects(:by_name).with(_name).returns(buffer)
        #     buffer.expects(:render)
        #     subject
        #   }
        # end

        context 'when the name is present' do
          # @todo Add more tests.
          # it { skip }
        end
      end

      describe '#by_name' do
        it { instance.must_respond_to(:by_name) }
      end

    end # Refresh

  end # Buffers

end # Vedeu
