require 'test_helper'

module Vedeu

  describe MenuItem do

    describe '#initialize' do
      subject { MenuItem.new }

      it 'returns an instance of itself' do
        subject.must_be_instance_of(MenuItem)
      end
    end

  end # MenuItem

end # Vedeu
