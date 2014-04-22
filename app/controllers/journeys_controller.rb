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
      Waypoint.create(way_lat: waypoint["A"], way_lng: waypoint["k"], journey_id: @journey.id)
      end
    end
    flash[:message]="Your journey has been saved"
    redirect_to '/bikethere'
  end
  def show
    @journey = Journey.find(params[:id])
    @waypoints=[]
  end
  def edit
    @journey = Journey.find(params[:id])
  end
  def update
    journey = Journey.find(params[:id])
    new_journey = params.require(:journey).permit(:name)
    journey.update_attributes(new_journey)
    user_id = current_user.id
    redirect_to "/users/#{user_id}"
  end

  def destroy
    journey = Journey.find(params[:id])
    # binding.pry
    journey.delete
    user_id = current_user.id
    redirect_to "/users/#{user_id}"
  end

end
