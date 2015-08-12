require 'test_helper'

module Vedeu

	describe Fifo do

    let(:described) { Vedeu::Fifo }
    let(:instance)  { described.new(storage) }
    let(:storage)   { [] }
    let(:model)     { :some_model }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@storage').must_equal(storage) }
    end

    describe '#any?' do
      subject { instance.any? }

      context 'when the storage is not empty' do
        let(:storage) { [model] }

        it { subject.must_equal(true) }
      end

      context 'when the storage is empty' do
        it { subject.must_equal(false) }
      end
    end

    describe '#empty?' do
      subject { instance.empty? }

      context 'when the storage is not empty' do
        let(:storage) { [model] }

        it { subject.must_equal(false) }
      end

      context 'when the storage is empty' do
        it { subject.must_equal(true) }
      end
    end

    describe '#reset' do
      subject { instance.reset }

      context 'when the storage is not empty' do
        let(:storage) { [model] }

        it { subject.must_equal([]) }
      end

      context 'when the storage is empty' do
        it { subject.must_equal([]) }
      end
    end

    describe '#retrieve' do
      subject { instance.retrieve }

      context 'when the storage is not empty' do
        let(:storage) { [model] }

        it { subject.must_equal(model) }
      end

      context 'when the storage is empty' do
        it { subject.must_equal(nil) }
      end
    end

    describe '#size' do
      subject { instance.size }

      context 'when the storage is not empty' do
        let(:storage) { [model] }

        it { subject.must_equal(1) }
      end

      context 'when the storage is empty' do
        it { subject.must_equal(0) }
      end
    end

    describe '#store' do
      subject { instance.store(model) }

      context 'when the storage is not empty' do
        let(:storage) { [model] }

        it { subject.must_equal([model, model]) }
      end

      context 'when the storage is empty' do
        it { subject.must_equal([model]) }
      end
    end

	end # Fifo

end # Vedeu
