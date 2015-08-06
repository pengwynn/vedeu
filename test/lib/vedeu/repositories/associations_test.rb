require 'test_helper'

module Vedeu

  class BaseTestClass
    def initialize(name)
      @name = name
    end
  end

  class Driver < BaseTestClass
    include Vedeu::Associations

    has_one :car
  end

  class Car < BaseTestClass
    include Vedeu::Associations

    belongs_to :driver
  end

  class Dog < BaseTestClass
    include Vedeu::Associations

    has_many :fleas
  end

  class Flea < BaseTestClass
    include Vedeu::Associations

    belongs_to :dog
  end

	module Associations

    describe ClassMethods do

      context 'has_one and belongs_to' do
        let(:driver) { Driver.new('Mike') }
        let(:car)    { Car.new('A') }

        it 'initializes unrelated/unassociated' do
          car.driver.must_equal(nil)
          driver.car.must_equal(nil)
        end

        it 'associates the car to the driver and viceversa' do
          driver.car = car
          car.driver.must_equal(driver)
          driver.car.must_equal(car)
        end

        it 'associates the driver to the car and viceversa' do
          car.driver = driver
          driver.car.must_equal(car)
          car.driver.must_equal(driver)
        end

        context 'when the car is transferred to another owner/driver' do
          let(:another_driver) { Driver.new('Bob') }

          it 'detaches the car from the previous owner' do
            car.driver = driver
            driver.car.must_equal(car)
            car.driver.must_equal(driver)

            # car changes owner
            car.driver = another_driver
            driver.car.must_equal(nil)
            car.driver.must_equal(another_driver)
            another_driver.car.must_equal(car)
          end
        end
      end

      context 'has_one' do
        let(:driver) { Driver.new('Gav') }
        let(:car)    { Car.new('A') }

        before { driver.car = car }

        it { driver.car.must_equal(car) }
      end

      context 'has_many and belongs_to' do
        let(:big_dog) { Dog.new('Big dog') }
        let(:flea_a)  { Flea.new('A') }
        let(:flea_b)  { Flea.new('B') }

        context 'when dog gets fleas' do
          let(:dog_with_fleas) do
            big_dog.fleas = [flea_a, flea_b]
            big_dog
          end

          it 'initializes with an empty array of fleas' do
            big_dog.fleas.must_equal([])
          end

          it 'is directly associated with pre-existant fleas' do
            dog_with_fleas.fleas.must_equal([flea_a, flea_b])
          end

          it 'correctly sets the right dog to each flea' do
            dog_with_fleas.fleas.each do |flea|
              flea.dog.must_equal(dog_with_fleas)
            end
          end

          it 'has a method for adding and removing fleas' do
            big_dog.must_respond_to(:add_flea)
            big_dog.must_respond_to(:remove_flea)
          end

          it 'can be add more fleas to it via #add_flea' do
            big_dog.add_flea flea_a
            big_dog.fleas.must_equal([flea_a])

            big_dog.add_flea flea_b
            big_dog.fleas.must_equal([flea_a, flea_b])
          end

          it 'can be removed more fleas from it via #remove_flea' do
            dog_with_fleas.remove_flea(flea_a)
            dog_with_fleas.fleas.must_equal([flea_b])

            dog_with_fleas.remove_flea(flea_b)
            dog_with_fleas.fleas.must_equal([])
          end

        end

        context 'when fleas jump onto big_dog' do
          it 'fleas have no dog to begin with' do
            flea_a.dog.must_equal(nil)
          end

          it 'fleas may have the big_dog associated to them and viceversa' do
            flea_a.dog = big_dog
            flea_a.dog.must_equal(big_dog)
            big_dog.fleas.must_equal([flea_a])

            flea_b.dog = big_dog
            flea_b.dog.must_equal(big_dog)
            big_dog.fleas.must_equal([flea_a, flea_b])
          end

        end

        context 'when fleas jump between dogs' do
          let(:small_dog) { Dog.new('Small dog') }

          it 'cannot be in two dogs at the same time' do
            flea_a.dog = big_dog
            flea_b.dog = big_dog
            flea_a.dog.must_equal(big_dog)
            flea_b.dog.must_equal(big_dog)
            big_dog.fleas.must_equal([flea_a, flea_b])

            # flea A jumps from big dog to small dog
            flea_a.dog = small_dog
            flea_a.dog.must_equal(small_dog)
            small_dog.fleas.must_equal([flea_a])

            # flea A no longer in big dog
            big_dog.fleas.wont_include(flea_a)
            big_dog.fleas.must_equal([flea_b])# sanity check
          end

        end

        context 'when a dog catches some fleas from another dog' do
          let(:small_dog) { Dog.new('Small dog') }

          it 'the other dog losses part of its fleas' do
            big_dog.fleas = [flea_a, flea_b]

            # small_dog is close enough to bid_dog and it caches a flea
            small_dog.fleas = [flea_a]

            # flea A no longer in big dog
            big_dog.fleas.wont_include(flea_a)
            big_dog.fleas.must_equal([flea_b])# sanity check
          end

        end

      end

    end # ClassMethods

	end # Associations

end # Vedeu
