module Vedeu

  describe RadioList do

    let(:described) { Vedeu::RadioList }
    let(:instance)  { described.new(options) }
    let(:options)   {}

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@options').must_equal(options) }
    end

  end # RadioList

end # Vedeu

