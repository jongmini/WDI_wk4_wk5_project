class JourneysController < ApplicationController

  def new
    @journey = Journey.new
  end
  def create
    @list = []
    new_journey = params.require(:journey)
    signed_in? ? id = current_user.id : nil
    @journey = Journey.create(origin: new_journey["start"], destination: new_journey["end"], user_id: id)

    if !new_journey["waypoint"].nil? 
      new_journey["waypoint"].each do |key, waypoint|
      Waypoint.create(way_lat: waypoint["d"], way_lng: waypoint["e"], journey_id: @journey.id)
      end
    end
    flash[:message]="Your journey has been saved"

    redirect_to '/bikes'
  end
  def show
    @journey = Journey.find(params[:id])
  end
  # def edit
  #   @journey = Journey.find(params[:id])
  # end
  # def update
  #   @journey = Journey.find(params[:id])
  #   @journey.update_attributes(params[:journey])
  #   render :show
  # end

  def destroy
    journey = Journey.find(params[:id])
    # binding.pry
    journey.delete
    user_id = current_user.id
    redirect_to "/users/#{user_id}"
  end

end
