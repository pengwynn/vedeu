require 'test_helper'

module Vedeu

  describe Registerable do

    class RegisterableTestClass

      include Vedeu::Registerable

      null Vedeu::ModelTestClass
      real Vedeu::ModelTestClass

    end

    let(:described) { Vedeu::Registerable }

    it { RegisterableTestClass.must_respond_to(:repository) }
    it { RegisterableTestClass.must_respond_to(:register) }

    describe '.null' do
      subject { RegisterableTestClass.new }

      it { RegisterableTestClass.must_respond_to(:null) }

      it { subject.must_respond_to(:null_model) }
      it { subject.null_model.must_equal(Vedeu::ModelTestClass) }
    end

    describe '.real' do
      subject { RegisterableTestClass.new }

      it { RegisterableTestClass.must_respond_to(:real) }

      it { subject.must_respond_to(:model) }
      it { subject.model.must_equal(Vedeu::ModelTestClass) }
    end

    describe '.reset' do
      subject { RegisterableTestClass.reset! }

      before { RegisterableTestClass.stubs(:register) }

      it { RegisterableTestClass.must_respond_to(:reset!) }
      it { RegisterableTestClass.must_respond_to(:reset) }

      it {
        RegisterableTestClass.expects(:register)
        subject
      }
    end

  end # Registerable

end # Vedeu
