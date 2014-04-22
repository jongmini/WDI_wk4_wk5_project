require "spec_helper"

describe BikesController do

describe "GET '/'" do
		
		it "should redirect_to '/bikethere'" do
			get ':index'
			expect(response).to redirect_to("/bikethere")
		end

	end

end
