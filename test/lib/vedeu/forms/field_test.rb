module Vedeu

  describe Field do

    let(:described) { Vedeu::Field }
    let(:instance) { described.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

  end # Field

end # Vedeu

