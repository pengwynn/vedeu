require 'test_helper'

module Vedeu

  module Bindings

    describe Movement do

      context 'the movement events are defined' do
        it { Vedeu.bound?(:_cursor_down_).must_equal(true) }
        it { Vedeu.bound?(:_cursor_left_).must_equal(true) }
        it { Vedeu.bound?(:_cursor_origin_).must_equal(true) }
        it { Vedeu.bound?(:_cursor_position_).must_equal(true) }
        it { Vedeu.bound?(:_cursor_reposition_).must_equal(true) }
        it { Vedeu.bound?(:_cursor_reset_).must_equal(true) }
        it { Vedeu.bound?(:_cursor_right_).must_equal(true) }
        it { Vedeu.bound?(:_cursor_up_).must_equal(true) }
        it { Vedeu.bound?(:_geometry_down_).must_equal(true) }
        it { Vedeu.bound?(:_geometry_left_).must_equal(true) }
        it { Vedeu.bound?(:_geometry_right_).must_equal(true) }
        it { Vedeu.bound?(:_geometry_up_).must_equal(true) }
        it { Vedeu.bound?(:_view_down_).must_equal(true) }
        it { Vedeu.bound?(:_view_left_).must_equal(true) }
        it { Vedeu.bound?(:_view_right_).must_equal(true) }
        it { Vedeu.bound?(:_view_up_).must_equal(true) }
      end

    end # Movement

  end # Bindings

end # Vedeu
