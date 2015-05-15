module Vedeu

  describe RadioList do

    let(:described) { Vedeu::RadioList }
    let(:instance) { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # RadioList

end # Vedeu

