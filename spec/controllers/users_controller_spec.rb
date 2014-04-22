require "spec_helper"

describe UsersController do
	
	describe "Get new" do
		before(:each) do
			@user = mock_model("User")
			allow(User).to receive(:new).and_return(@user) #expect Todo to "receive" a method new, then return the instance of todo
		end
		it "should assign @user" do
			get :new
			expect(assigns(:user)).to eq(@user)
		end
		it "should render :new templete" do

			get :new
			expect(response).to render_template("new")
		end
	end


	describe "POST create" do
		before(:each) do
			todo = mock_model("User")
			expect(User).to receive(:create).with({"name"=>"Sam", "email"=>"sam@email.com", 
				"password"=>"password", "password_confirmation"=>"password"})
		end
		it "should create a user" do
			post :create, {user: {"name"=>"Sam", "email"=>"sam@email.com", "password"=>"password", "password_confirmation"=>"password"}}
		end
		it "should redirect_to '/'" do
			post :create, {user: {"name"=>"Sam", "email"=>"sam@email.com", "password"=>"password", "password_confirmation"=>"password"}}
			expect(response).to redirect_to("/")
		end
	end

end