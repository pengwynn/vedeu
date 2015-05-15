require 'test_helper'

module Vedeu

  describe CheckList do

    let(:described) { Vedeu::CheckList }
    let(:instance) { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # CheckList

end # Vedeu

