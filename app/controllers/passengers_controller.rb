class PassengersController < ApplicationController
  def index 
    @passengers = Passenger.all
  end 

  def show 
    passenger_id = params[:id] 
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil? 
      redirect_to root_path 
      return 
    end
  end 

  def new 
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)
  end 

  def edit 
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      redirect_to root_path 
      return 
    end
  end 

  def update 
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id) 

    if @passenger.nil? 
      redirect_to root_path 
      return 

    elsif @passenger.update(passenger_params) 
      redirect_to passenger_path(@passenger.id)
      return 

    else 
      render :edit, :bad_request
      return 
    end
  end

  def destroy 
    passenger_id = params[:id] 
    @passenger = Passenger.find_by(id: passenger_id) 

    if @passenger.nil?
      redirect_to root_path 
      return 
    else 
      @passenger.destroy 
      redirect_to passengers_path 
      return 
    end
  end
end
