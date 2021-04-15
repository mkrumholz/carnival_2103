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
end
