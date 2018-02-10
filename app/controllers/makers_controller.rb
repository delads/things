class MakersController < ApplicationController
  before_action :set_env
  before_action :set_maker, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin_user, only: [:index]
  
  
  def index
   @makers = Maker.all
   # require "stripe"
  
   # Stripe.api_key = @stripe_secret_api_key

   #  @account_list = Stripe::Account.list(:limit => 10)

    

  end
  
  def new 
    @maker = Maker.new
  end  
  
  def create
    @maker = Maker.new(maker_params)
    if @maker.save
      flash[:success] = "Your account has been created successfully"
      session[:maker_id] = @maker.id
      redirect_to maker_path(@maker)
    else
      render 'new'
    end
  end
  
  def edit

  end

  def update
    if @maker.update(maker_params)
      flash[:success] = "Your profile has been updated successfully"
      redirect_to maker_path(@maker)
    else
      render 'edit'
    end
  end
  
  def show
#    @thermostats = @merchant.products.paginate(page: params[:page], per_page: 3)
    @thermostats = @maker.thermostats
    
    
  end
  

  private
    def maker_params
      params.require(:maker).permit(:makername, :email, :password)
    end
    
    def set_maker
      @maker = Maker.find(params[:id])
    end
    
    def require_same_user
      if current_user != @maker
        flash[:danger] = "You can only edit your own profile"
        redirect_to root_path
      end
    end
    
    def require_admin_user
      if current_user.makername != 'admin'
        flash[:danger] = "Log in as admin to view this page"
        redirect_to login_path
      end
    end
    
    private def set_env
      # @stripe_secret_api_key = ENV['STRIPE_SECRET_API_KEY_TEST']
      # @stripe_publishable_api_key = ENV['STRIPE_PUBLISHABLE_API_KEY_TEST']
      # @stripe_client_id = ENV['STRIPE_CLIENT_ID_TEST']
    end

end