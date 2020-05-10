require 'date'

class Trip < ApplicationRecord
  belongs_to :passenger 
  belongs_to :driver

  # validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6 }

  def self.connect_trip
    driver = Driver.find_available_drivers 
    driver.update(available: false)

    cost = rand(3..100)
    date = Date.today
  
    return {
      driver_id: driver.id,
      date: date,
      cost: cost
    }
  end
end
