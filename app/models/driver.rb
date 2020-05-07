class Driver < ApplicationRecord
  has_many :trips

  def total_earnings 
    # The driver gets 80% of the trip cost after a fee of $1.65 is subtracted
    return self.trips.sum { |trip| (trip.cost.to_f - 1.65) * 0.8 }    
  end

  def average_rating 
    total_rating = self.trips.sum { |trip| p trip.rating.to_f }
    length = self.trips.count
    return (total_rating / length).round(1)
  end
end
