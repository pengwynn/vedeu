require 'test_helper'

module Vedeu

  describe Button do

    let(:described) { Vedeu::Button }
    let(:instance) { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # Button

end # Vedeu
