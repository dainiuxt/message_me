class UsersController < ApplicationController
	before_action :set_user
	before_action :require_user
	before_action :require_same_user

	def new
		@user = User.new
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:success] = "Your information updated successfully"
			redirect_to user_path
		else
			render 'edit'
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "Welcome to the MessageMe chat #{@user.username}!"
			redirect_to root_path
		else
			render 'new'
		end
	end

	def destroy
		@user.destroy
		session[:user_id] = nil if @user == current_user
		flash[:success] = "User account and all messages sucessfullly deleted. Sorry to see you go :("
		redirect_to login_path
	end

	private
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end

	def require_same_user
		if @user != current_user
			flash[:error] = "You can only see your own profile!"
			redirect_to root_path
		end
	end

end