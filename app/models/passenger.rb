class Passenger < ApplicationRecord
  has_many :trips

  def total_charges 
    return self.trips.sum { |trip| p trip.cost.to_f }.round(2)
  end

end
