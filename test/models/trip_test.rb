require "test_helper"

describe Trip do

  let (:new_driver) {
    Driver.create(name: "Yoyo", vin: "12345")
  }
  let (:new_passenger) {
    Passenger.create(name: "Hannah", phone_num: "1234567890")
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
      expect(new_trip.errors.messages).must_include :driver_id
      expect(new_trip.errors.messages[:driver_id]).must_equal ["can't be blank"]
    end

    it "must have passenger_id" do
      # Arrange
      new_trip.passenger_id = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :passenger_id
      expect(new_trip.errors.messages[:passenger_id]).must_equal ["can't be blank"]
    end

    it "must have date" do
      # Arrange
      new_trip.date = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :date
      expect(new_trip.errors.messages[:date]).must_equal ["can't be blank"]
    end

    it "must have cost" do
      # Arrange
      new_trip.cost = nil

      # Assert
      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost]).must_equal ["can't be blank"]
    end   

  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
