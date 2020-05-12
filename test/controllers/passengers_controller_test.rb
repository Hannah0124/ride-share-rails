require "test_helper"

describe PassengersController do
  describe "index" do
    it "responds with success when there are many passengers saved" do
      # Arrange
      # Ensure that there is at least one Passenger saved
      Passenger.create(name: "Hannah", phone_num: "1234567890")

      # Act
      get "/passengers"

      # Assert
      must_respond_with :success

    end

    it "responds with success when there are no passengers saved" do
      # Arrange
      # Ensure that there are zero passengers saved

      # Act
      get "/passengers"

      # Assert
      must_respond_with :success

    end
  end

  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      # Arrange
      # Ensure that there is a passenger saved
      passenger = Passenger.create(name: "Hannah", phone_num: "1234567890")

      # Act
      valid_id = passenger.id
      get "/passengers/#{valid_id}"

      # Assert
      must_respond_with :success

    end

    it "responds with 404 with an invalid passenger id" do
      # Arrange
      # Ensure that there is an id that points to no passenger
      invalid_id = -1

      # Act
      get "/passengers/#{invalid_id}"

      # Assert
      must_respond_with :not_found

    end
  end

  describe "new" do
    it "responds with success" do
      get new_passenger_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      passenger_hash = {
        passenger: {
          name: "Curmit", 
          phone_num: "1234567890"
        }
      }
      # Act-Assert
      # Ensure that there is a change of 1 in passenger.count
      expect {
        post passengers_path, params: passenger_hash
      }.must_differ 'Passenger.count', 1
      

      # Assert
      # Find the newly created passenger, and check that all its attributes match what was given in the form data
      passenger = Passenger.last
      expect(passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]
      # Check that the controller redirected the user
      must_redirect_to passenger_path(Passenger.find_by(name: "Curmit").id)

    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      # Arrange
      # Ensure there is an existing passenger saved
      passenger = Passenger.create(name: "Hannah", phone_num: "1234567890")

      # Act
      get edit_passenger_path(passenger.id)

      # Assert
      must_respond_with :success

    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      invalid_id = -1

      # Act
      get edit_passenger_path(invalid_id)

      # Assert
      must_respond_with :not_found

    end
  end

  describe "update" do
    it "can update an existing passenger with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing passenger saved
      # Assign the existing passenger's id to a local variable
      # Set up the form data
      passenger = Passenger.create(name: "Hannah", phone_num: "1234567890")
      passenger_id = passenger.id

      update_hash = {
        passenger: {
          name: "Hannah J", 
          phone_num: "1234567890"
        }
      }

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        patch passenger_path(passenger_id), params: update_hash
      }.wont_change 'Passenger.count'

      # Assert
      # Use the local variable of an existing passenger's id to find the passenger again, and check that its attributes are updated
      updated_passenger = Passenger.find_by(id: passenger_id)
      expect(updated_passenger.name).must_equal update_hash[:passenger][:name] # not working
      expect(updated_passenger.phone_num).must_equal update_hash[:passenger][:phone_num]
      # Check that the controller redirected the user
      must_respond_with :redirect

    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      # Set up the form data
      invalid_id = -1

      update_hash = {
        passenger: {
          name: "Hannah J", 
          phone_num: "1234567890"
        }
      }

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        patch passenger_path(invalid_id), params: update_hash
      }.wont_change 'Passenger.count'

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found

    end
  end

  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      # Arrange
      # Ensure there is an existing passenger saved
      passenger = Passenger.create(name: "Hannah", phone_num: "1234567890")

      # Act-Assert
      # Ensure that there is a change of -1 in passenger.count
      expect {
        delete passenger_path(passenger.id)
      }.must_differ 'Passenger.count', -1

      # Assert
      # Check that the controller redirects
      must_respond_with :redirect

    end

    it "does not change the db when the passenger does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no passenger
      invalid_id = -1

      # Act-Assert
      # Ensure that there is no change in passenger.count
      expect {
        delete passenger_path(invalid_id)
      }.wont_change 'Passenger.count'

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :not_found
    end
  end
end
