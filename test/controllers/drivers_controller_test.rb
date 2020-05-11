require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      Driver.create(name: "Yoyo", vin: "12345678901234567")

      # Act
      get "/drivers"

      # Assert
      must_respond_with :success

    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved

      # Act
      get "/drivers"

      # Assert
      must_respond_with :success

    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      # Ensure that there is a driver saved
      driver = Driver.create(name: "Yoyo", vin: "12345678901234567")

      # Act
      valid_id = driver.id
      get "/drivers/#{valid_id}"

      # Assert
      must_respond_with :success

    end

    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      invalid_id = -1

      # Act
      get "/drivers/#{invalid_id}"

      # Assert
      must_respond_with :redirect

    end
  end

  describe "new" do
    it "responds with success" do
      get new_driver_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      driver_hash = {
        driver: {
          name: "Yoyo", 
          vin: "12345678901234567"
        }
      }
      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.must_differ 'Driver.count', 1 # not working, why?
      

      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      driver = Driver.last
      expect(driver.name).must_equal driver_hash[:driver][:name]
      expect(driver.vin).must_equal driver_hash[:driver][:vin]
      # Check that the controller redirected the user
      must_redirect_to driver_path(Driver.find_by(name: "Yoyo").id)

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      driver_hash = {
        driver: {
          name: nil, 
          vin: nil
        }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        post drivers_path, params: driver_hash
      }.wont_change 'Driver.count'

      # Assert
      # Check that the controller redirects
      must_redirect_to drivers_path

    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      # Ensure there is an existing driver saved
      driver = Driver.create(name: "Yoyo", vin: "12345678901234567")

      # Act
      get "/drivers/#{driver.id}/edit"

      # Assert
      must_respond_with :success

    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      invalid_id = -1

      # Act
      get edit_driver_path(invalid_id)

      # Assert
      must_respond_with :redirect

    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data
      driver = Driver.create(name: "Yoyo", vin: "12345678901234567")
      driver_id = driver.id

      update_hash = {
        driver: {
          name: "Yo-Yo",
          vin: "12345678901234567"
        }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(driver_id), params: update_hash # bad request
      }.wont_change 'Driver.count'

      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      updated_driver = Driver.find_by(id: driver_id)
      expect(updated_driver.name).must_equal update_hash[:driver][:name] # NoMethodError: undefined method `[]' for nil:NilClass
      expect(updated_driver.vin).must_equal update_hash[:driver][:vin]
      # Check that the controller redirected the user
      must_respond_with :redirect

    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      # Set up the form data
      invalid_id = -1

      update_hash = {
        driver: {
          name: "Yo-Yo",
          vin: "12345678901234567"
        }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(invalid_id), params: update_hash
      }.wont_change 'Driver.count'

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :redirect

    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      driver = Driver.create(name: "Yoyo", vin: "12345678901234567")
      # Assign the existing driver's id to a local variable
      driver_id = driver.id
      # Set up the form data so that it violates Driver validations
      update_hash = {
        driver: {
          name: nil, 
          vin: nil
        }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(driver_id), params: update_hash # bad request
      }.wont_change 'Driver.count'

      # Assert
      # Check that the controller redirects
      must_respond_with :redirect

    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      driver = Driver.create(name: "Yoyo", vin: "12345678901234567")

      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect {
        delete driver_path(driver.id)
      }.must_differ 'Driver.count', -1

      # Assert
      # Check that the controller redirects
      must_respond_with :redirect

    end

    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      invalid_id = -1

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        delete driver_path(invalid_id)
      }.wont_change 'Driver.count'

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :redirect

    end
  end
end
