class Passenger < ApplicationRecord
  has_many :trips, dependent: :destroy

  def total_charges 
    return self.trips.sum { |trip| p trip.cost.to_f }.round(2)
  end

end

  # reference: https://github.com/jenseng/immigrant/issues/31