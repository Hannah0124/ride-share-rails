class DriversController < ApplicationController
  def index 
    @drivers = Driver.order(:id).all
  end 

  def show 
    driver_id = params[:id] 
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil? 
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
      return 
    end
  end 

  def new 
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)

    if @driver.save
      redirect_to driver_path(@driver)
      return 
    else 
      render :new
      return 
    end 
  end 

  def edit 
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)

    if @driver.nil?
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
      return 
    end
  end 

  def update 
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id) 

    if @driver.nil? 
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
      return 

    elsif @driver.update(driver_params) 
      redirect_to driver_path(@driver.id)
      return 

    else 
      render :edit
      return 
    end
  end

  def destroy 
    driver_id = params[:id] 
    @driver = Driver.find_by(id: driver_id) 

    if @driver.nil?
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
      return 
    else 
      @driver.destroy 
      redirect_to drivers_path 
      return 
    end
  end

  def toggle_available 
    driver_id = params[:id]

    @driver = Driver.find_by(id: driver_id)

    if @driver.nil? 
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
      return 
    else 
      @driver.toggle_available
      redirect_to driver_path(@driver) 
      return
    end 

    
    # elsif @driver.available
    #   @driver.update(available: false)
    # else 
    #   @driver.update(available: true)
    # end 

    # redirect_to driver_path(@driver) 
  end

  private 

  def driver_params
    return params.require(:driver).permit(:name, :vin, :available)
  end
end

