class Carnival
  attr_reader :name,
              :rides,
              :attendees

  def initialize(name)
    @name = name
    @rides = []
    @attendees = []
  end

  def add_ride(ride)
    @rides << ride
  end

  def recommend_rides(attendee)
    @rides.find_all do |ride|
      attendee.interests.include?(ride.name)
    end
  end

  def admit(attendee)
    @attendees << attendee
  end

  def attendees_by_ride_interest
    all_rides = @rides.reduce({}) do |all_rides, ride|
      # interested = @attendees.find_all do |attendee|
      #   attendee.interests.include?(ride.name)
      # end
      interested = interested_riders(ride)
      all_rides.update(ride => interested)
    end
  end

  def interested_riders(ride)
    @attendees.find_all do |attendee|
      attendee.interests.include?(ride.name)
    end
  end

  def ticket_lottery_contestants

  end
end
