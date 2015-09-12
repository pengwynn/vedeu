require 'test_helper'

module Vedeu

  module Terminal

    describe Buffer do

      let(:described)    { Vedeu::Terminal::Buffer }
      let(:empty_buffer) {
        Array.new(2) do |y|
          Array.new(3) do |x|
            Vedeu::Cell.new(position: [y + 1, x + 1])
          end
        end
      }

      before do
        Vedeu.stubs(:height).returns(2)
        Vedeu.stubs(:width).returns(3)
        Vedeu::Terminal::Buffer.reset
      end

      describe '#output' do
        subject { described.output }

        context 'when nothing has been written to the buffer' do
          it {
            described.instance_variable_get('@output').must_equal(empty_buffer)
          }
        end

        context 'when something has been written to the buffer' do
          let(:expected) {
            exp = empty_buffer
            exp[1][2] = Vedeu::Views::Char.new(value: 'a', position: [1, 2])
            exp
          }

          before do
            described.write(Vedeu::Views::Char.new(value: 'a',
                                                   position: [1, 2]))
          end

          it { described.instance_variable_get('@output').must_equal(expected) }
        end
      end

      describe '#render' do
        subject { described.render }

        context 'when Vedeu is not ready' do
          before do
            Vedeu.stubs(:ready?).returns(false)
          end

          it { subject.must_equal(nil) }
        end

        context 'when Vedeu is ready' do
          before do
            Vedeu.stubs(:ready?).returns(true)
          end

          it {
            Vedeu.renderers.expects(:render).with(described)
            subject
          }
        end
      end

      describe '#reset' do
        subject { described.reset }

        it {
          described.instance_variable_get('@output').must_equal(empty_buffer)
        }
        it { subject.must_equal(empty_buffer) }
      end

      describe '#terminal' do
        subject { described.terminal }

        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal(empty_buffer) }
      end

      describe '#write' do
        let(:_value) {}

        subject { described.write(_value) }

        context 'when the value is nil' do
          let(:expected) {
            [
              [
                Vedeu::Cell.new(position: [1, 1]),
                Vedeu::Cell.new(position: [1, 2]),
                Vedeu::Cell.new(position: [1, 3])
              ], [
                Vedeu::Cell.new(position: [2, 1]),
                Vedeu::Cell.new(position: [2, 2]),
                Vedeu::Cell.new(position: [2, 3])
              ]
            ]
          }

          it { subject.must_equal(described) }
          it { described.output.must_equal(expected) }
        end

        context 'when the value is not nil' do
          let(:_value)   { Vedeu::Views::Char.new(y: 2, x: 1, value: 'a') }
          let(:expected) {

          }

          it { subject.must_equal(described) }
          it { described.output.must_equal(expected) }
        end
      end

    end # Buffer

  end # Terminal

end # Vedeu
