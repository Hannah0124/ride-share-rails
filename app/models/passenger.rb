class Passenger < ApplicationRecord
  has_many :trips, dependent: :destroy

  validates :name, presence: true, format: { with: /\A[a-zA-Z\'\s]+\z/ }
  validates :phone_num, presence: true, uniqueness: true, format: { with: /.*(\d{3}).*(\d{3}).*(\d{4})/ }

  def total_charges 
    return self.trips.sum { |trip| p trip.cost.to_f }.round(2)
  end

  def sorted_trips_by_date # descending order 
    return self.trips.order(id: :desc).all
  end

  def num_of_rides 
    return self.trips.count
  end
end

  # reference: https://github.com/jenseng/immigrant/issues/31
  # phone_num regex: https://github.com/Ada-Developers-Academy/textbook-curriculum/blob/master/00-programming-fundamentals/solutions/regex.md#Escape%20Characters