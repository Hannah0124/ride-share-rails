require "test_helper"

describe Driver do
  let (:new_driver) {
    Driver.new(name: "Pokemon Trainer", vin: "123xyz123iopuiozz", available: true)
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
      new_passenger = Passenger.create(name: "Elephant", phone_num: "567-394-3241")
      trip_1 = Trip.create(
        driver_id: new_driver.id, 
        passenger_id: new_passenger.id, 
        date: Date.today, 
        cost: 99
        )
      trip_2 = Trip.create(
        driver_id: new_driver.id, 
        passenger_id: new_passenger.id, 
        date: Date.today,  
        cost: 15
        )
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

    describe "total earnings" do
      it "successfully calculates 80% of the trip cost after a fee of $1.65 is subtracted" do
        # Arrange
        newer_driver = Driver.create(name: "Karen", vin: "321xxxxxxyyyyyy12", available: true)
        new_passenger = Passenger.create(name: "Kevin", phone_num: "1234567890")
        trip_1 = Trip.create(driver_id: newer_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 1, cost: 12.34)
        # Assert
        expect(newer_driver.total_earnings).must_equal 8.552 # not working
      end
    end

    describe "average rating" do
      it "successfully calculates average rating" do
        # Arrange
        newer_driver = Driver.create(name: "Karen", vin: "321eurizooor45321", available: true)
        new_passenger = Passenger.create(name: "Kevin", phone_num: "1234567890xxxxxxx")

        trip_1 = Trip.create(driver_id: newer_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 1.0, cost: 99)
        trip_2 = Trip.create(driver_id: newer_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3.0, cost: 18)

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

    describe "find_available_drivers" do
      it "returns available driver" do
        # set one available, one unavailable driver
        new_driver.save
      
        expect(Driver.find_available_drivers.available).must_equal true
        # expect(Driver.find_available_drivers).must_equal new_driver
      end
    end

    describe "sorted_trips_by_date" do
      it "shows trips in descending order" do
        new_driver.save
        new_passenger = Passenger.create(name: "Elephant", phone_num: "567-394-3241")
        trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
        trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
  
        expect(new_driver.sorted_trips_by_date.first).must_equal trip_2
        expect(new_driver.sorted_trips_by_date.last).must_equal trip_1
      end
    end

    describe "toggle_available" do
      it "updates driver to be available or unavailable" do
        new_driver.save

        new_driver.toggle_available
        expect(new_driver.available).must_equal false

        new_driver.toggle_available
        expect(new_driver.available).must_equal true   
      end
    end


    # You may have additional methods to test
    describe "num_of_rides" do 
      it "can count number of rides correctly" do 
        new_driver.save
        
        first_passenger = Passenger.first
        second_passenger = Passenger.find(2)
        third_passenger = Passenger.last

        Trip.create(driver_id: new_driver.id, passenger_id: first_passenger.id, date: Date.today, rating: 5, cost: 12)
        Trip.create(driver_id: new_driver.id, passenger_id: second_passenger.id, date: Date.today, rating: 5, cost: 50)
        Trip.create(driver_id: new_driver.id, passenger_id: third_passenger.id, date: Date.today, rating: 4, cost: 30)

        expect(new_driver.num_of_rides).must_be_instance_of Integer
        expect(new_driver.num_of_rides).must_equal 3
      end
    end
  end
end