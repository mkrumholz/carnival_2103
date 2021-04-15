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
end
