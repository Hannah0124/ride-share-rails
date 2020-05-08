require "test_helper"
 
describe TripsController do

  before do
    @driver = Driver.create(name: "Yoyo", vin: "12345")
    @passenger = Passenger.create(name: "Hannah", phone_num: "1234567890")
    @trip = Trip.create(passenger_id: @passenger.id)
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
      must_respond_with :not_found
    end
  end
 
  describe "create" do

    new_passenger = Passenger.create(name: "Pengsoo", phone_num: "0987654321")
    new_driver = Driver.create(name: "Chiitan", vin: "54321")
    
    trip_hash = { 
      trip: {
        passenger_id: new_passenger.id
      } 
    }
   
    it "can create a trip" do
      expect {post trips_path, params: trip_hash}.must_differ 'Trip.count', 1
  
      expect(Trip.last.passenger_id).must_equal trip_hash[:trip][:passenger_id]

      must_respond_with :redirect
    end
   
    it "will not create a trip with invalid params" do
      trip_hash = { 
        passenger_id: -1,    
      }
      expect {
        post trips_path, params: trip_hash
      }.wont_change "Trip.count"
      
      must_respond_with :redirect
    end
  end
 
  describe "edit" do
    # must_redirect_to edit_trip_path # not in routes yet
    # must_respond_with :success
  end
 
  describe "update" do
    new_trip_hash = {
      trip: {
        driver_id: Driver.first.id,
        passenger_id: Passenger.first.id, 
        date: Date.today, 
        rating: 1, 
        cost: 123
      }     
    }
    it "will update a model with a valid post request" do
      valid_id = Trip.first.id # not working
      expect {
        patch trip_path(valid_id), params: new_trip_hash
      }.wont_change "Trip.count"
      
      trip = Trip.find_by(id: valid_id)
      expect(trip).must_equal new_trip_hash[:trip][:driver_id]
      expect(trip).must_equal new_trip_hash[:trip][:passenger_id]
      expect(trip).must_equal new_trip_hash[:trip][:date]
      expect(trip).must_equal new_trip_hash[:trip][:rating]
      expect(trip).must_equal new_trip_hash[:trip][:cost]

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
    it "destroys the trip instance in db when trip exists, then redirects" do
      expect {delete trips_path, params: Trip.first.id}.must_differ 'Trip.count', -1 # doesn't work
    end

    it "does not change the db when the trip does not exist, then responds with redirect" do
      invalid_id = -1
      expect {delete trips_path, params: invalid_id}.wont_change 'Trip.count'

      must_respond_with :redirect
    end
  end
  
end