require 'rspec'
require './lib/attendee'

describe Attendee do
  describe '::new' do
    it 'exists' do
      attendee = Attendee.new('Bob', 20)

      expect(attendee).is_a? Attendee
    end

    it 'has a name' do
      attendee = Attendee.new('Bob', 20)

      expect(attendee.name).to eq 'Bob'
    end

    it 'has spending money' do
      attendee = Attendee.new('Bob', 20)

      expect(attendee.spending_money).to eq 20
    end

    it 'starts with no interests' do
      attendee = Attendee.new('Bob', 20)

      expect(attendee.interests).to eq []
    end
  end

  describe '#add_interest' do
    it 'adds interests to the interests array' do
      attendee = Attendee.new('Bob', 20)

      attendee.add_interest('Bumper Cars')
      attendee.add_interest('Ferris Wheel')

      expected = ["Bumper Cars", "Ferris Wheel"]
      expect(attendee.interests).to eq expected
    end
  end
end
