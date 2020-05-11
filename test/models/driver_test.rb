require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "12345678901234567", available: true)
  }
  it "can be instantiated" do
    # Assert
    expect(new_driver.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_driver.save
    driver = Driver.first
    [:name, :vin, :available].each do |field|
      # Assert
      expect(driver).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many trips" do
      # Arrange
      new_driver.save
      new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
      trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
      
      # Assert
      expect(new_driver.trips.count).must_equal 2
      new_driver.trips.each do |trip|
        expect(trip).must_be_instance_of Trip
      end
    end
  end

  describe "validations" do
    it "must have a name" do
      # Arrange
      new_driver.name = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :name
      expect(new_driver.errors.messages[:name]).must_equal ["can't be blank", "is invalid"]
    end

    it "must have a VIN number" do
      # Arrange
      new_driver.vin = nil

      # Assert
      expect(new_driver.valid?).must_equal false
      expect(new_driver.errors.messages).must_include :vin
      expect(new_driver.errors.messages[:vin]).must_equal ["can't be blank", "is the wrong length (should be 17 characters)"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do

    describe "average rating" do
      it "successfully calculates average rating" do
        # Arrange
        newer_driver = Driver.create(name: "Karen", vin: "12345678901234567", available: true)
        new_passenger = Passenger.create(name: "Kevin", phone_num: "1234567890")
        trip_1 = Trip.create(driver_id: newer_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 1, cost: 1234)
        trip_2 = Trip.create(driver_id: newer_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 4321)
        # Assert
        expect(newer_driver.average_rating).must_equal 2 # not working
      end

      it "will return 0 as average if there are no ratings" do
        # Arrange
        newer_driver = Driver.create(name: "Karen", vin: "12345678901234567", available: true)
        # Assert
        expect(newer_driver.average_rating).must_equal 0
      end
    end

    describe "total earnings" do
      it "successfully calculates 80% of the trip cost after a fee of $1.65 is subtracted" do
        # Arrange
        newer_driver = Driver.create(name: "Karen", vin: "12345678901234567", available: true)
        new_passenger = Passenger.create(name: "Kevin", phone_num: "1234567890")
        trip_1 = Trip.create(driver_id: newer_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 1, cost: 12.34)
        # Assert
        expect(newer_driver.total_earnings).must_equal 8.552 # not working
      end
    end

    describe "can go online" do
      # Your code here
    end

    describe "can go offline" do
      # Your code here
    end

    # You may have additional methods to test
  end
end
