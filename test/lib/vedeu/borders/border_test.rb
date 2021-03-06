require 'test_helper'

module Vedeu

  module Borders

    describe Border do

      let(:described)  { Vedeu::Borders::Border }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          bottom_left:  'm',
          bottom_right: 'j',
          caption:      '',
          client:       nil,
          colour:       nil,
          enabled:      false,
          horizontal:   'q',
          name:         'borders',
          repository:   Vedeu.borders,
          show_bottom:  true,
          show_left:    true,
          show_right:   true,
          show_top:     true,
          style:        nil,
          title:        '',
          top_left:     'l',
          top_right:    'k',
          vertical:     'x',
        }
      }
      let(:geometry) {}

      before { Vedeu.geometries.stubs(:by_name).returns(geometry) }

      describe '.build' do
        subject {
          described.build(attributes) do
            horizontal '~'
          end
        }

        it { subject.must_be_instance_of(described) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it do
          instance.instance_variable_get('@attributes').
            must_equal(attributes)
        end
      end

      describe 'accessors' do
        it { instance.must_respond_to(:attributes) }
        it { instance.must_respond_to(:attributes=) }
        it { instance.must_respond_to(:bottom_left) }
        it { instance.must_respond_to(:bottom_left=) }
        it { instance.must_respond_to(:bottom_right) }
        it { instance.must_respond_to(:bottom_right=) }
        it { instance.must_respond_to(:caption) }
        it { instance.must_respond_to(:caption=) }
        it { instance.must_respond_to(:horizontal) }
        it { instance.must_respond_to(:horizontal=) }
        it { instance.must_respond_to(:show_bottom) }
        it { instance.must_respond_to(:bottom?) }
        it { instance.must_respond_to(:show_bottom=) }
        it { instance.must_respond_to(:show_left) }
        it { instance.must_respond_to(:left?) }
        it { instance.must_respond_to(:show_left=) }
        it { instance.must_respond_to(:show_right) }
        it { instance.must_respond_to(:right?) }
        it { instance.must_respond_to(:show_right=) }
        it { instance.must_respond_to(:show_top) }
        it { instance.must_respond_to(:top?) }
        it { instance.must_respond_to(:show_top=) }
        it { instance.must_respond_to(:title) }
        it { instance.must_respond_to(:title=) }
        it { instance.must_respond_to(:top_left) }
        it { instance.must_respond_to(:top_left=) }
        it { instance.must_respond_to(:top_right) }
        it { instance.must_respond_to(:top_right=) }
        it { instance.must_respond_to(:vertical) }
        it { instance.must_respond_to(:vertical=) }
        it { instance.must_respond_to(:name) }
        it { instance.must_respond_to(:enabled) }
        it { instance.must_respond_to(:enabled=) }
        it { instance.must_respond_to(:enabled?) }
      end

      describe 'border offset methods; bx, bxn, by, byn' do
        let(:attributes) {
          {
            bottom_left:  'C',
            bottom_right: 'D',
            enabled:      enabled,
            horizontal:   'H',
            name:         'Border#bxbxnbybyn',
            show_top:     top,
            show_bottom:  bottom,
            show_left:    left,
            show_right:   right,
            top_left:     'A',
            top_right:    'B',
            vertical:     'V'
          }
        }
        let(:enabled) { false }
        let(:top)     { false }
        let(:bottom)  { false }
        let(:left)    { false }
        let(:right)   { false }
        let(:geometry) {
          Vedeu::Geometry::Geometry.new(name: 'Border#bxbxnbybyn',
                                        x:    2,
                                        xn:   6,
                                        y:    2,
                                        yn: 6)
        }

        describe '#bx' do
          subject { instance.bx }

          context 'when enabled' do
            let(:enabled) { true }

            context 'with left' do
              let(:left) { true }

              it { subject.must_equal(3) }
            end

            context 'without left' do
              it { subject.must_equal(2) }
            end
          end

          context 'when not enabled' do
            it { subject.must_equal(2) }
          end
        end

        describe '#bxn' do
          subject { instance.bxn }

          context 'when enabled' do
            let(:enabled) { true }

            context 'with right' do
              let(:right) { true }

              it { subject.must_equal(5) }
            end

            context 'without right' do
              it { subject.must_equal(6) }
            end
          end

          context 'when not enabled' do
            it { subject.must_equal(6) }
          end
        end

        describe '#by' do
          subject { instance.by }

          context 'when enabled' do
            let(:enabled) { true }

            context 'with top' do
              let(:top) { true }

              it { subject.must_equal(3) }
            end

            context 'without top' do
              it { subject.must_equal(2) }
            end
          end

          context 'when not enabled' do
            it { subject.must_equal(2) }
          end
        end

        describe '#byn' do
          subject { instance.byn }

          context 'when enabled' do
            let(:enabled) { true }

            context 'with bottom' do
              let(:bottom) { true }

              it { subject.must_equal(5) }
            end

            context 'without bottom' do
              it { subject.must_equal(6) }
            end
          end

          context 'when not enabled' do
            it { subject.must_equal(6) }
          end
        end
      end

      describe '#width' do
        let(:geometry) {
          Vedeu::Geometry::Geometry.new(name: 'borders', width: 8)
        }

        subject { instance.width }

        context 'when the border is not enabled' do
          it 'returns the interface width' do
            subject.must_equal(8)
          end
        end

        context 'when the border is enabled' do
          context 'when both left and right borders are shown' do
            let(:attributes) {
              {
                enabled: true,
                name:    'borders',
              }
            }

            it { subject.must_equal(6) }
          end

          context 'when either the left or right border is shown' do
            let(:attributes) {
              {
                enabled:   true,
                name:      'borders',
                show_left: false
              }
            }

            it { subject.must_equal(7) }
          end

          context 'when neither left nor right borders are shown' do
            let(:attributes) {
              {
                enabled:    true,
                name:       'borders',
                show_left:  false,
                show_right: false
              }
            }

            it { subject.must_equal(8) }
          end
        end
      end

      describe '#height' do
        let(:geometry) {
          Vedeu::Geometry::Geometry.new(name: 'borders', height: 5)
        }

        subject { instance.height }

        context 'when the border is not enabled' do
          it 'returns the interface height' do
            subject.must_equal(5)
          end
        end

        context 'when the border is enabled' do
          context 'when both top and bottom borders are shown' do
            let(:attributes) {
              {
                enabled: true,
                name:    'borders',
              }
            }

            it { subject.must_equal(3) }
          end

          context 'when either the top or bottom border is shown' do
            let(:attributes) {
              {
                enabled:  true,
                name:     'borders',
                show_top: false
              }
            }

            it { subject.must_equal(4) }
          end

          context 'when neither top nor bottom borders are shown' do
            let(:attributes) {
              {
                enabled:     true,
                name:        'borders',
                show_top:    false,
                show_bottom: false
              }
            }

            it { subject.must_equal(5) }
          end
        end
      end

      describe '#enabled?' do
        subject { instance.enabled? }

        it { subject.must_be_instance_of(FalseClass) }

        context 'when true' do
          let(:attributes) {
            {
              enabled: true,
              name:    'borders',
            }
          }

          it { subject.must_be_instance_of(TrueClass) }
        end
      end

      describe '#bottom?' do
        subject { instance.bottom? }

        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:attributes) {
            {
              enabled:     true,
              name:        'borders',
              show_bottom: false,
            }
          }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#left?' do
        subject { instance.left? }

        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:attributes) {
            {
              enabled:   true,
              name:      'borders',
              show_left: false,
            }
          }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#right?' do
        subject { instance.right? }

        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:attributes) {
            {
              enabled:    true,
              name:       'borders',
              show_right: false,
            }
          }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#top?' do
        subject { instance.top? }

        it { subject.must_be_instance_of(TrueClass) }

        context 'when false' do
          let(:attributes) {
            {
              enabled:  true,
              name:     'borders',
              show_top: false,
            }
          }

          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#render' do
        before { Vedeu::Borders::Render.stubs(:with) }

        subject { instance.render }

        it {
          Vedeu::Borders::Render.expects(:with).with(instance)
          subject
        }
      end

    end # Border

  end # Borders

end # Vedeu
