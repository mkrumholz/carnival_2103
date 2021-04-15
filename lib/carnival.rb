class Carnival
  attr_reader :name,
              :rides

  def initialize(name)
    @name = name
    @rides = []
  end

  def add_ride(ride)
    @rides << ride
  end 
end
