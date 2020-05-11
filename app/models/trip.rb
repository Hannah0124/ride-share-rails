require 'date'

class Trip < ApplicationRecord
  belongs_to :passenger 
  belongs_to :driver

  validates :date, presence: true
  validates :passenger_id, presence: true
  validates :driver_id, presence: true
  validates :cost, presence: true, numericality: true

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
