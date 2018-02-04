class LoginsController < ApplicationController
  
  def new
    
  end
  
  def create
    maker = Maker.find_by(email: params[:email])
    if maker && maker.authenticate(params[:password])
      session[:maker_id] = maker.id
      flash[:success] = "You are logged in"
      redirect_to maker_path(maker)
      
    else
      
      flash.now[:danger] = "Your email address or password does not match"
      render 'new'
      
    end
  end
  
  def destroy
    session[:maker_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
  
end