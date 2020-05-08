class DriversController < ApplicationController
  def index 
    @drivers = Driver.all
  end 

  def show 
    driver_id = params[:id] 
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil? 
      redirect_to root_path 
      return 
    end
  end 

  def new 
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)
  end 

  def edit 
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      redirect_to root_path 
      return 
    end
  end 

  def update 
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id) 

    if @driver.nil? 
      redirect_to root_path 
      return 

    elsif @driver.update(driver_params) 
      redirect_to driver_path(@driver.id)
      return 

    else 
      render :edit, :bad_request
      return 
    end
  end

  def destroy 
    driver_id = params[:id] 
    @driver = Driver.find_by(id: driver_id) 

    if @driver.nil?
      redirect_to root_path 
      return 
    else 
      @driver.destroy 
      redirect_to drivers_path 
      return 
    end
  end

  private

  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end
  
end

