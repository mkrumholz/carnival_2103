require 'rspec'
require './lib/ride'
require './lib/attendee'
require './lib/carnival'

describe Carnival do
  describe '::new' do
    it 'exists' do
      jeffco_fair = Carnival.new("Jefferson County Fair")

      expect(jeffco_fair).is_a? Carnival
    end

    it 'has a name' do
      jeffco_fair = Carnival.new("Jefferson County Fair")

      expect(jeffco_fair.name).to eq "Jefferson County Fair"
    end

    it 'starts with no rides' do
      jeffco_fair = Carnival.new("Jefferson County Fair")

      expect(jeffco_fair.rides).to eq []
    end
  end

  describe '#add_ride' do
    it 'adds rides to rides array' do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})

      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(scrambler)

      expected = [ferris_wheel, bumper_cars, scrambler]
      expect(jeffco_fair.rides).to eq expected
    end
  end
end
