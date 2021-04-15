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

  describe '#attendees_by_ride_interest' do
    it 'returns hash with rides as keys and interested attendees as values' do
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

      expected = {
        ferris_wheel => [bob],
        bumper_cars => [bob, sally, johnny],
        scrambler => []
      }
      expect(jeffco_fair.attendees_by_ride_interest). to eq expected
    end
  end

  describe '#interested_riders' do
    it 'returns all attendees interested in a ride' do
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

      expect(jeffco_fair.interested_riders(ferris_wheel)).to eq [bob]
    end
  end

  describe '#ticket_lottery_contestants' do
    it 'returns an array of interested attendees without enough money' do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      bob = Attendee.new('Bob', 0)
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

      expected = [bob, johnny]
      expect(jeffco_fair.ticket_lottery_contestants(bumper_cars)).to eq expected
    end
  end

  describe '#draw_lottery_winner' do
    it 'returns a lottery winner from the contestants list' do
      jeffco_fair = Carnival.new("Jefferson County Fair")
      ferris_wheel = Ride.new({name: 'Ferris Wheel', cost: 0})
      bumper_cars = Ride.new({name: 'Bumper Cars', cost: 10})
      scrambler = Ride.new({name: 'Scrambler', cost: 15})
      bob = Attendee.new('Bob', 0)
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

      winner = jeffco_fair.draw_lottery_winner(bumper_cars)
      expect(jeffco_fair.ticket_lottery_contestants.include?(winner)).to be true
    end
  end
end
