  require "typhoeus"
class UsersController < ApplicationController

	def index
	end  

  def show
    @user = User.find(params[:id])
    @journey = @user.journeys
    req =  Typhoeus::Request.new("http://maps.googleapis.com/maps/api/directions/json?origin=Boston,MA&destination=Concord,MA&waypoints=Charlestown,MA|Lexington,MA&sensor=false",
      method: :get,
      headers: { Accept: "json" }).run
    @json_stuff = req.body.to_json
    
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
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    render :show
  end
end
