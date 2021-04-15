class Carnival
  attr_reader :name,
              :rides
  def initialize(name)
    @name = name
    @rides = []
  end
end
