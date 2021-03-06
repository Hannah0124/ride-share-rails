require "test_helper"

describe Trip do

  let (:new_driver) {
    Driver.create(name: "Yoyo", vin: "xxxxxyz1234567890")
  }
  let (:new_passenger) {
    Passenger.create(name: "Hannah", phone_num: "7893932233")
  }
  let (:new_trip) {
    Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
  }

  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    new_trip.save
    trip = Trip.first
    [:driver_id, :passenger_id, :date, :rating, :cost].each do |field|
      # Assert
      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do
    it "belongs to a driver and passenger" do
      expect(new_trip.passenger).must_be_instance_of Passenger
      expect(new_trip.driver).must_be_instance_of Driver
    end
  end

  describe "validations" do

    it "must have driver_id" do
      # Arrange
      new_trip.driver_id = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages[:driver_id]).must_equal ["can't be blank"]
    end

    it "must have passenger_id" do
      # Arrange
      new_trip.passenger_id = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages[:passenger_id]).must_equal ["can't be blank"]
    end

    it "must have date" do
      # Arrange
      new_trip.date = nil
      new_trip.save

      # Assert
      expect(new_trip.errors.messages[:date]).must_equal ["can't be blank"]
    end

    it "must have cost" do
      # Arrange
      new_trip.cost = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost]).must_equal ["can't be blank", "is not a number"]
    end   

  end

  describe "connect_trip" do
    it "returns driver_id, date and cost" do
      expect(Trip.connect_trip[:driver_id]).must_be_instance_of Integer
      expect(Trip.connect_trip[:date]).must_be_instance_of Date
      expect(Trip.connect_trip[:cost]).must_be_instance_of Integer
    end
  end
  
end