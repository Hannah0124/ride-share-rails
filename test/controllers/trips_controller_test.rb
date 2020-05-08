require "test_helper"
 
describe TripsController do
  before do
    driver = Driver.create(name: "Yoyo", vin: "12345")
    passenger = Passenger.create(name: "Hannah", phone_num: "1234567890")
    trip = Trip.create(passenger_id: passenger.id)
  end
 
  describe "show" do
    it "will get show for valid ids" do
      valid_trip_id = trip.id # not working
      get "/trips/#{valid_trip_id}"
      must_respond_with :success
    end
   
    it "will respond with not_found for invalid ids" do
      invalid_trip_id = -1
      get "/trips/#{invalid_trip_id}" # no show action yet
      must_respond_with :not_found
    end
  end
 
 describe "create" do
   # let (:driver_name) {
   #   drivers(:name)
   # }
   # let (:trip_hash) {
   #   {
   #     trip: {
   #       a: "",
   #       b: "etc"
   #     }
   #   }
   # }
 
   it "can create a trip" do
     # expect {post trips_path, params: trip_hash}.must_differ 'Trip.count', 1
     # must_redirect_to root_path
 
     # expect(Trip.last.a).must_equal trip_hash[:trip][:a], etc
   end
 
   it "will not create a trip with invalid params" do
     # trip_hash[:trip][:a] = nil
     # expect {
     #   post trips_path, params: trip_hash
     # }.must_differ "Trip.count", 0
 
     # must_respond_with :bad_request
   end
 
 end
 
 describe "edit" do
   # must_redirect_to edit_path
   # must_respond_with : success
 end
 
 describe "update" do
   # let (:new_trip_hash) {
   #   {
   #     trip: {
   #       a: "etc"
   #     },
   #   }
   # }
   it "will update a model with a valid post request" do
     # valid_id = Trip.first.id
     # expect {
   #     patch trip_path(id), params: new_trip_hash
   # }.wont_change "Trip.count"
   # must_respond_with :redirect
   # trip = Trip.find_by(id: id)
   # expect(trip.a).must_equal new_trip_hash[:trip][:a] etc
   end
   it "will respond with not_found for invalid ids" do
     # new_trip_hash[:trip][:a] = nil
     # trip = Trip.first
     # expect {
   #     patch trip_path(trip.id), params: new_trip_hash
   # }.wont_change "Trip.count"
   # trip.reload # refresh
   # must_respond_with :bad_request
   # expect(trip.a).wont_be_nil
   end
 end
 
 describe "destroy" do
   # let (:driver_name) {
   #   drivers(:name)
   # }
   # let (:trip_hash) {
   #   {
   #     trip: {
   #       a: "",
   #       b: "etc"
   #     }
   #   }
   # }
 
   # expect {destroy trips_path, params: Trip.first.id}.must_differ 'Trip.count', -1
   # must_redirect_to root_path
 end
end