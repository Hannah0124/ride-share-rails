class TripsController < ApplicationController

  def show 
    trip_id = params[:id] 
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil? 
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
      return 
    end
  end 

  def new 
    if params[:passenger_id] 
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trip = passenger.trips.new 
    else 
      @trip = Trip.new
    end 
  end

  def create 
    passenger = Passenger.find_by(id: params[:passenger_id])

    if passenger.nil?
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
    else 
      trip_data = Trip.connect_trip

      @trip = Trip.new({
        driver_id: trip_data[:driver_id],
        passenger_id: passenger.id,
        date: trip_data[:date],
        cost: trip_data[:cost]
      })

      if @trip.save
        redirect_to passenger_path(passenger)
        return 
      else 
        render :new
        return 
      end 
    end 
  end

  def edit 
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
      return 
    end
  end 

  def update 

    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id) 

    if @trip.nil? 
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found 
      return 

    elsif @trip.update(trip_params) 
      redirect_to trip_path(@trip.id)
      return 

    else 
      render :edit
      return 
    end
  end

  def destroy 
    trip_id = params[:id] 
    @trip = Trip.find_by(id: trip_id) 

    if @trip.nil?
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
      return 
    else 
      @trip.destroy 
      redirect_to passenger_path(@trip.passenger_id)
      return 
    end
  end

  private 

  def trip_params 
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
  end
end


# 404 reference: https://rubyinrails.com/2018/02/26/rails-render-404-not-found-from-controller-action/