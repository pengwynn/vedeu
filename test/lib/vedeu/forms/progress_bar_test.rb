require 'test_helper'

module Vedeu

  describe ProgressBar do

    let(:described)  { Vedeu::ProgressBar }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        height:   height,
        name:     _name,
        progress: progress,
        tasks:    tasks,
        width:    width,
      }
    }
    let(:height)   { 1 }
    let(:_name)    { 'progress_bar' }
    let(:progress) { 0 }
    let(:tasks)    { 1 }
    let(:width)    {}

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@height').must_equal(height) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
      it { instance.instance_variable_get('@progress').must_equal(progress) }
      it { instance.instance_variable_get('@tasks').must_equal(tasks) }
      it { instance.instance_variable_get('@width').must_equal(width) }
    end

    describe '#advance!' do
      subject { instance.advance! }

      it { subject.must_equal(1) }

      it do
        instance.advance!
        instance.advance!
        instance.advance!.must_equal(3)
      end
    end

    describe '#status' do
      subject { instance.status }

      it { subject.must_equal([0, 1]) }

      context 'after advancing' do
        before { instance.advance! }

        it { subject.must_equal([1, 1]) }
      end
    end

    describe '#to_s' do
      let(:progress) { 8 }
      let(:tasks)    { 10 }
      let(:width)    { 60 }

      subject { instance.to_s }

      it 'returns a bar representing the number of tasks completed' do
        subject.must_equal(
          "************************************************------------"
        )
      end

      context 'when the height is more than 1' do
        let(:height)   { 3 }
        let(:progress) { 4 }

        it 'returns a bar representing the number of tasks completed' do
          subject.must_equal(
            "************************------------------------------------\n" \
            "************************------------------------------------\n" \
            "************************------------------------------------"
          )
        end
      end
    end

  end # ProgressBar

end # Vedeu


