require 'test_helper'

module Vedeu

  module Events

    describe Repository do

      let(:described) { Vedeu::Events::Repository }

      it { described.must_respond_to(:events) }

      describe '.reset!' do
        subject { described.reset! }

        it { described.must_respond_to(:reset) }

        it {
          described.expects(:new).with(Vedeu::Events::Collection)
          subject
        }
      end

    end # Repository

  end # Events

end # Vedeu
