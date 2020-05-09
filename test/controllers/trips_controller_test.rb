require "test_helper"
 
describe TripsController do

  before do
    @driver = Driver.create(name: "Yoyo", vin: "12345")
    @passenger = Passenger.create(name: "Hannah", phone_num: "1234567890")
    @trip = Trip.create(driver_id: @driver.id, passenger_id: @passenger.id, date: Date.today, rating: 5, cost: 1234)
  end
 
  describe "show" do
    it "will get show for valid ids" do
      valid_trip_id = @trip.id
      get "/trips/#{valid_trip_id}" # no index action
      must_respond_with :success
    end
   
    it "will respond with not_found for invalid ids" do
      invalid_trip_id = -1
      get "/trips/#{invalid_trip_id}"
      must_respond_with :redirect
    end
  end
 
  describe "create" do

    new_passenger = Passenger.create(name: "Pengsoo", phone_num: "0987654321")
    new_driver = Driver.create(name: "Chiitan", vin: "54321")
    
    trip_hash = { 
      trip: {
        driver_id: new_driver.id,
        passenger_id: new_passenger.id,
        date: Date.today, 
          rating: 5, 
          cost: 1234
      } 
    }
   
    it "can create a trip" do
      expect {post trips_path, params: trip_hash}.must_differ 'Trip.count', 1 # NoMethodError: undefined method `[]=' for :bad_request:Symbol, Did you mean?  [], app/controllers/trips_controller.rb:26:in `create'
  
      expect(Trip.last.passenger_id).must_equal trip_hash[:trip][:passenger_id]

      must_respond_with :redirect
    end
   
    it "will not create a trip with invalid params" do
      trip_hash = {
        trip: { 
          driver_id: @driver.id,
          passenger_id: -1,
          date: Date.today, 
          rating: 5, 
          cost: 1234
        }
      }
      expect {
        post trips_path, params: trip_hash # NoMethodError: undefined method `[]=' for :bad_request:Symbol, Did you mean?  [], app/controllers/trips_controller.rb:26:in `create'
      }.wont_change "Trip.count"
      
      must_respond_with :bad_request
    end
  end
 
  describe "edit" do
    must_redirect_to edit_trip_path
    must_respond_with :success
  end
 
  describe "update" do

    new_trip_hash = {
      trip: {
        driver_id: Driver.first.id,
        passenger_id: Passenger.first.id, 
        date: "Fri, 08 May 2020", 
        rating: 1, 
        cost: 123
      }     
    }
    it "will update a model with a valid post request" do
      valid_id = Trip.first.id
      expect {
        patch trip_path(valid_id), params: new_trip_hash
      }.wont_change "Trip.count"
      
      trip = Trip.find_by(id: valid_id)
      expect(trip.driver_id).must_equal new_trip_hash[:trip][:driver_id]
      expect(trip.passenger_id).must_equal new_trip_hash[:trip][:passenger_id]
      expect(trip.date).must_equal new_trip_hash[:trip][:date]
      expect(trip.rating).must_equal new_trip_hash[:trip][:rating]
      expect(trip.cost).must_equal new_trip_hash[:trip][:cost]

      must_respond_with :redirect
    end
  
    it "will respond with not_found for invalid ids" do
      invalid_id = -1
      expect {
        patch trip_path(invalid_id), params: new_trip_hash
      }.wont_change "Trip.count"
      must_respond_with :redirect
    end
  end
 
  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do
      expect {delete trip_path, params: Trip.first.id}.must_differ 'Trip.count', -1 #  No route matches {:action=>"show", :controller=>"trips"}, missing required keys: [:id]
    end

    it "does not change the db when the trip does not exist, then responds with redirect" do
      invalid_id = -1
      expect {delete trip_path, params: invalid_id}.wont_change 'Trip.count' #  No route matches {:action=>"show", :controller=>"trips"}, missing required keys: [:id]

      must_respond_with :redirect
    end
  end
  
end