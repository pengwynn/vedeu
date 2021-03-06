require 'test_helper'

module Vedeu

  module Renderers

    describe JSON do

      let(:described) { Vedeu::Renderers::JSON }
      let(:instance)  { described.new(options) }
      let(:options)   { {} }
      let(:output)    {}

      before { ::File.stubs(:write) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '#render' do
        subject { instance.render(output) }

        it { subject.must_be_instance_of(String) }

        context 'when the output is empty' do
          it { subject.must_equal('') }
        end

        context 'when the output is not empty' do
          let(:colour) {
            Vedeu::Colours::Colour.new(foreground: '#ff0000',
                                       background: '#ffffff')
          }
          let(:output) {
            [
              [
                Vedeu::Views::Char.new(value: 'a',
                                       colour: colour,
                                       parent: parent,
                                       position: Vedeu::Geometry::Position[5, 3])
              ]
            ]
          }
          let(:parent)   {}
          let(:expected) {
            <<-eos
[
  {
    \"border\": \"\",
    \"colour\": {
      \"background\": \"\\u001b[48;2;255;255;255m\",
      \"foreground\": \"\\u001b[38;2;255;0;0m\"
    },
    \"parent\": {
    },
    \"position\": {
      \"y\": 5,
      \"x\": 3
    },
    \"style\": \"\",
    \"value\": \"a\"
  }
]
            eos
          }

          it { subject.must_equal(expected.chomp) }

          context 'when a parent is available' do
            let(:parent) {
              Vedeu::Views::Stream.new(
                colour: Vedeu::Colours::Colour.coerce(background: '',
                                                      foreground: '')
              )
            }

            let(:expected) {
              <<-eos
[
  {
    \"border\": \"\",
    \"colour\": {
      \"background\": \"\\u001b[48;2;255;255;255m\",
      \"foreground\": \"\\u001b[38;2;255;0;0m\"
    },
    \"parent\": {
      \"background\": \"\",
      \"foreground\": \"\",
      \"style\": \"\"
    },
    \"position\": {
      \"y\": 5,
      \"x\": 3
    },
    \"style\": \"\",
    \"value\": \"a\"
  }
]
              eos
            }

            it { subject.must_equal(expected.chomp) }
          end
        end
      end

    end # JSON

  end # Renderers

end # Vedeu
