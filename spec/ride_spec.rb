require 'rspec'
require './lib/ride'

describe Ride do
  describe '::new' do
    it 'exists' do
      ride = Ride.new({name: 'Ferris Wheel', cost: 0})

      expect(ride).is_a? Ride
    end

    it 'has a name' do
      ride = Ride.new({name: 'Ferris Wheel', cost: 0})

      expect(ride.name).to eq 'Ferris Wheel'
    end

    it 'has a cost' do
      ride = Ride.new({name: 'Ferris Wheel', cost: 0})

      expect(ride.cost).to eq 0
    end
  end
end
