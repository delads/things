class ThermostatsController < ApplicationController
before_action :set_thermostat, only: [:edit, :update, :show, :like, :destroy]
before_action :require_same_user, only: [:edit, :update]
before_action :set_maker, only: [:show, :destroy]

    
    def index
        
        @thermostats = Thermostat.all
    
    end
    
    def show
        @thermostat = Thermostat.find(params[:id])
        @shiftrsrc = "https://shiftr.io/" + @thermostat.namespace + "/embed?zoom=1"
    end
    
    def temp
        @thermostat = Thermostat.find(params[:id])
        render :text => @thermostat.temperature
    end
    
    def new
        @thermostat = Thermostat.new
        
        
    end
    
    def create
        @thermostat = Thermostat.new(thermostat_params)
        @thermostat.maker = current_user
     
        if @thermostat.save
          flash[:success] = "Your thermostat was created: " 
          redirect_to thermostats_path
          
        else
          render :new
        end
    end
    

    
    def update
        if @thermostat.update(thermostat_params)
          flash[:success] = "Your thermmostat was updated successfully!"
          redirect_to  thermostat_path(@thermostat)
        else
          render :edit
        end
    
    end
    
    def destroy
        Thermostat.find(params[:id]).destroy
        flash[:success] = "Thermostat deleted"
        redirect_to thermostats_path
    end
    
    
  
    def thermostat_params
      params.require(:thermostat).permit(:name, :max_temperature, :interval, :namespace, :mqtt_user, :mqtt_password)
    end
    
    def set_thermostat
      @thermostat = Thermostat.find(params[:id])
    end
    
    
    def set_maker
      @maker = @thermostat.maker
    end
    
    
    def require_same_user
      if current_user != @thermostat.maker
        flash[:danger] = "You can only edit your own products"
        redirect_to thermostats_path
      end
    end


end