require 'test_helper'

module Vedeu

  module Bindings

    describe Visibility do

      context 'the visibility events are defined' do
        it { Vedeu.bound?(:_clear_group_).must_equal(true) }

        it { Vedeu.bound?(:_cursor_hide_).must_equal(true) }
        it { Vedeu.bound?(:_cursor_show_).must_equal(true) }
        it { Vedeu.bound?(:_hide_cursor_).must_equal(true) }
        it { Vedeu.bound?(:_show_cursor_).must_equal(true) }
        it { Vedeu.bound?(:_toggle_cursor_).must_equal(true) }

        it { Vedeu.bound?(:_hide_group_).must_equal(true) }
        it { Vedeu.bound?(:_show_group_).must_equal(true) }
        it { Vedeu.bound?(:_toggle_group_).must_equal(true) }

        it { Vedeu.bound?(:_hide_interface_).must_equal(true) }
        it { Vedeu.bound?(:_show_interface_).must_equal(true) }
        it { Vedeu.bound?(:_toggle_interface_).must_equal(true) }
      end

    end # Visibility

  end # Bindings

end # Vedeu
