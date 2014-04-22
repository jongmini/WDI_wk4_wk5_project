require "spec_helper"

describe SessionsController do
	
	describe "POST create" do
		before(:each) do
			@user = mock_model("User")
			expect(User).to receive(:create).with({"email"=>"sam@email.com", "password"=>"password"})		
		end
		it "should create a new session" do
			post sign_in_path, :session => {:email_address => user.email_address, :password => user.password}
		end

	end


	describe "DELETE destory" do
		before(:each) do
			todo = mock_model("User")
			expect(User).to receive(:create).with({"email"=>"sam@email.com", "password"=>"password"})
		end
		it "should sign out a user" do
			# delete: destory
		end

	end

end