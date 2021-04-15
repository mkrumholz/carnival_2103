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

    it 'starts with no attendees' do
      jeffco_fair = Carnival.new("Jefferson County Fair")

      expect(jeffco_fair.attendees).to eq []
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

  describe '#recommend_rides' do
    it 'recommends rides to an attendee that match their interests' do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      bob = Attendee.new('Bob', 20)
      sally = Attendee.new('Sally', 20)

      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(scrambler)
      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')
      sally.add_interest('Scrambler')

      bob_expected = [ferris_wheel, bumper_cars]
      sally_expected = [scrambler]
      expect(jeffco_fair.recommend_rides(bob)).to eq bob_expected
      expect(jeffco_fair.recommend_rides(sally)).to eq sally_expected
    end
  end

  describe '#admit' do
    it 'adds attendees to the attendees array' do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      bob = Attendee.new('Bob', 20)
      sally = Attendee.new('Sally', 20)
      johnny = Attendee.new('Johnny', 5)

      jeffco_fair.add_ride(ferris_wheel)
      jeffco_fair.add_ride(bumper_cars)
      jeffco_fair.add_ride(scrambler)
      bob.add_interest('Ferris Wheel')
      bob.add_interest('Bumper Cars')
      sally.add_interest('Bumper Cars')
      johnny.add_interest('Bumper Cars')
      jeffco_fair.admit(bob)
      jeffco_fair.admit(sally)
      jeffco_fair.admit(johnny)

      expected = [bob, sally, johnny]
      expect(jeffco_fair.attendees).to eq expected
    end
  end
end
