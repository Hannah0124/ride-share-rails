class PassengersController < ApplicationController
  def index 
    @passengers = Passenger.order(:id).all
  end 

  def show 
    passenger_id = params[:id] 
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil? 
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
      return 
    end
  end 

  def new 
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)

    if @passenger.save
      flash[:success] = "#{@passenger.name} was successfully added! 😄"
      redirect_to passenger_path(@passenger)
      return 
    else 
      flash.now[:error] = "The passenger was not succesfully added :("
      render :new
      return 
    end 
  end 

  def edit 
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    if @passenger.nil?
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found

      return 
    end
  end 

  def update 
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id) 

    if @passenger.nil? 
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found

      return 

    elsif @passenger.update(passenger_params) 
      redirect_to passenger_path(@passenger.id)
      return 

    else 
      render :edit
      return 
    end
  end

  def destroy 
    passenger_id = params[:id] 
    @passenger = Passenger.find_by(id: passenger_id) 

    if @passenger.nil?
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
      return 
    else 
      @passenger.destroy 
      redirect_to passengers_path 
      return 
    end
  end

  private 

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end 
end
