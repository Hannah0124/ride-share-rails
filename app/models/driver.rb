class Driver < ApplicationRecord
  has_many :trips, dependent: :destroy

  def total_earnings 
    # The driver gets 80% of the trip cost after a fee of $1.65 is subtracted
    return self.trips.sum { |trip| (trip.cost.to_f - 1.65) * 0.8 }    
  end

  def average_rating 
    length = self.trips.count  

    return 0 if length == 0 
      
    total_rating = self.trips.sum { |trip| p trip.rating.to_f }
    
    return (total_rating / length).round(1)
  end
end

 # reference: https://github.com/jenseng/immigrant/issues/31