require "test_helper"
require 'date'

describe TripsController do

  describe "show" do
    it "will get show for valid ids" do

      driver = Driver.create(name: "Yoyo", vin: "12345678901234567")
      passenger = Passenger.create(name: "Hannah", phone_num: "5554443333")
      trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 5, cost: 1234)

      valid_trip_id = trip.id
      get "/trips/#{valid_trip_id}"
      must_respond_with :success
    end

    it "will respond with not_found for invalid ids" do
      invalid_trip_id = -1
      get "/trips/#{invalid_trip_id}"
      must_respond_with :not_found
    end
  end

  describe "create" do

    it "can create a trip" do

      driver = Driver.create(name: "Yoyo", vin: "xyz45678901234567")
      passenger = Passenger.create(name: "Hannah", phone_num: "5554443333")
      
      trip_hash = { 
        trip: {
          driver_id: driver.id,
          passenger_id: passenger.id,
          date: Date.today, 
          cost: 1234
        } 
      }

      expect {
        post passenger_trips_path(passenger), params: trip_hash
      }.must_differ 'Trip.count', 1
  
      expect(Trip.last.passenger_id).must_equal trip_hash[:trip][:passenger_id]

      must_respond_with :redirect
    end

    it "will not create a trip with invalid params" do
      
      passenger = Passenger.create(name: "Hannah", phone_num: "5554443333")

      trip_hash = {
        trip: { 
          driver_id: nil,
          passenger_id: passenger.id,
          date: Date.today, 
          cost: 1234
        }
      }
      expect {
        post trips_path, params: trip_hash
      }.wont_change "Trip.count"
      
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "will succesfully load" do
      driver = Driver.create(name: "Yoyo", vin: "12345678901234567")
      passenger = Passenger.create(name: "Hannah", phone_num: "5554443333")
      trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 5, cost: 1234)

      get "/trips/#{trip.id}/edit"
      must_respond_with :success
    end 
  end

  describe "update" do
    let (:new_trip_hash) {
      {
        trip: {
          driver_id: Driver.first.id,
          passenger_id: Passenger.first.id, 
          date: "Fri, 08 May 2020", 
          rating: 1, 
          cost: 123
        }   
      }
    }

    it "will update a model with a valid post request" do

      driver = Driver.create(name: "Yoyo", vin: "12345678901234567")
      passenger = Passenger.create(name: "Hannah", phone_num: "5554443333")
      trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 5, cost: 1234)

      valid_id = trip.id
      expect {
        patch trip_path(valid_id), params: new_trip_hash
      }.wont_change "Trip.count"
      
      updated_trip = Trip.find_by(id: valid_id)
      expect(updated_trip.driver_id).must_equal new_trip_hash[:trip][:driver_id]
      expect(updated_trip.passenger_id).must_equal new_trip_hash[:trip][:passenger_id]
      expect(updated_trip.date).must_equal new_trip_hash[:trip][:date]
      expect(updated_trip.rating).must_equal new_trip_hash[:trip][:rating]
      expect(updated_trip.cost).must_equal new_trip_hash[:trip][:cost]

      must_respond_with :redirect
    end
  
    it "will respond with not_found for invalid ids" do
      invalid_id = -1
      expect {
        patch trip_path(invalid_id), params: new_trip_hash
      }.wont_change "Trip.count"
      must_respond_with :not_found
    end
  end

  describe "destroy" do

    driver = Driver.create(name: "Yoyo", vin: "12345678901234567")
    passenger = Passenger.create(name: "Hannah", phone_num: "5554443333")
    trip = Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: 5, cost: 1234)

    it "destroys the trip instance in db when trip exists, then redirects" do
      expect {delete trip_path(trip.id)}.must_differ 'Trip.count', -1
    end

    it "does not change the db when the trip does not exist, then responds with redirect" do
      invalid_id = -1
      expect {delete trip_path(invalid_id)}.wont_change 'Trip.count'

      must_respond_with :not_found
    end
  end
  
end