class Driver < ApplicationRecord
  has_many :trips, dependent: :destroy

  validates :name, presence: true, format: { with: /\A[a-zA-Z\'\s]+\z/ }
  validates :vin, presence: true, length: { is: 17 }

  def total_earnings 
    return 0.00 if self.trips.length < 1
    return self.trips.sum { |trip| (trip.cost.to_f - 1.65) * 0.8 }    
  end

  def average_rating 
    length = self.trips.count  

    return 0 if length == 0 
      
    total_rating = self.trips.sum { |trip| p trip.rating.to_f }
    
    return (total_rating / length).round(1)
  end

  def self.find_available_drivers 
    return Driver.find_by(available: true)
  end

  def sorted_trips_by_date # descending order 
    return self.trips.order(date: :desc).all
  end
end


# reference (dependent): https://github.com/jenseng/immigrant/issues/31
# reference (validation): https://guides.rubyonrails.org/active_record_validations.html#length