require 'test_helper'

module Vedeu

  module Buffers

    describe Buffer do

      let(:described)  { Vedeu::Buffers::Buffer }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          name:     _name,
          back:     back,
          front:    front,
          previous: previous,
        }
      }
      let(:_name)     { 'krypton' }
      let(:back)      {}
      let(:front)     {}
      let(:previous)  {}
      let(:interface) {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@back').must_equal(back) }
        it { instance.instance_variable_get('@front').must_equal(front) }
        it { instance.instance_variable_get('@previous').must_equal(previous) }
        it do
          instance.instance_variable_get('@repository').must_equal(Vedeu.buffers)
        end
      end

      describe 'accessors' do
        it { instance.must_respond_to(:back) }
        it { instance.must_respond_to(:back=) }
        it { instance.must_respond_to(:front) }
        it { instance.must_respond_to(:front=) }
        it { instance.must_respond_to(:previous) }
        it { instance.must_respond_to(:previous=) }
        it { instance.must_respond_to(:name) }
      end

      describe '#add' do
        let(:content) { Vedeu::Views::View.new(value: [Vedeu::Views::Line.new]) }

        subject { instance.add(content) }

        it { subject.must_equal(true) }
      end

      describe '#back?' do
        subject { instance.back? }

        context 'with content' do
          let(:back) {
            Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
          }

          it { subject.must_equal(true) }
        end

        context 'without content' do
          it { subject.must_equal(false) }
        end
      end

      describe '#clear' do
        let(:emptiness) { mock }

        before do
          Vedeu::Clear::NamedInterface.stubs(:render).returns(emptiness)
          Vedeu::Output.stubs(:render).returns(emptiness)
        end

        subject { instance.clear }

        it {
          Vedeu::Clear::NamedInterface.expects(:render).with(_name).
            returns(emptiness)
          Vedeu::Output.expects(:render).with(emptiness)
          subject
        }
      end

      describe '#front?' do
        subject { instance.front? }

        context 'with content' do
          let(:front) {
            Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
          }

          it { subject.must_equal(true) }
        end

        context 'without content' do
          it { subject.must_equal(false) }
        end
      end

      describe '#previous?' do
        subject { instance.previous? }

        context 'with content' do
          let(:previous) {
            Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
          }

          it { subject.must_equal(true) }
        end

        context 'without content' do
          it { subject.must_equal(false) }
        end
      end

      describe '#hide' do
        before { Vedeu::Output.stubs(:render) }

        subject { instance.hide }

        it {
          Vedeu::Output.expects(:render)
          subject
        }
      end

      describe '#show' do
        before { Vedeu::Output.stubs(:render) }

        subject { instance.show }

        it {
          Vedeu::Output.expects(:render)
          subject
        }
      end

      describe '#render' do
        before { Vedeu::Output.stubs(:render) }

        subject { instance.render }

        it {
          Vedeu::Output.expects(:render)
          subject
        }
      end

    end # Buffer

  end # Buffers

end # Vedeu
