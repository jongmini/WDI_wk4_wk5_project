class UsersController < ApplicationController

	def index
	end  

  def show
    @user = User.find(params[:id])
    @journey = @user.journeys
    @waypoints=[]
    render :show
  end

  def new
    @user = User.new()
  end

  def create
    new_user = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user=User.new(new_user)
    if @user.save
      flash[:success] = "Bike There!"
      sign_in @user
      redirect_to '/'
    else
      redirect_to '/'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    render :show
  end
end
